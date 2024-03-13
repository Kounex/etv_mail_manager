import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

import 'router/router.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter().router,
      theme: FlexThemeData.light(
        primary: const Color.fromARGB(255, 255, 17, 0),
        surfaceMode: FlexSurfaceMode.highSurfaceLowScaffold,
        blendLevel: 5,
        subThemesData: const FlexSubThemesData(
          blendOnLevel: 5,
          useTextTheme: true,
          useM2StyleDividerInM3: true,
          alignedDropdown: true,
          useInputDecoratorThemeInDialogs: true,
        ),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        useMaterial3: true,
        swapLegacyOnMaterial3: true,
      ),
    );
  }
}
