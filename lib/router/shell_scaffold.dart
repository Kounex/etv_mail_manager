import 'package:base_components/base_components.dart';
import 'package:etv_mail_manager/widgets/etv_banner.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'routes.dart';

class ShellScaffold extends StatelessWidget {
  final Widget child;

  const ShellScaffold({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            ...AppRoutes.values.map(
              (route) => ListTile(
                onTap: () {
                  context.go(route.path);
                  Navigator.of(context).pop();
                },
                title: Text(route.name),
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          this.child,
          const ETVBanner(),
          Positioned(
            top: DesignSystem.spacing.x12,
            left: DesignSystem.spacing.x12,
            child: const DrawerButton(),
          ),
        ],
      ),
    );
  }
}
