import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'routes.dart';
import 'shell_scaffold/shell_scaffold.dart';

final _rootKey = GlobalKey<NavigatorState>();
final _shellKey = GlobalKey<NavigatorState>();

class AppRouter {
  static AppRouter? _instance;

  late final GoRouter router;

  AppRouter._() {
    router = GoRouter(
      navigatorKey: _rootKey,
      initialLocation: AppRoutes.dashboard.path,
      routes: [
        ShellRoute(
          navigatorKey: _shellKey,
          pageBuilder: (context, state, child) => NoTransitionPage(
            child: Title(
              color: Colors.white,
              title: 'ETV Mail Manager',
              child: ShellScaffold(
                child: child,
              ),
            ),
          ),
          routes: _routes(AppRoutes.values),
        ),
      ],
    );
  }

  factory AppRouter() => _instance ??= AppRouter._();

  List<RouteBase> _routes(List<BaseRoute> routes, {int level = 0}) {
    final routesForLevel =
        routes.where((route) => route.path.split('/').length == level + 2);

    return List.from(
      routesForLevel.map(
        (route) => GoRoute(
          parentNavigatorKey: route.fullscreen ? _rootKey : null,
          path: '/${route.path.split('/').skip(level + 1).take(1).join('')}',
          name: route.name,
          pageBuilder: (context, state) => _webPage(route),
          routes: _routes(
            List.from(
              routes.where((innerRoute) =>
                  innerRoute.path.split('/')[1] == route.path.split('/')[1]),
            ),
            level: level + 1,
          ),
        ),
      ),
    );
  }

  Page _webPage(BaseRoute route) => NoTransitionPage(
        child: Title(
          title: 'EMM | $route.name',
          color: Colors.white,
          child: route.view,
        ),
      );
}
