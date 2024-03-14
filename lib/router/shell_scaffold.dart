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
            SizedBox(height: MediaQuery.paddingOf(context).top),
            Row(
              children: [
                SizedBox(width: DesignSystem.spacing.x24),
                Image.asset(
                  'assets/images/etv-logo.png',
                  height: DesignSystem.size.x128,
                ),
                SizedBox(width: DesignSystem.spacing.x24),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Badminton',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    Text(
                      'Mail Manager',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: DesignSystem.spacing.x12),
            const BaseDivider(),
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
            top: DesignSystem.spacing.x12 + MediaQuery.paddingOf(context).top,
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
