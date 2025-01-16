import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeUtils {
  static final Color etvColor = 'db0d15'.toColor;

  static ThemeData etvFlexTheme = FlexThemeData.light(
    platform: TargetPlatform.android,
    colors: FlexSchemeColor(
      primary: Colors.black,
      secondary: ThemeUtils.etvColor,
    ),
    surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
    lightIsWhite: true,
    surfaceTint: Colors.grey[500],
    subThemesData: const FlexSubThemesData(
      useM2StyleDividerInM3: true,
      alignedDropdown: true,
      useInputDecoratorThemeInDialogs: true,
    ),
    cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
  ).copyWith(
    tooltipTheme: const TooltipThemeData(
      preferBelow: false,
    ),
  );
}
