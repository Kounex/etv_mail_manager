import 'package:base_components/base_components.dart';
import 'package:etv_mail_manager/types/classes/validated_mail.dart';
import 'package:etv_mail_manager/views/import/widgets/validated_mails/dialogs/batch_left_etv.dart';
import 'package:etv_mail_manager/views/import/widgets/validated_mails/dialogs/import_mails.dart';
import 'package:flutter/material.dart';
import 'package:signals_flutter/signals_flutter.dart';

import '../../signals/signals.dart';

class ValidatedMailsActions extends StatelessWidget {
  const ValidatedMailsActions({super.key});

  void _importMails(
    BuildContext context,
  ) {
    ModalUtils.showBaseDialog(
      context,
      ImportMailsDialog(parentContext: context),
    );
  }

  void _leftBadmintonBatch(BuildContext context) {
    ModalUtils.showBaseDialog(
      context,
      BatchLeftETVDialog(parentContext: context),
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
