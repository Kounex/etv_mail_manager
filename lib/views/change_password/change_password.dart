import 'package:base_components/base_components.dart';
import 'package:etv_mail_manager/views/change_password/widgets/change_password_form.dart';
import 'package:flutter/material.dart';

class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return const WebScaffold(
      children: [
        ChangePasswordForm(),
      ],
    );
  }
}
