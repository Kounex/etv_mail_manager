import 'package:base_components/base_components.dart';
import 'package:etv_mail_manager/models/etv_mail/etv_mail.dart';
import 'package:etv_mail_manager/views/dashboard/widgets/mail_box/content.dart';
import 'package:etv_mail_manager/views/dashboard/widgets/mail_box/title.dart';
import 'package:flutter/material.dart';
import 'package:signals_flutter/signals_flutter.dart';

import '../../../../models/etv_mail/service.dart';

class MailBox extends StatefulWidget {
  final MailType type;

  const MailBox({
    super.key,
    this.type = MailType.active,
  });

  @override
  State<MailBox> createState() => _MailBoxState();
}

class _MailBoxState extends State<MailBox> {
  late final CustomValidationTextEditingController _controller;

  Iterable<ETVMail>? _filteredMails;

  @override
  void initState() {
    super.initState();

    _controller = CustomValidationTextEditingController()
      ..addListener(() {
        if (mounted) {
          setState(() {});
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Watch((context) {
      Iterable<ETVMail>? mails = ETVMailService()
          .mails
          .value
          .value
          ?.where((mail) => mail.type == this.widget.type);

      _filteredMails = mails?.where((mail) => mail.address
          .toLowerCase()
          .contains(_controller.text.toLowerCase().trim()));

      return BaseCard(
        titleWidget: MailBoxTitle(mails: mails),
        titleStyle: Theme.of(context).textTheme.bodyLarge,
        leftPadding: 0,
        rightPadding: 0,
        paddingChild: const EdgeInsets.all(0),
        initialExpanded: false,
        centerChild: false,
        trailingTitleWidget: Padding(
          padding: EdgeInsets.only(right: DesignSystem.spacing.x12),
          child: TagBox(
            color: this.widget.type.color,
            label: this.widget.type.name,
          ),
        ),
        child: MailBoxContent(
          controller: _controller,
          filteredMails: _filteredMails,
        ),
      );
    });
  }
}
