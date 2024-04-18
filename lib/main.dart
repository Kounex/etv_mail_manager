import 'package:etv_mail_manager/init.dart';
import 'package:flutter/material.dart';

import 'app.dart';

void main() async {
  // if (!(bool.tryParse(const String.fromEnvironment('GH_RELEASE')) ?? false)) {
  //   usePathUrlStrategy();
  // }

  runApp(
    const Init(
      child: App(),
    ),
  );
}
