import 'package:flutter/material.dart';

import 'router/router.dart';
import 'utils/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: BaseAppRouter().router,
      theme: ThemeUtils.etvFlexTheme,
    );
  }
}
