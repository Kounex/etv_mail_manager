import 'package:etv_mail_manager/signals/meta.dart';
import 'package:flutter/material.dart';
import 'package:signals_flutter/signals_flutter.dart';

class VersionText extends StatelessWidget {
  const VersionText({super.key});

  @override
  Widget build(BuildContext context) {
    final appVersion = MetaSignals().appVersion;

    return Watch(
      (_) => Text(
        appVersion.value.maybeMap(
          data: (version) => version,
          orElse: () => '-',
        ),
        style: Theme.of(context).textTheme.labelSmall!.copyWith(
              color: Theme.of(context).disabledColor,
            ),
      ),
    );
  }
}
