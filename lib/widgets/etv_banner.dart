import 'package:base_components/base_components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ETVBanner extends StatelessWidget {
  const ETVBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: DesignSystem.size.x8,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 220, 20, 10),
          ),
        ),
        Positioned(
          top: 0,
          right: DesignSystem.spacing.x32,
          child: Container(
            color: const Color.fromARGB(255, 220, 20, 10),
            child: Image.asset(
              'assets/images/etv-logo.png',
              height: DesignSystem.size.x64,
            ),
          ),
        ),
      ],
    );
  }
}
