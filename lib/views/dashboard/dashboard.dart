import 'package:base_components/base_components.dart';
import 'package:etv_mail_manager/utils/signals.dart';
import 'package:flutter/material.dart';

import '../../models/etv_mail/etv_mail.dart';
import '../../models/etv_mail/service.dart';
import 'widgets/mail_box.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  @override
  void initState() {
    super.initState();

    SignalsUtils.handleAsync(
      context,
      ETVMailService().mailAddOrEdit,
    );

    SignalsUtils.handleAsync(
      context,
      ETVMailService().mailDelete,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WebScaffold(
      children: [
        const MailBox(),
        ElevatedButton(
          onPressed: () => ETVMailService().create(
            mail: ETVMail(address: 'lolwhut@web.de'),
          ),
          child: const Text('New E-Mail'),
        ),
      ],
    );
  }
}
