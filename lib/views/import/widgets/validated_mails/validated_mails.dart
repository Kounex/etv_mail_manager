import 'package:base_components/base_components.dart';
import 'package:etv_mail_manager/types/classes/validated_mail.dart';
import 'package:etv_mail_manager/views/import/signals/signals.dart';
import 'package:etv_mail_manager/views/import/widgets/validated_mails/actions.dart';
import 'package:etv_mail_manager/views/import/widgets/validated_mails/mail_chip.dart';
import 'package:etv_mail_manager/widgets/base_card_common_child.dart';
import 'package:flutter/material.dart';
import 'package:signals_flutter/signals_flutter.dart';

class ValidatedMails extends StatefulWidget {
  const ValidatedMails({super.key});

  @override
  State<ValidatedMails> createState() => _ValidatedMailsState();
}

class _ValidatedMailsState extends State<ValidatedMails> {
  @override
  Widget build(BuildContext context) {
    return BaseConstrainedBox(
      child: Watch((context) {
        final amountImportableMails = ImportSignals()
            .validatedMails
            .value
            .where((mail) => mail.action != ValidatedMailAction.noAction)
            .length;

        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            BaseCard(
              topPadding: 0,
              leftPadding: 0,
              rightPadding: 0,
              bottomPadding: DesignSystem.spacing.x12,
              paddingChild: const EdgeInsets.all(0),
              centerChild: false,
              child: ImportSignals().mails.value.isNotEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: DesignSystem.spacing.x8,
                            horizontal: DesignSystem.spacing.x18,
                          ),
                          child: Text(
                            '$amountImportableMails mail${amountImportableMails == 1 ? "" : "s"} ready to be ${ImportSignals().membershipExpiredMode.value ? "updated" : "imported"}',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        const BaseDivider(),
                        BaseCardCommonChild(
                          child: Padding(
                            padding: EdgeInsets.all(DesignSystem.spacing.x18),
                            child: Wrap(
                              spacing: DesignSystem.spacing.x8,
                              runSpacing: DesignSystem.spacing.x8,
                              children: List.from(
                                ImportSignals().validatedMails.value.map(
                                      (mail) => MailChip(validatedMail: mail),
                                    ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : BaseCardCommonChild(
                      scrollable: false,
                      child: Center(
                        child: BasePlaceholder(
                          text: 'No mails validated yet!',
                          iconSize: DesignSystem.size.x42,
                        ),
                      ),
                    ),
            ),
            const ValidatedMailsActions(),
          ],
        );
      }),
    );
  }
}
