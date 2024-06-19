import 'package:etv_mail_manager/router/view.dart';
import 'package:etv_mail_manager/views/change_password/change_password.dart';
import 'package:etv_mail_manager/views/forgot/forgot.dart';
import 'package:etv_mail_manager/views/login/login.dart';
import 'package:go_router/go_router.dart';

import '../views/dashboard/dashboard.dart';
import '../views/import/import.dart';

abstract class BaseRoute {
  String get fullPath;
  String get name;
  bool get fullscreen;

  RouterStatefulView view(GoRouterState state);
}

enum PreAppRoute implements BaseRoute {
  login,
  forgot,
  changePassword;

  @override
  String get fullPath => switch (this) {
        PreAppRoute.login => '/login',
        PreAppRoute.forgot => '/forgot',
        PreAppRoute.changePassword => '/change-password',
      };

  @override
  String get name => switch (this) {
        PreAppRoute.login => 'Login',
        PreAppRoute.forgot => 'Forgot',
        PreAppRoute.changePassword => 'Change Password',
      };

  @override
  bool get fullscreen => switch (this) {
        _ => false,
      };

  @override
  RouterStatefulView view(GoRouterState state) => switch (this) {
        PreAppRoute.login => const LoginView(),
        PreAppRoute.forgot => const ForgotView(),
        PreAppRoute.changePassword =>
          ChangePasswordView(data: ChangePasswordRouterViewData(state: state)),
      };
}

enum AppRoute implements BaseRoute {
  dashboard,
  import;

  @override
  String get fullPath =>
      switch (this) { AppRoute.dashboard => '/', AppRoute.import => '/import' };

  @override
  String get name => switch (this) {
        AppRoute.dashboard => 'Dashboard',
        AppRoute.import => 'Import'
      };

  @override
  bool get fullscreen => switch (this) {
        _ => false,
      };

  @override
  RouterStatefulView view(GoRouterState state) => switch (this) {
        AppRoute.dashboard => const DashboardView(),
        AppRoute.import => const ImportView(),
      };
}
