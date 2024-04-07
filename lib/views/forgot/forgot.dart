import 'package:base_components/base_components.dart';
import 'package:etv_mail_manager/router/view.dart';
import 'package:etv_mail_manager/views/forgot/widgets/forgot_form.dart';
import 'package:flutter/material.dart';

class ForgotView extends RouterStatefulView {
  const ForgotView({super.key});

  @override
  State<ForgotView> createState() => _ForgotViewState();
}

class _ForgotViewState extends State<ForgotView> {
  @override
  Widget build(BuildContext context) {
    return const WebScaffold(
      children: [
        ForgotForm(),
      ],
    );
  }
}
