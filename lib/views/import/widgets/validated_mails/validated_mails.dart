import 'package:base_components/base_components.dart';
import 'package:etv_mail_manager/models/etv_mail/service.dart';
import 'package:etv_mail_manager/views/import/signals/signals.dart';
import 'package:etv_mail_manager/views/import/widgets/validated_mails/actions.dart';
import 'package:etv_mail_manager/widgets/common_card_child_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:signals_flutter/signals_flutter.dart';

import '../../../../models/etv_mail/etv_mail.dart';

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

  bool _mailCanSetExpired(ETVMail mail) =>
      ETVMailService().mails.value.value != null &&
      ETVMailService().mails.value.value!.any((existingMail) =>
          existingMail.address == mail.address &&
          existingMail.commonReason != CommonReason.leftBadminton);

  @override
  Widget build(BuildContext context) {
    return BaseConstrainedBox(
      child: Watch((context) {
        final isValid = ImportSignals().membershipExpiredMode.value
            ? _mailCanSetExpired
            : _mailIsNew;

        Iterable<ETVMail> importableMails =
            ImportSignals().validatedMails.value.where(isValid);

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
                                        backgroundColor: !isValid(mail)
                                            ? Colors.red[100]
                                            : null,
                                        labelStyle: !isValid(mail)
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
                        child: BasePlaceholder(
                          text: 'No mails validated yet!',
                          iconSize: DesignSystem.size.x42,
                        ),
                      ),
                    ),
            ),
            ValidatedMailsActions(importableMails: importableMails),
          ],
        );
      }),
    );
  }
}
