import 'package:base_components/base_components.dart';
import 'package:etv_mail_manager/router/router.dart';
import 'package:etv_mail_manager/router/shell/header.dart';
import 'package:etv_mail_manager/router/shell/logout.dart';
import 'package:etv_mail_manager/router/shell/status.dart';
import 'package:flutter/material.dart';

import '../routes.dart';

class ShellDrawer extends StatelessWidget {
  const ShellDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const ShellHeader(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const BaseDivider(),
                  ...AppRoute.values.map(
                    (route) => ListTile(
                      onTap: () {
                        BaseAppRouter().navigateTo(context, route);
                        Navigator.of(context).pop();
                      },
                      title: Text(route.name),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const BaseDivider(),
          SizedBox(height: DesignSystem.spacing.x8),
          const ShellStatus(),
          const ShellLogout(),
        ],
      ),
    );
  }
}
