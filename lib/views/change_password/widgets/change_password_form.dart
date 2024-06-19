import 'dart:async';

import 'package:base_components/base_components.dart';
import 'package:etv_mail_manager/utils/supabase/client.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../router/router.dart';
import '../../../router/routes.dart';

class ChangePasswordForm extends StatefulWidget {
  final String? code;

  const ChangePasswordForm({
    super.key,
    required this.code,
  });

  @override
  State<ChangePasswordForm> createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<ChangePasswordForm> {
  final PasswordType _type = PasswordType.digitLetter;

  late final CustomValidationTextEditingController _pw;
  late final CustomValidationTextEditingController _pwCheck;

  Future<UserResponse>? _userResponse;

  @override
  void initState() {
    super.initState();

    _pw = CustomValidationTextEditingController(
        check: (text) => ValidationUtils.password(text, _type));
    _pwCheck = CustomValidationTextEditingController(
        check: (text) =>
            ValidationUtils.password(text, _type) ??
            (text!.trim() != _pw.text.trim()
                ? 'Passwords need to match!'
                : null));
  }

  void _handleUpdatePassword() {
    bool pwValid = _pw.isValid;
    bool pwCheckValid = _pwCheck.isValid;
    if (pwValid && pwCheckValid) {
      setState(() {
        _userResponse = BaseSupabaseClient()
            .changePassword(code: this.widget.code!, password: _pw.text.trim());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      child: SizedBox(
        width: DesignSystem.size.x512,
        child: BaseCard(
          title: this.widget.code != null ? 'Change Password' : null,
          paintBorder: true,
          borderColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
          paddingChild: EdgeInsets.all(DesignSystem.spacing.x24),
          child: this.widget.code != null
              ? FutureBuilder<UserResponse>(
                  future: _userResponse,
                  builder: (context, asyncUserResponse) => asyncUserResponse
                                  .connectionState ==
                              ConnectionState.done &&
                          !asyncUserResponse.hasError
                      ? Fader(
                          child: Text.rich(
                            TextSpan(
                              text: 'Password has been set! You can now ',
                              children: <InlineSpan>[
                                WidgetSpan(
                                  alignment: PlaceholderAlignment.baseline,
                                  baseline: TextBaseline.alphabetic,
                                  child: InkWell(
                                    onTap: () => BaseAppRouter()
                                        .navigateTo(context, PreAppRoute.login),
                                    hoverColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    child: Text(
                                      'head back to login',
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                      ),
                                    ),
                                  ),
                                ),
                                const TextSpan(
                                  text: '.',
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )
                      : Form(
                          child: Column(
                            children: [
                              BaseAdaptiveTextField(
                                controller: _pw,
                                platform: TargetPlatform.iOS,
                                scrollPadding: EdgeInsets.all(
                                  DesignSystem.spacing.x192 +
                                      DesignSystem.spacing.x16,
                                ),
                                clearButton: true,
                                placeholder: 'Password',
                                errorPaddingAlways: true,
                                obscureText: true,
                                onSubmitted: (_) => _handleUpdatePassword(),
                              ),
                              SizedBox(height: DesignSystem.spacing.x12),
                              BaseAdaptiveTextField(
                                controller: _pwCheck,
                                platform: TargetPlatform.iOS,
                                scrollPadding: EdgeInsets.all(
                                  DesignSystem.spacing.x192 +
                                      DesignSystem.spacing.x16,
                                ),
                                clearButton: true,
                                placeholder: 'Password again',
                                errorPaddingAlways: true,
                                obscureText: true,
                                onSubmitted: (_) => _handleUpdatePassword(),
                              ),
                              SizedBox(height: DesignSystem.spacing.x24),
                              SizedBox(
                                width: double.infinity,
                                child: BaseButton(
                                  onPressed: _handleUpdatePassword,
                                  text: 'Update Password',
                                  loading: asyncUserResponse.connectionState ==
                                      ConnectionState.waiting,
                                ),
                              ),
                              SizedBox(height: DesignSystem.spacing.x12),
                              AnimatedContainer(
                                duration:
                                    DesignSystem.animation.defaultDurationMS250,
                                child: asyncUserResponse.hasError
                                    ? const Fader(
                                        child: BaseErrorText(
                                          'Something went wrong! Try the reset password process again from the beginning!',
                                        ),
                                      )
                                    : const SizedBox(),
                              ),
                            ],
                          ),
                        ),
                )
              : const BaseErrorText(
                  'No valid session to change password.\nTry the whole process again!',
                ),
        ),
      ),
    );
  }
}
