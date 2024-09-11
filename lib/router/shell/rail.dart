import 'package:base_components/base_components.dart';
import 'package:etv_mail_manager/router/shell/logout.dart';
import 'package:flutter/material.dart';

import '../router.dart';
import '../routes.dart';
import 'header.dart';
import 'status.dart';

class ShellRail extends StatefulWidget {
  const ShellRail({super.key});

  @override
  State<ShellRail> createState() => _ShellRailState();
}

class _ShellRailState extends State<ShellRail> {
  List<BaseRoute> get _topRoutes =>
      List.from(AppRoute.values.where((route) => route.isRoot));

  int get _selectedIndex {
    if (BaseAppRouter().currentRoute is AppRoute) {
      return _topRoutes.indexOf(BaseAppRouter().currentRoute);
    }
    return 0;
  }

  @override
  void initState() {
    super.initState();

    BaseAppRouter().router.routerDelegate.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
            width: 0,
            color: Theme.of(context).dividerColor.withOpacity(0.2),
          ),
        ),
      ),
      child: IntrinsicWidth(
        child: Column(
          children: [
            SizedBox(height: DesignSystem.spacing.x18),
            FittedBox(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const ShellHeader(),
                  SizedBox(width: DesignSystem.spacing.x24),
                ],
              ),
            ),
            SizedBox(height: DesignSystem.spacing.x12),
            Expanded(
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: DesignSystem.spacing.x32),
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(DesignSystem.border.radius12),
                    ),
                  ),
                  child: NavigationRail(
                    onDestinationSelected: (index) =>
                        BaseAppRouter().navigateTo(context, _topRoutes[index]),
                    destinations: [
                      ..._topRoutes.map(
                        (route) => NavigationRailDestination(
                          icon: Icon(route.icon),
                          label: Text(route.name),
                        ),
                      ),
                    ],
                    selectedIndex: _selectedIndex,
                    backgroundColor: Colors.grey[100],
                    extended: true,
                  ),
                ),
              ),
            ),
            SizedBox(height: DesignSystem.spacing.x24),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: DesignSystem.spacing.x24,
              ),
              child: const ShellStatus(),
            ),
            const ShellLogout(),
          ],
        ),
      ),
    );
  }
}
