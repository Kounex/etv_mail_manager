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
  bool _mailIsNew(ETVMail mail) =>
      ETVMailService().mails.value.value == null ||
      !ETVMailService()
          .mails
          .value
          .value!
          .any((existingMail) => existingMail.address == mail.address);

  void _importMails(Iterable<ETVMail> mails) {
    ModalUtils.showBaseDialog(
      context,
      ConfirmationDialog(
        title: 'Import Emails',
        body: 'Are you sure you want to import the validated emails?',
        onYes: (_) {
          if (mails.isNotEmpty) {
            ETVMailService().createBulk(mails.toList()).then((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    '${mails.length} mail${mails.length > 1 ? "s" : ""} imported!',
                  ),
                ),
              );
            });
          }
        },
      ),
    );
  }

  void _leftBadmintonBatch(Iterable<ETVMail> mails) {
    ModalUtils.showBaseDialog(
      context,
      ConfirmationDialog(
        title: 'Batch Left ETV',
        body:
            'Are you sure you want to batch update the validated emails to \'Left ETV\'?',
        onYes: (_) {
          if (mails.isNotEmpty) {
            List<ETVMail> updatedMails = mails
                .where((mail) => !_mailIsNew(mail))
                .map((mail) => mail.copyWith(
                    type: MailType.removed,
                    commonReason: CommonReason.leftBadminton))
                .toList();

            if (updatedMails.isNotEmpty) {
              ETVMailService().updateBulk(updatedMails).then((_) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      '${mails.length} mail${mails.length > 1 ? "s" : ""} updated!',
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
    return BaseConstrainedBox(
      child: Watch((context) {
        Iterable<ETVMail> importableMails = ImportSignals()
            .validatedMails
            .value
            .where((mail) => ImportSignals().membershipExpiredMode.value
                ? !_mailIsNew(mail)
                : _mailIsNew(mail));

        return Column(
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
                            '${importableMails.length} mail${importableMails.length == 1 ? "" : "s"} ready to be ${ImportSignals().membershipExpiredMode.value ? "updated" : "imported"}',
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
                                        backgroundColor: (ImportSignals()
                                                    .membershipExpiredMode
                                                    .value
                                                ? _mailIsNew(mail)
                                                : !_mailIsNew(mail))
                                            ? Colors.red[100]
                                            : null,
                                        labelStyle: (ImportSignals()
                                                    .membershipExpiredMode
                                                    .value
                                                ? _mailIsNew(mail)
                                                : !_mailIsNew(mail))
                                            ? const TextStyle(
                                                decoration:
                                                    TextDecoration.lineThrough,
                                              )
                                            : null,
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    BaseCheckbox(
                        value: ImportSignals().membershipExpiredMode.value,
                        text: 'Membership expired',
                        onChanged: (_) =>
                            ImportSignals().membershipExpiredMode.value =
                                !ImportSignals().membershipExpiredMode.value),
                    SizedBox(width: DesignSystem.spacing.x12),
                    const QuestionMarkTooltip(
                        message:
                            'Without this checkbox, importing will add the validated emails and flag them as active. This is the default use case for importing emails.\n\nEvery time we get a new email list from ETV, we can also see all the people who ended their membership. Therefore we then need to be able to bulk update our existing emails and flag them accordingly. This checkbox will change the behaviour and match the validated emails with the existing ones and update those to be flagged as removed with the reason \'Left Badminton\'.'),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: DesignSystem.size.x128,
                      child: BaseButton(
                          onPressed: importableMails.isNotEmpty &&
                                  ImportSignals().membershipExpiredMode.value
                              ? () => _leftBadmintonBatch(importableMails)
                              : null,
                          text: 'Update'),
                    ),
                    SizedBox(width: DesignSystem.spacing.x12),
                    SizedBox(
                      width: DesignSystem.size.x128,
                      child: BaseButton(
                        onPressed: importableMails.isNotEmpty &&
                                !ImportSignals().membershipExpiredMode.value
                            ? () => _importMails(importableMails)
                            : null,
                        text: 'Import',
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        );
      }),
    );
  }
}
