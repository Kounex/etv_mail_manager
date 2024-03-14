import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

class ThemeUtils {
  static const Color etvColor = Color.fromARGB(255, 220, 20, 10);

  static ThemeData etvFlexTheme = FlexThemeData.light(
    platform: TargetPlatform.android,
    primary: Colors.black,
    secondary: ThemeUtils.etvColor,
    surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
    lightIsWhite: true,
    surfaceTint: Colors.grey[500],
    subThemesData: const FlexSubThemesData(
      useTextTheme: true,
      useM2StyleDividerInM3: true,
      alignedDropdown: true,
      useInputDecoratorThemeInDialogs: true,
    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    useMaterial3: true,
    swapLegacyOnMaterial3: true,
  );
}
