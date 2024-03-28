import 'dart:math';

import 'package:base_components/base_components.dart';
import 'package:flutter/material.dart';

import 'widgets/login_form.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return WebScaffold(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: DesignSystem.spacing.x24),
          child: Image.asset(
            'assets/images/etv-logo.png',
            height: min(DesignSystem.size.x256,
                MediaQuery.sizeOf(context).height / 4.5),
          ),
        ),
        const LoginForm(),
      ],
    );
  }
}
