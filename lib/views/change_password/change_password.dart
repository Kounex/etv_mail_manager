import 'package:base_components/base_components.dart';
import 'package:etv_mail_manager/router/view.dart';
import 'package:etv_mail_manager/views/change_password/widgets/change_password_form.dart';
import 'package:flutter/material.dart';
import 'package:web/web.dart';

class ChangePasswordRouterViewData extends RouterViewData {
  ChangePasswordRouterViewData({required super.state});

  String? get code {
    String? param = this.state.uri.queryParameters['code'];
    if (param == null && window.location.href.contains('?code=')) {
      param = window.location.href.split('?code=')[1].split('#')[0];
    }
    return param;
  }
}

class ChangePasswordView
    extends RouterStatefulView<ChangePasswordRouterViewData> {
  const ChangePasswordView({
    super.key,
    required super.data,
  });

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  @override
  Widget build(BuildContext context) {
    return WebScaffold(
      children: [
        ChangePasswordForm(
          code: this.widget.data?.code,
        ),
      ],
    );
  }
}
