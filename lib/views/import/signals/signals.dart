import 'package:etv_mail_manager/models/etv_mail/etv_mail.dart';
import 'package:signals/signals.dart';

class ImportSignals {
  static ImportSignals? _instance;

  final validatedMails = SetSignal<ETVMail>({});
  final wrongMails = SetSignal<String>({});

  ImportSignals._();

  factory ImportSignals() => _instance ??= ImportSignals._();
}
