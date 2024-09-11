import 'package:base_components/base_components.dart';
import 'package:flutter/material.dart';

class ShellHeader extends StatelessWidget {
  const ShellHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.paddingOf(context).top + DesignSystem.spacing.x12,
        ),
        Row(
          children: [
            SizedBox(width: DesignSystem.spacing.x24),
            Image.asset(
              'assets/images/etv-logo.png',
              height: DesignSystem.size.x128,
            ),
            SizedBox(width: DesignSystem.spacing.x24),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Badminton',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                Text(
                  'Mail Manager',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: DesignSystem.spacing.x12),
      ],
    );
  }
}
