import 'dart:async';

import 'package:base_components/base_components.dart';
import 'package:etv_mail_manager/router/router.dart';
import 'package:etv_mail_manager/router/routes.dart';
import 'package:etv_mail_manager/utils/supabase/client.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late final CustomValidationTextEditingController _email;
  late final CustomValidationTextEditingController _pw;

  Future<Session?>? _session;
  late final StreamSubscription _authSubscriptions;

  @override
  void initState() {
    super.initState();

    _authSubscriptions = BaseSupabaseClient().authStream().listen(_authHandler);

    _email =
        CustomValidationTextEditingController(check: ValidationUtils.email);
    _pw = CustomValidationTextEditingController(check: ValidationUtils.name);
  }

  void _signIn() {
    final emailValid = _email.isValid;
    final pwValid = _pw.isValid;
    if (emailValid && pwValid) {
      setState(
        () {
          _session =
              BaseSupabaseClient().signInWithEmail(_email.text, _pw.text);
        },
      );
    }
  }

  void _authHandler(AuthState state) {
    if (state.session != null && !state.session!.isExpired) {
      BaseAppRouter().navigateTo(context, AppRoutes.dashboard);
    }
  }

  @override
  void dispose() {
    _authSubscriptions.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      child: SizedBox(
        width: DesignSystem.size.x512,
        child: BaseCard(
          title: 'ETV Mail Manager',
          paintBorder: true,
          borderColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
          paddingChild: EdgeInsets.all(DesignSystem.spacing.x24),
          child: FocusTraversalGroup(
            policy: WidgetOrderTraversalPolicy(),
            child: Column(
              children: [
                BaseAdaptiveTextField(
                  controller: _email,
                  platform: TargetPlatform.iOS,
                  scrollPadding: EdgeInsets.all(
                    DesignSystem.spacing.x192 + DesignSystem.spacing.x16,
                  ),
                  clearButton: true,
                  placeholder: 'Email',
                  errorPaddingAlways: true,
                  keyboardType: TextInputType.emailAddress,
                  onSubmitted: (_) => _signIn(),
                ),
                SizedBox(height: DesignSystem.spacing.x4),
                BaseAdaptiveTextField(
                  controller: _pw,
                  platform: TargetPlatform.iOS,
                  scrollPadding: EdgeInsets.all(
                    DesignSystem.spacing.x128 + DesignSystem.spacing.x18,
                  ),
                  clearButton: true,
                  placeholder: 'Password',
                  errorPaddingAlways: true,
                  obscureText: true,
                  onSubmitted: (_) => _signIn(),
                ),
                SizedBox(height: DesignSystem.spacing.x12),
                FutureBuilder<Session?>(
                  future: _session,
                  builder: (context, asyncSession) {
                    return Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: BaseButton(
                            onPressed: _signIn,
                            text: 'Login',
                            loading: asyncSession.connectionState ==
                                ConnectionState.waiting,
                          ),
                        ),
                        SizedBox(height: DesignSystem.spacing.x12),
                        AnimatedContainer(
                          duration: DesignSystem.animation.defaultDurationMS250,
                          child: asyncSession.hasError
                              ? const Fader(
                                  child: Text(
                                    'Email and Password combination does not exist!',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: CupertinoColors.destructiveRed,
                                    ),
                                  ),
                                )
                              : const SizedBox(),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
