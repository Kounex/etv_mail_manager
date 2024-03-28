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

  BaseAppRouter._() {
    router = GoRouter(
      navigatorKey: _rootKey,
      initialLocation: PreAppRoutes.login.path,
      redirect: (context, state) {
        final session = BaseSupabaseClient().session();
        if (session != null && !session.isExpired) {
          return state.uri.path;
        }
        return PreAppRoutes.login.path;
      },
      refreshListenable: ListenableFromStream(
        BaseSupabaseClient().authStream(),
      ),
      routes: [
        ..._routes(PreAppRoutes.values),
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
          routes: _routes(AppRoutes.values),
        ),
      ],
    );
  }

  factory BaseAppRouter() => _instance ??= BaseAppRouter._();

  void navigateTo(BuildContext context, BaseRoute route) =>
      context.go(route.path);

  List<RouteBase> _routes(List<BaseRoute> routes, {int level = 0}) {
    final routesForLevel =
        routes.where((route) => route.path.split('/').length == level + 2);

    return List.from(
      routesForLevel.map(
        (route) => GoRoute(
          parentNavigatorKey: route.fullscreen ? _shellKey : null,
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
          title: 'EMM | ${route.name}',
          color: Colors.white,
          child: route.view,
        ),
      );
}
