import 'package:etv_mail_manager/router/view.dart';
import 'package:etv_mail_manager/widgets/etv_scaffold.dart';
import 'package:flutter/material.dart';

import '../../models/etv_mail/etv_mail.dart';
import '../../models/etv_mail/service.dart';
import '../../utils/signals.dart';
import 'widgets/mail_box/mail_box.dart';

class DashboardView extends RouterStatefulView {
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

    SignalsUtils.handleAsync(
      context,
      ETVMailService().mailDeleteBulk,
      handleLoading: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return const ETVScaffold(
      children: [
        MailBox(type: MailType.active),
        MailBox(type: MailType.unreachable),
        MailBox(type: MailType.removed),
        // SizedBox(height: DesignSystem.spacing.x64),
        // const DeleteAllButton(),
      ],
    );
  }
}
