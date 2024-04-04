import 'package:base_components/base_components.dart';
import 'package:etv_mail_manager/views/forgot/widgets/forgot_form.dart';
import 'package:flutter/material.dart';

class ForgotView extends StatelessWidget {
  const ForgotView({super.key});

  @override
  Widget build(BuildContext context) {
    return const WebScaffold(
      children: [
        ForgotForm(),
      ],
    );
  }
}
