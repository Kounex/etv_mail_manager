import 'package:base_components/base_components.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../routes.dart';

class ShellDrawer extends StatelessWidget {
  const ShellDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          SizedBox(
            height:
                MediaQuery.paddingOf(context).top + DesignSystem.spacing.x12,
          ),
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
    );
  }
}
