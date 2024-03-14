import 'package:base_components/base_components.dart';
import 'package:etv_mail_manager/models/etv_mail/etv_mail.dart';
import 'package:flutter/material.dart';
import 'package:signals_flutter/signals_flutter.dart';

import '../../../models/etv_mail/service.dart';

class MailBox extends StatelessWidget {
  final MailType type;

  const MailBox({
    super.key,
    this.type = MailType.available,
  });

  @override
  Widget build(BuildContext context) {
    return Watch((context) {
      Iterable<ETVMail>? mails = ETVMailService()
          .mails
          .value
          .value
          ?.where((mail) => mail.type == this.type);

      return BaseCard(
        title: '${mails?.length ?? 0} mail(s)',
        titleStyle: Theme.of(context).textTheme.bodyLarge,
        leftPadding: 0,
        rightPadding: 0,
        initialExpanded: false,
        expandable: mails != null && mails.isNotEmpty,
        centerChild: false,
        trailingTitleWidget: Padding(
          padding: EdgeInsets.only(right: DesignSystem.spacing.x12),
          child: TagBox(
            color: this.type.color,
            label: this.type.name,
          ),
        ),
        child: Align(
          alignment: Alignment.topLeft,
          child: Wrap(
            children: List.from(
              mails?.map(
                    (mail) => Chip(
                      label: Text(mail.address),
                    ),
                  ) ??
                  [],
            ),
          ),
        ),
      );
    });
  }
}
