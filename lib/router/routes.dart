import 'package:etv_mail_manager/router/view.dart';
import 'package:etv_mail_manager/views/change_password/change_password.dart';
import 'package:etv_mail_manager/views/forgot/forgot.dart';
import 'package:etv_mail_manager/views/login/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../views/dashboard/dashboard.dart';
import '../views/import/import.dart';

abstract class BaseRoute {
  bool get isRoot;
  String get fullPath;
  String get name;
  IconData get icon;

  RouterStatefulView view(GoRouterState state);
}

enum PreAppRoute implements BaseRoute {
  login,
  forgot,
  changePassword;

  @override
  bool get isRoot => switch (this) {
        PreAppRoute.login => true,
        PreAppRoute.forgot => true,
        PreAppRoute.changePassword => true,
      };

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
  IconData get icon => switch (this) {
        PreAppRoute.login => Icons.login,
        PreAppRoute.forgot => CupertinoIcons.question_diamond_fill,
        PreAppRoute.changePassword =>
          CupertinoIcons.arrow_up_arrow_down_square_fill,
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
  bool get isRoot => switch (this) {
        AppRoute.dashboard => true,
        AppRoute.import => true,
      };

  @override
  String get fullPath =>
      switch (this) { AppRoute.dashboard => '/', AppRoute.import => '/import' };

  @override
  String get name => switch (this) {
        AppRoute.dashboard => 'Dashboard',
        AppRoute.import => 'Import'
      };

  @override
  IconData get icon => switch (this) {
        AppRoute.dashboard => Icons.dashboard,
        AppRoute.import => CupertinoIcons.arrow_down_doc_fill,
      };

  @override
  RouterStatefulView view(GoRouterState state) => switch (this) {
        AppRoute.dashboard => const DashboardView(),
        AppRoute.import => const ImportView(),
      };
}
