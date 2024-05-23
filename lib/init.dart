import 'package:base_components/base_components.dart';
import 'package:etv_mail_manager/utils/env.dart';
import 'package:etv_mail_manager/utils/theme.dart';
import 'package:flutter/material.dart';

import 'utils/supabase/init.dart';

class Init extends StatefulWidget {
  final Widget child;

  const Init({
    super.key,
    required this.child,
  });

  @override
  State<Init> createState() => _InitState();
}

class _InitState extends State<Init> {
  late final Future<void> _init;

  @override
  void initState() {
    super.initState();

    _init = _initApp();
  }

  Future<void> _initApp() async {
    await Future.wait([
      SupabaseInit.create(),
      EnvUtils.loadEnv(),
      Future.delayed(const Duration(seconds: 1)),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeUtils.etvFlexTheme,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Material(
          child: BaseFutureBuilder(
            future: _init,
            loading: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/etv-logo.png',
                  height: DesignSystem.size.x92,
                ),
                SizedBox(height: DesignSystem.spacing.x24),
                BaseProgressIndicator(),
              ],
            ),
            data: (_) => this.widget.child,
          ),
        ),
      ),
    );
  }
}
