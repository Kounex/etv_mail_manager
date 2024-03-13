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
      appBar: AppBar(
        title: const Text('ETV Mail Manager'),
      ),
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
      body: this.child,
    );
  }
}
