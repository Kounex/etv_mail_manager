import 'package:base_components/base_components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../models/etv_mail/etv_mail.dart';
import '../../../../widgets/base_card_common_child.dart';
import 'dialogs/edit.dart';

class MailBoxContent extends StatelessWidget {
  final CustomValidationTextEditingController controller;
  final Iterable<ETVMail>? filteredMails;

  const MailBoxContent({
    super.key,
    required this.controller,
    this.filteredMails,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Padding(
            padding: EdgeInsets.all(DesignSystem.spacing.x18),
            child: BaseAdaptiveTextField(
              controller: this.controller,
              platform: TargetPlatform.iOS,
              clearButton: true,
              placeholder: 'Filter...',
            ),
          ),
        ),
        const BaseDivider(),
        BaseCardCommonChild(
          paddingForScrollbar: false,
          children: this.filteredMails != null && this.filteredMails!.isNotEmpty
              ? List.from(
                  this.filteredMails!.map(
                        (mail) => ListTile(
                          onTap: () => ModalUtils.showBaseDialog(
                            context,
                            MailBoxEditDialog(mail: mail),
                          ),
                          title: Text(mail.address),
                          trailing: mail.commonReason != null ||
                                  mail.reason != null && mail.reason!.isNotEmpty
                              ? Tooltip(
                                  message:
                                      mail.reason ?? mail.commonReason?.text,
                                  child: const Icon(CupertinoIcons.text_bubble),
                                )
                              : null,
                        ),
                      ),
                )
              : null,
          child: this.filteredMails == null || this.filteredMails!.isEmpty
              ? Center(
                  child: Column(
                    children: [
                      SizedBox(height: DesignSystem.spacing.x32),
                      BasePlaceholder(
                        text: 'No mails found!',
                        iconSize: DesignSystem.size.x42,
                      ),
                      SizedBox(height: DesignSystem.spacing.x32),
                    ],
                  ),
                )
              : null,
        ),
        // const BaseDivider(),
        // const Align(
        //   alignment: Alignment.centerRight,
        //   child: BaseButton(isDestructive: true, text: 'Clear',),
        // ),
      ],
    );
  }
}
