import 'package:base_components/base_components.dart';
import 'package:etv_mail_manager/types/classes/validated_mail.dart';
import 'package:flutter/material.dart';
import 'package:signals_flutter/signals_flutter.dart';

import '../../../../models/etv_mail/etv_mail.dart';
import '../../../../models/etv_mail/service.dart';
import '../../../../utils/signals.dart';
import '../../signals/signals.dart';

class ValidatedMailsActions extends StatelessWidget {
  const ValidatedMailsActions({super.key});

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
              if (mailsToAdd.isNotEmpty)
                ETVMailService().createBulk(mailsToAdd),
              if (updatedMails.isNotEmpty)
                ETVMailService().updateBulk(updatedMails),
            ]),
            handleLoading: true,
            then: (_) {
              if (!ETVMailService().mailUpdateBulk.value.hasError &&
                  !ETVMailService().mailCreateBulk.value.hasError) {
                ScaffoldMessenger.of(context).showSnackBar(
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
          final mailsToRemoved =
              ImportSignals().mailsByActions([ValidatedMailAction.toRemoved]);

          if (mailsToRemoved.isNotEmpty) {
            List<ETVMail> updatedMails = ETVMailService()
                    .mails
                    .value
                    .value
                    ?.where((mail) => mailsToRemoved.any(
                        (updateMail) => updateMail.address == mail.address))
                    .map((mail) => mail.copyWith(
                        type: MailType.removed,
                        commonReason: CommonReason.leftBadminton))
                    .toList() ??
                [];

            SignalsUtils.handledAsyncTask(
              [
                ETVMailService().mailUpdateBulk,
              ],
              () => ETVMailService().updateBulk(updatedMails),
              handleLoading: true,
              then: (_) {
                if (!ETVMailService().mailUpdateBulk.value.hasError) {
                  ScaffoldMessenger.of(context).showSnackBar(
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final membershipExpiredCheckbox = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Watch(
          (_) => BaseCheckbox(
            value: ImportSignals().membershipExpiredMode.value,
            text: 'Membership expired',
            onChanged: (_) {
              ImportSignals().membershipExpiredMode.value =
                  !ImportSignals().membershipExpiredMode.value;
              ImportSignals().reactivateRemoved.value = false;
            },
          ),
        ),
        SizedBox(width: DesignSystem.spacing.x12),
        const QuestionMarkTooltip(
            message:
                'Without this checkbox, importing will add the validated emails and flag them as active. This is the default use case for importing emails.\n\nEvery time we get a new email list from ETV, we can also see all the people who ended their membership. Therefore we then need to be able to bulk update our existing emails and flag them accordingly. This checkbox will change the behaviour and match the validated emails with the existing ones and update those to be flagged as removed with the reason \'Left Badminton\'.'),
      ],
    );

    final reactivateRemovedCheckbox = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Watch(
          (_) => BaseCheckbox(
            value: ImportSignals().reactivateRemoved.value,
            text: 'Reactivate Member',
            onChanged: (_) {
              ImportSignals().reactivateRemoved.value =
                  !ImportSignals().reactivateRemoved.value;
              ImportSignals().membershipExpiredMode.value = false;
            },
          ),
        ),
        SizedBox(width: DesignSystem.spacing.x12),
        const QuestionMarkTooltip(
            message:
                'With this checkbox on, importing emails will not only add the new ones, but also reactivate members who are already added but currently in \'Removed\'. Those emails are marked orange!'),
      ],
    );

    final actionButtons = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: DesignSystem.size.x128,
          child: Watch(
            (_) => BaseButton(
                onPressed: ImportSignals().mailsByActions(
                        [ValidatedMailAction.toRemoved]).isNotEmpty
                    ? () => _leftBadmintonBatch(context)
                    : null,
                text: 'Update'),
          ),
        ),
        SizedBox(width: DesignSystem.spacing.x12),
        SizedBox(
          width: DesignSystem.size.x128,
          child: Watch(
            (_) => BaseButton(
              onPressed: ImportSignals().mailsByActions([
                ValidatedMailAction.add,
                ValidatedMailAction.toActive
              ]).isNotEmpty
                  ? () => _importMails(context)
                  : null,
              text: 'Import',
            ),
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
              reactivateRemovedCheckbox,
            ],
          ),
        _ => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  membershipExpiredCheckbox,
                  reactivateRemovedCheckbox,
                ],
              ),
              actionButtons,
            ],
          ),
      },
    );
  }
}
