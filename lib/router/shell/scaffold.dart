import 'package:base_components/base_components.dart';
import 'package:etv_mail_manager/models/etv_mail/service.dart';
import 'package:etv_mail_manager/router/shell/drawer.dart';
import 'package:etv_mail_manager/utils/signals.dart';
import 'package:etv_mail_manager/widgets/etv_banner.dart';
import 'package:flutter/material.dart';

class ShellScaffold extends StatefulWidget {
  final Widget child;

  const ShellScaffold({
    super.key,
    required this.child,
  });

  @override
  State<ShellScaffold> createState() => _ShellScaffoldState();
}

class _ShellScaffoldState extends State<ShellScaffold> {
  @override
  void initState() {
    super.initState();

    SignalsUtils.handleAsync(
      context,
      ETVMailService().mails,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const ShellDrawer(),
      body: Stack(
        children: [
          this.widget.child,
          const ETVBanner(),
          Positioned(
            top: DesignSystem.spacing.x18 + MediaQuery.paddingOf(context).top,
            left: DesignSystem.spacing.x12,
            child: const Card(
              child: DrawerButton(),
            ),
          ),
        ],
      ),
    );
  }
}
