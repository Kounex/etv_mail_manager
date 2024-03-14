import 'package:base_components/base_components.dart';
import 'package:etv_mail_manager/views/import/signals/signals.dart';
import 'package:flutter/material.dart';
import 'package:signals_flutter/signals_flutter.dart';

class ValidatedMails extends StatelessWidget {
  const ValidatedMails({super.key});

  @override
  Widget build(BuildContext context) {
    return Watch(
      (context) => Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          BaseCard(
            leftPadding: 0,
            rightPadding: 0,
            bottomPadding: DesignSystem.spacing.x24,
            child: SizedBox(
              height: DesignSystem.size.x256 - 2 * DesignSystem.size.x18,
              child: ImportSignals().validatedMails.value.isNotEmpty
                  ? Scrollbar(
                      thumbVisibility: true,
                      child: SingleChildScrollView(
                        clipBehavior: Clip.hardEdge,
                        child: Padding(
                          padding:
                              EdgeInsets.only(right: DesignSystem.spacing.x12),
                          child: Wrap(
                            spacing: DesignSystem.spacing.x8,
                            runSpacing: DesignSystem.spacing.x8,
                            children: List.from(
                              ImportSignals().validatedMails.value.map(
                                    (mail) => Chip(
                                      label: Text(mail.address),
                                    ),
                                  ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : Center(
                      child: Text(
                        'No mails validated yet.',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const QuestionMarkTooltip(
                  message:
                      'When importing validated emails, the algorithm in the background will check for existing emails and only import new ones.'),
              SizedBox(width: DesignSystem.spacing.x12),
              SizedBox(
                width: DesignSystem.size.x128,
                child: BaseButton(
                  onPressed:
                      ImportSignals().validatedMails.isNotEmpty ? () {} : null,
                  text: 'Import',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
