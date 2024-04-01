import 'package:etv_mail_manager/init.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'app.dart';

void main() async {
  usePathUrlStrategy();

  runApp(
    const Init(
      child: App(),
    ),
  );
}
