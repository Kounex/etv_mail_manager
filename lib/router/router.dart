import 'package:collection/collection.dart';
import 'package:etv_mail_manager/types/classes/listenable_from_stream.dart';
import 'package:etv_mail_manager/utils/supabase/client.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'routes.dart';
import 'shell/scaffold.dart';

final _rootKey = GlobalKey<NavigatorState>();
final _shellKey = GlobalKey<NavigatorState>();

class BaseAppRouter {
  static BaseAppRouter? _instance;

  late final GoRouter router;

  /// Initially [currentRoute] is the [initialLocation] and will be updated
  /// in the redirect function
  BaseRoute currentRoute = AppRoute.dashboard;

  BaseAppRouter._() {
    router = GoRouter(
      navigatorKey: _rootKey,
      initialLocation: AppRoute.dashboard.fullPath,
      redirect: (context, state) async {
        // try {
        //   final authState = await BaseSupabaseClient().authStream().last;

        //   if (authState.event == AuthChangeEvent.passwordRecovery) {}
        // } catch (_) {}

        BaseRoute? currentRoute = <BaseRoute>[
          ...PreAppRoute.values,
          ...AppRoute.values
        ].firstWhereOrNull((route) => route.fullPath == state.fullPath);

        if (currentRoute == null) {
          this.currentRoute = AppRoute.dashboard;
          return this.currentRoute.fullPath;
        }

        if (AppRoute.values.any((route) => route == currentRoute)) {
          final session = BaseSupabaseClient().session();
          if (session == null || session.isExpired) {
            this.currentRoute = PreAppRoute.login;
            return this.currentRoute.fullPath;
          }
        }

        this.currentRoute = currentRoute;
        return null;
      },
      refreshListenable: ListenableFromStream(
        BaseSupabaseClient().authStream(),
      ),
      routes: [
        ..._routes(PreAppRoute.values),
        ShellRoute(
          navigatorKey: _shellKey,
          pageBuilder: (context, state, child) => NoTransitionPage(
            child: Title(
              color: const Color.fromARGB(255, 170, 166, 166),
              title: 'ETV Mail Manager',
              child: ShellScaffold(
                child: child,
              ),
            ),
          ),
          routes: _routes(AppRoute.values),
        ),
      ],
    );
  }

  factory BaseAppRouter() => _instance ??= BaseAppRouter._();

  void navigateTo(BuildContext context, BaseRoute route) =>
      context.go(route.fullPath);

  List<RouteBase> _routes(List<BaseRoute> routes, {int level = 0}) {
    final routesForLevel =
        routes.where((route) => route.fullPath.split('/').length == level + 2);

    return List.from(
      routesForLevel.map(
        (route) => GoRoute(
          // parentNavigatorKey: route.fullscreen ? _shellKey : null,
          path:
              '/${route.fullPath.split('/').skip(level + 1).take(1).join('')}',
          name: route.name,
          pageBuilder: (context, state) => _webPage(route, state),
          routes: _routes(
            List.from(
              routes.where((innerRoute) =>
                  innerRoute.fullPath.split('/')[1] ==
                  route.fullPath.split('/')[1]),
            ),
            level: level + 1,
          ),
        ),
      ),
    );
  }

  Page _webPage(BaseRoute route, GoRouterState state) => NoTransitionPage(
        child: Title(
          title: 'EMM | ${route.name}',
          color: Colors.white,
          child: route.view(state),
        ),
      );
}
