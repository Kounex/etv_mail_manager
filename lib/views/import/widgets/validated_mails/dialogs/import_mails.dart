import 'package:base_components/base_components.dart';
import 'package:flutter/material.dart';

import '../../../../../app.dart';
import '../../../../../models/etv_mail/etv_mail.dart';
import '../../../../../models/etv_mail/service.dart';
import '../../../../../types/classes/validated_mail.dart';
import '../../../../../utils/signals.dart';
import '../../../signals/signals.dart';

class ImportMailsDialog extends StatelessWidget {
  const ImportMailsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return ConfirmationDialog(
      title: 'Import Emails',
      body: 'Are you sure you want to import the validated emails?',
      isYesDestructive: true,
      onYes: (_) {
        final mailsToAdd =
            ImportSignals().mailsByActions([ValidatedMailAction.add]);
        final mailsToActive =
            ImportSignals().mailsByActions([ValidatedMailAction.toActive]);

        List<ETVMail> updatedMails = ETVMailService()
                .mails
                .value
                .value
                ?.where((mail) => mailsToActive
                    .any((updateMail) => updateMail.address == mail.address))
                .map((mail) => mail.copyWith(
                      type: MailType.active,
                      commonReason: null,
                    ))
                .toList() ??
            [];

        SignalsUtils.handledAsyncTask(
          [
            ETVMailService().mailCreateBulk,
            ETVMailService().mailUpdateBulk,
          ],
          () => Future.wait([
            if (mailsToAdd.isNotEmpty) ETVMailService().createBulk(mailsToAdd),
            if (updatedMails.isNotEmpty)
              ETVMailService().updateBulk(updatedMails),
          ]),
          handleLoading: true,
          loadingMessage:
              'Importing ${updatedMails.isNotEmpty ? "& updating " : ""}mails...',
          then: (_) {
            if (!ETVMailService().mailUpdateBulk.value.hasError &&
                !ETVMailService().mailCreateBulk.value.hasError) {
              scaffoldMessengerKey.currentState!.showSnackBar(
                SnackBar(
                  content: Text(
                    '${[...mailsToAdd, ...mailsToActive].length} mail${[
                          ...mailsToAdd,
                          ...mailsToActive
                        ].length > 1 ? "s" : ""} imported!',
                  ),
                ),
              );
            }
          },
        );
      },
    );
  }
}
