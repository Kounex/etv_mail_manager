import 'package:base_components/base_components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../utils/theme.dart';

class ETVBanner extends StatelessWidget {
  const ETVBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: DesignSystem.size.x8 + MediaQuery.paddingOf(context).top,
          width: double.infinity,
          decoration: BoxDecoration(
            color: ThemeUtils.etvColor,
          ),
        ),
        Positioned(
          top: DesignSystem.size.x4 + MediaQuery.paddingOf(context).top,
          right: DesignSystem.spacing.x32,
          child: Container(
            color: ThemeUtils.etvColor,
            child: Image.asset(
              'assets/images/etv-logo.png',
              height: DesignSystem.size.x64 + DesignSystem.size.x4,
            ),
          ),
        ),
      ],
    );
  }
}
