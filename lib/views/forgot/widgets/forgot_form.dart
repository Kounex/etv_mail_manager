import 'dart:async';

import 'package:base_components/base_components.dart';
import 'package:etv_mail_manager/router/router.dart';
import 'package:etv_mail_manager/router/routes.dart';
import 'package:etv_mail_manager/utils/supabase/client.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ForgotForm extends StatefulWidget {
  const ForgotForm({super.key});

  @override
  State<ForgotForm> createState() => _ForgotFormState();
}

class _ForgotFormState extends State<ForgotForm> {
  late final CustomValidationTextEditingController _email;
  late final StreamSubscription _authSubscriptions;

  Future<void>? _emailSent;

  @override
  void initState() {
    super.initState();

    _authSubscriptions = BaseSupabaseClient().authStream().listen(_authHandler);

    _email =
        CustomValidationTextEditingController(check: ValidationUtils.email);
  }

  void _authHandler(AuthState state) {
    if (state.event == AuthChangeEvent.passwordRecovery) {
      BaseAppRouter().navigateTo(context, PreAppRoutes.changePassword);
    }
  }

  void _handleReset() {
    if (_email.isValid) {
      setState(() {
        _emailSent =
            BaseSupabaseClient().resetPasswordForEmail(_email.text.trim());
      });
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
          title: 'Forgot Password',
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
                  onSubmitted: (_) {},
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text.rich(
                    TextSpan(
                      text: 'I remember my password and ',
                      children: <InlineSpan>[
                        WidgetSpan(
                          alignment: PlaceholderAlignment.baseline,
                          baseline: TextBaseline.alphabetic,
                          child: InkWell(
                            onTap: () => BaseAppRouter()
                                .navigateTo(context, PreAppRoutes.login),
                            hoverColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            child: Text(
                              'want to login',
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                            ),
                          ),
                        ),
                        const TextSpan(
                          text: '.',
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: DesignSystem.spacing.x24),
                FutureBuilder<void>(
                  future: _emailSent,
                  builder: (context, asyncEmailSent) {
                    return Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: BaseButton(
                            onPressed: _handleReset,
                            text: 'Reset Password',
                            loading: asyncEmailSent.connectionState ==
                                ConnectionState.waiting,
                          ),
                        ),
                        SizedBox(height: DesignSystem.spacing.x12),
                        AnimatedContainer(
                          duration: DesignSystem.animation.defaultDurationMS250,
                          child: asyncEmailSent.connectionState ==
                                  ConnectionState.done
                              ? asyncEmailSent.hasError
                                  ? const Fader(
                                      child: Text(
                                        'Not possible to request a password reset right now. Please try again later!',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: CupertinoColors.destructiveRed,
                                        ),
                                      ),
                                    )
                                  : const Fader(
                                      child: Text(
                                        'An email with instructions to reset your password has been sent!',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: CupertinoColors.activeGreen,
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
