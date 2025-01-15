import 'package:flutter/material.dart';

import 'router/router.dart';
import 'utils/theme.dart';

final GlobalKey<OverlayState> overlayKey = GlobalKey();
final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey();

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Overlay(
      key: overlayKey,
      initialEntries: [
        OverlayEntry(
          maintainState: true,
          builder: (context) => MaterialApp.router(
            debugShowCheckedModeBanner: false,
            scaffoldMessengerKey: scaffoldMessengerKey,
            routerConfig: BaseAppRouter().router,
            theme: ThemeUtils.etvFlexTheme,
          ),
        ),
      ],
    );
  }
}
