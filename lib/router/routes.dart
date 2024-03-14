import 'package:flutter/material.dart';

import '../views/dashboard/dashboard.dart';
import '../views/import/import.dart';

abstract class BaseRoute {
  String get path;
  String get name;
  bool get fullscreen;
  Widget get view;
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
  bool get fullscreen => switch (this) { _ => false };

  @override
  Widget get view => switch (this) {
        AppRoutes.dashboard => const DashboardView(),
        AppRoutes.import => const ImportView()
      };
}
