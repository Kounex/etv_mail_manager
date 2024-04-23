import 'dart:async';

import 'package:base_components/base_components.dart';
import 'package:etv_mail_manager/router/router.dart';
import 'package:etv_mail_manager/router/routes.dart';
import 'package:etv_mail_manager/utils/supabase/client.dart';
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
    if (state.event == AuthChangeEvent.signedIn) {
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
          child: Form(
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
                Align(
                  alignment: Alignment.centerRight,
                  child: Text.rich(
                    textAlign: TextAlign.right,
                    TextSpan(
                      text: 'I may need to ',
                      children: <InlineSpan>[
                        WidgetSpan(
                          alignment: PlaceholderAlignment.baseline,
                          baseline: TextBaseline.alphabetic,
                          child: InkWell(
                            onTap: () => BaseAppRouter()
                                .navigateTo(context, PreAppRoutes.forgot),
                            hoverColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            child: Text(
                              'reset my password',
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
                                  child: BaseErrorText(
                                    'Email and Password combination does not exist!',
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
