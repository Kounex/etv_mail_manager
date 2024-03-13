import 'package:flutter/material.dart';
import 'package:signals_flutter/signals_flutter.dart';

class SignalsUtils {
  static void handleAsync(BuildContext context, AsyncSignal signal) {
    signal.listen(context, () {
      if (signal.value.hasError) {
        late final ScaffoldFeatureController<MaterialBanner,
            MaterialBannerClosedReason> banner;
        banner = ScaffoldMessenger.of(context).showMaterialBanner(
          MaterialBanner(
            content: Text(
              signal.value.error!.toString(),
            ),
            actions: [
              TextButton(
                onPressed: () => banner.close(),
                child: const Text('Ok'),
              ),
            ],
          ),
        );
      }
    });
  }
}
