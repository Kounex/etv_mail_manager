import 'package:base_components/base_components.dart';
import 'package:etv_mail_manager/models/etv_mail/service.dart';
import 'package:etv_mail_manager/views/import/signals/signals.dart';
import 'package:etv_mail_manager/widgets/common_card_child_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:signals_flutter/signals_flutter.dart';

import '../../../models/etv_mail/etv_mail.dart';

class ValidatedMails extends StatefulWidget {
  const ValidatedMails({super.key});

  @override
  State<ValidatedMails> createState() => _ValidatedMailsState();
}

class _ValidatedMailsState extends State<ValidatedMails> {
  void _importMails() {
    List<ETVMail> createMails = [];
    for (final mail in ImportSignals().validatedMails.value) {
      if (ETVMailService().mails.value.value == null ||
          !ETVMailService()
              .mails
              .value
              .value!
              .any((existingMail) => existingMail.address == mail.address)) {
        createMails.add(mail);
      }
    }

    ETVMailService().createBulk(createMails: createMails);
  }

  @override
  Widget build(BuildContext context) {
    return BaseConstrainedBox(
      child: Watch(
        (context) => Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            BaseCard(
              leftPadding: 0,
              rightPadding: 0,
              bottomPadding: DesignSystem.spacing.x12,
              paddingChild: const EdgeInsets.all(0),
              centerChild: false,
              child: ImportSignals().validatedMails.value.isNotEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: DesignSystem.spacing.x8,
                            horizontal: DesignSystem.spacing.x18,
                          ),
                          child: Text(
                            '${ImportSignals().validatedMails.value.length} mail${ImportSignals().validatedMails.value.length == 1 ? "" : "s"} ready to be imported',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        const BaseDivider(),
                        CommonCardChildWrapper(
                          child: Padding(
                            padding: EdgeInsets.all(DesignSystem.spacing.x18),
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
                      ],
                    )
                  : CommonCardChildWrapper(
                      scrollable: false,
                      child: Center(
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
                    onPressed: ImportSignals().validatedMails.isNotEmpty
                        ? _importMails
                        : null,
                    text: 'Import',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
