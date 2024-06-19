import 'package:base_components/base_components.dart';
import 'package:flutter/material.dart';

import '../../../../models/etv_mail/etv_mail.dart';
import '../../../../models/etv_mail/service.dart';
import '../../signals/signals.dart';

class ValidatedMailsActions extends StatelessWidget {
  final Iterable<ETVMail> importableMails;

  const ValidatedMailsActions({
    super.key,
    required this.importableMails,
  });

  void _importMails(
    BuildContext context,
  ) {
    ModalUtils.showBaseDialog(
      context,
      ConfirmationDialog(
        title: 'Import Emails',
        body: 'Are you sure you want to import the validated emails?',
        isYesDestructive: true,
        onYes: (_) {
          if (this.importableMails.isNotEmpty) {
            ETVMailService()
                .createBulk(this.importableMails.toList())
                .then((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    '${this.importableMails.length} mail${this.importableMails.length > 1 ? "s" : ""} imported!',
                  ),
                ),
              );
            });
          }
        },
      ),
    );
  }

  void _leftBadmintonBatch(BuildContext context) {
    ModalUtils.showBaseDialog(
      context,
      ConfirmationDialog(
        title: 'Batch Left ETV',
        body:
            'Are you sure you want to batch update the validated emails to \'Left ETV\'?',
        isYesDestructive: true,
        onYes: (_) {
          if (this.importableMails.isNotEmpty) {
            List<ETVMail> updatedMails = ETVMailService()
                    .mails
                    .value
                    .value
                    ?.where((mail) => this.importableMails.any(
                        (updateMail) => updateMail.address == mail.address))
                    .map((mail) => mail.copyWith(
                        type: MailType.removed,
                        commonReason: CommonReason.leftBadminton))
                    .toList() ??
                [];

            if (updatedMails.isNotEmpty) {
              ETVMailService().updateBulk(updatedMails).then((_) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      '${updatedMails.length} mail${updatedMails.length > 1 ? "s" : ""} updated!',
                    ),
                  ),
                );
              });
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'No emails found to update!',
                  ),
                ),
              );
            }
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final membershipExpiredCheckbox = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        BaseCheckbox(
            value: ImportSignals().membershipExpiredMode.value,
            text: 'Membership expired',
            onChanged: (_) => ImportSignals().membershipExpiredMode.value =
                !ImportSignals().membershipExpiredMode.value),
        SizedBox(width: DesignSystem.spacing.x12),
        const QuestionMarkTooltip(
            message:
                'Without this checkbox, importing will add the validated emails and flag them as active. This is the default use case for importing emails.\n\nEvery time we get a new email list from ETV, we can also see all the people who ended their membership. Therefore we then need to be able to bulk update our existing emails and flag them accordingly. This checkbox will change the behaviour and match the validated emails with the existing ones and update those to be flagged as removed with the reason \'Left Badminton\'.'),
      ],
    );

    final actionButtons = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: DesignSystem.size.x128,
          child: BaseButton(
              onPressed: this.importableMails.isNotEmpty &&
                      ImportSignals().membershipExpiredMode.value
                  ? () => _leftBadmintonBatch(context)
                  : null,
              text: 'Update'),
        ),
        SizedBox(width: DesignSystem.spacing.x12),
        SizedBox(
          width: DesignSystem.size.x128,
          child: BaseButton(
            onPressed: this.importableMails.isNotEmpty &&
                    !ImportSignals().membershipExpiredMode.value
                ? () => _importMails(context)
                : null,
            text: 'Import',
          ),
        ),
      ],
    );

    return LayoutBuilder(
      builder: (context, constraints) => switch (constraints.maxWidth) {
        <= 512 => Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              actionButtons,
              SizedBox(height: DesignSystem.spacing.x8),
              membershipExpiredCheckbox,
            ],
          ),
        _ => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              membershipExpiredCheckbox,
              actionButtons,
            ],
          ),
      },
    );
  }
}
