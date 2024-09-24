import 'package:etv_mail_manager/models/etv_mail/etv_mail.dart';

class ValidatedMail {
  final ETVMail mail;
  final ValidatedMailAction action;

  ValidatedMail(this.mail, this.action);
}

enum ValidatedMailAction {
  add,
  toRemoved,
  toActive,
  noAction,
}
