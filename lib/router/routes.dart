import 'package:etv_mail_manager/views/login/login.dart';
import 'package:flutter/material.dart';

import '../views/dashboard/dashboard.dart';
import '../views/import/import.dart';

abstract class BaseRoute {
  String get path;
  String get name;
  bool get fullscreen;
  Widget get view;
}

enum PreAppRoutes implements BaseRoute {
  login;

  @override
  String get path => switch (this) {
        PreAppRoutes.login => '/login',
      };

  @override
  String get name => switch (this) {
        PreAppRoutes.login => 'Login',
      };

  @override
  bool get fullscreen => switch (this) {
        _ => false,
      };

  @override
  Widget get view => switch (this) {
        PreAppRoutes.login => const LoginView(),
      };
}

enum AppRoutes implements BaseRoute {
  dashboard,
  import;

  @override
  String get path => switch (this) {
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
  Widget get view => switch (this) {
        AppRoutes.dashboard => const DashboardView(),
        AppRoutes.import => const ImportView()
      };
}
