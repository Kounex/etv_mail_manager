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

enum PreAppRoutes implements BaseRoute {
  login,
  forgot,
  changePassword;

  @override
  String get fullPath => switch (this) {
        PreAppRoutes.login => '/login',
        PreAppRoutes.forgot => '/forgot',
        PreAppRoutes.changePassword => '/change-password',
      };

  @override
  String get name => switch (this) {
        PreAppRoutes.login => 'Login',
        PreAppRoutes.forgot => 'Forgot',
        PreAppRoutes.changePassword => 'Change Password',
      };

  @override
  bool get fullscreen => switch (this) {
        _ => false,
      };

  @override
  RouterStatefulView view(GoRouterState state) => switch (this) {
        PreAppRoutes.login => const LoginView(),
        PreAppRoutes.forgot => const ForgotView(),
        PreAppRoutes.changePassword =>
          ChangePasswordView(data: ChangePasswordRouterViewData(state: state)),
      };
}

enum AppRoutes implements BaseRoute {
  dashboard,
  import;

  @override
  String get fullPath => switch (this) {
        AppRoutes.dashboard => '/',
        AppRoutes.import => '/import'
      };

  @override
  String get name => switch (this) {
        AppRoutes.dashboard => 'Dashboard',
        AppRoutes.import => 'Import'
      };

  @override
  bool get fullscreen => switch (this) {
        _ => false,
      };

  @override
  RouterStatefulView view(GoRouterState state) => switch (this) {
        AppRoutes.dashboard => const DashboardView(),
        AppRoutes.import => const ImportView(),
      };
}
