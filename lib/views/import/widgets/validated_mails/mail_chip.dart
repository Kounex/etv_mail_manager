import 'package:etv_mail_manager/types/classes/validated_mail.dart';
import 'package:flutter/material.dart';

class MailChip extends StatelessWidget {
  final ValidatedMail validatedMail;

  const MailChip({super.key, required this.validatedMail});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(this.validatedMail.mail.address),
      backgroundColor: switch (this.validatedMail.action) {
        ValidatedMailAction.noAction => Colors.red[100],
        ValidatedMailAction.toActive => Colors.orange[100],
        _ => null,
      },
      labelStyle: switch (this.validatedMail.action) {
        ValidatedMailAction.noAction => const TextStyle(
            decoration: TextDecoration.lineThrough,
          ),
        _ => null,
      },
    );
  }
}
