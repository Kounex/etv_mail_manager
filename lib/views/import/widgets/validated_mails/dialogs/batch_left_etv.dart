import 'package:base_components/base_components.dart';
import 'package:etv_mail_manager/app.dart';
import 'package:flutter/material.dart';

import '../../../../../models/etv_mail/etv_mail.dart';
import '../../../../../models/etv_mail/service.dart';
import '../../../../../types/classes/validated_mail.dart';
import '../../../../../utils/signals.dart';
import '../../../signals/signals.dart';

class BatchLeftETVDialog extends StatelessWidget {
  final BuildContext parentContext;

  const BatchLeftETVDialog({
    super.key,
    required this.parentContext,
  });

  @override
  Widget build(BuildContext context) {
    return ConfirmationDialog(
      title: 'Batch Left ETV',
      body:
          'Are you sure you want to batch update the validated emails to \'Left ETV\'?',
      isYesDestructive: true,
      onYes: (_) {
        final mailsToRemoved =
            ImportSignals().mailsByActions([ValidatedMailAction.toRemoved]);

        if (mailsToRemoved.isNotEmpty) {
          List<ETVMail> updatedMails = ETVMailService()
                  .mails
                  .value
                  .value
                  ?.where((mail) => mailsToRemoved
                      .any((updateMail) => updateMail.address == mail.address))
                  .map((mail) => mail.copyWith(
                      type: MailType.removed,
                      commonReason: CommonReason.leftBadminton))
                  .toList() ??
              [];

          SignalsUtils.handledAsyncTask(
            this.parentContext,
            [
              ETVMailService().mailUpdateBulk,
            ],
            () => ETVMailService().updateBulk(updatedMails),
            handleLoading: true,
            then: (_) {
              if (!ETVMailService().mailUpdateBulk.value.hasError) {
                scaffoldMessengerKey.currentState!.showSnackBar(
                  SnackBar(
                    content: Text(
                      '${updatedMails.length} mail${updatedMails.length > 1 ? "s" : ""} updated!',
                    ),
                  ),
                );
              }
            },
          );
        }
      },
    );
  }
}
