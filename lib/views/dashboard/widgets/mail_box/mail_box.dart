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

  @override
  void initState() {
    super.initState();

    _controller = CustomValidationTextEditingController()
      ..addListener(() {
        if (this.mounted) {
          /// TODO: only necessary because [Watch] does not rebuild on setState:
          /// https://github.com/rodydavis/signals.dart/pull/303
          ETVMailService().mails.refresh();
          setState(() {});
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Watch(
      (context) {
        Iterable<ETVMail>? mails = ETVMailService()
            .mails
            .value
            .value
            ?.where((mail) => mail.type == this.widget.type);

        Iterable<ETVMail>? filteredMails = mails?.where((mail) => mail.address
            .toLowerCase()
            .contains(_controller.text.toLowerCase().trim()));

        return BaseCard(
          titleWidget: MailBoxTitle(
            type: this.widget.type,
            mails: filteredMails,
            isFiltered: (filteredMails?.length ?? 0) != (mails?.length ?? 0),
          ),
          titleStyle: Theme.of(context).textTheme.bodyLarge,
          leftPadding: 0,
          rightPadding: 0,
          paddingChild: const EdgeInsets.all(0),
          initialExpanded: false,
          centerChild: false,
          child: MailBoxContent(
            controller: _controller,
            filteredMails: filteredMails,
          ),
        );
      },
    );
  }
}
