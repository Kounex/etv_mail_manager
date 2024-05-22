import 'package:base_components/base_components.dart';
import 'package:etv_mail_manager/router/router.dart';
import 'package:etv_mail_manager/utils/supabase/client.dart';
import 'package:flutter/material.dart';

import '../routes.dart';

class ShellDrawer extends StatelessWidget {
  const ShellDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.paddingOf(context).top +
                        DesignSystem.spacing.x12,
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
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.only(left: DesignSystem.spacing.x12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(BaseSupabaseClient().session()?.user.email ?? 'Unknown'),
                  Text(
                    BaseSupabaseClient().session()?.user.role ?? 'Unknown',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(DesignSystem.spacing.x24),
            child: SizedBox(
              width: double.infinity,
              child: BaseButton(
                onPressed: () => BaseSupabaseClient().signOut(),
                text: 'Logout',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
