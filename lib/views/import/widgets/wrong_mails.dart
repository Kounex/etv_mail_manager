import 'package:base_components/base_components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:signals_flutter/signals_flutter.dart';

import '../signals/signals.dart';

class WrongMails extends StatelessWidget {
  const WrongMails({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseConstrainedBox(
      child: Watch((context) {
        if (ImportSignals().wrongMails.value.isNotEmpty) {
          return Fader(
            child: Align(
              alignment: Alignment.topLeft,
              child: BaseErrorText(
                'These mails are not correct: ${ImportSignals().wrongMails.reduce((value, element) => value += ', $element')}',
                center: false,
                dense: true,
              ),
            ),
          );
        }
        return const SizedBox();
      }),
    );
  }
}
