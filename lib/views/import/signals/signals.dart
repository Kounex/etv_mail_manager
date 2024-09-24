import 'package:etv_mail_manager/models/etv_mail/etv_mail.dart';
import 'package:signals/signals.dart';

import '../../../models/etv_mail/service.dart';
import '../../../types/classes/validated_mail.dart';

class ImportSignals {
  static ImportSignals? _instance;

  final mails = SetSignal<ETVMail>({});
  final wrongMails = SetSignal<String>({});
  final validatedMails = computed<List<ValidatedMail>>(() {
    final validatedMails = <ValidatedMail>[];
    for (final mail in ImportSignals().mails.value) {
      ValidatedMailAction action = ValidatedMailAction.noAction;

      if (ImportSignals().membershipExpiredMode.value) {
        if (_mailCanSetExpired(mail)) action = ValidatedMailAction.toRemoved;
      } else {
        if (_mailIsNew(mail)) {
          action = ValidatedMailAction.add;
        } else if (ImportSignals().reactivateRemoved.value &&
            _mailIsRemoved(mail)) {
          action = ValidatedMailAction.toActive;
        }
      }

      validatedMails.add(ValidatedMail(mail, action));
    }
    return validatedMails;
  });

  final membershipExpiredMode = Signal(false);
  final reactivateRemoved = Signal(false);

  // final disposeCheckbox = effect(() {
  //   if (ImportSignals().membershipExpiredMode.value) {
  //     ImportSignals().reactivateRemoved.value = false;
  //   }
  //   if (ImportSignals().reactivateRemoved.value) {
  //     ImportSignals().membershipExpiredMode.value = false;
  //   }
  // });

  ImportSignals._();

  factory ImportSignals() => _instance ??= ImportSignals._();

  List<ETVMail> mailsByActions(List<ValidatedMailAction> actions) => this
      .validatedMails
      .value
      .where((validatedMail) =>
          actions.any((action) => action == validatedMail.action))
      .map((validatedMail) => validatedMail.mail)
      .toList();
}

bool _mailIsNew(ETVMail mail) =>
    ETVMailService().mails.value.value == null ||
    !ETVMailService()
        .mails
        .value
        .value!
        .any((existingMail) => existingMail.address == mail.address);

bool _mailIsRemoved(ETVMail mail) =>
    ETVMailService().mails.value.value != null &&
    ETVMailService().mails.value.value!.any((existingMail) =>
        existingMail.address == mail.address &&
        existingMail.type == MailType.removed);

bool _mailCanSetExpired(ETVMail mail) =>
    ETVMailService().mails.value.value != null &&
    ETVMailService().mails.value.value!.any((existingMail) =>
        existingMail.address == mail.address &&
        existingMail.commonReason != CommonReason.leftBadminton);
