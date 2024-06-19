import 'dart:math';

import 'package:base_components/base_components.dart';
import 'package:flutter/material.dart';

import '../../router/view.dart';
import 'widgets/login_form.dart';

class LoginView extends RouterStatefulView {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
