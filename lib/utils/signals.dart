import 'package:base_components/base_components.dart';
import 'package:flutter/material.dart';
import 'package:signals_flutter/signals_flutter.dart';

class SignalsUtils {
  static void handleAsync(BuildContext context, AsyncSignal signal,
      {bool handleLoading = false, String loadingMessage = 'Loading...'}) {
    signal.listen(context, () {
      if (handleLoading) {
        if (signal.value.isLoading) {
          OverlayUtils.showStatusOverlay(
            context: context,
            delayDuration: Duration.zero,
            temporalOverlay: false,
            content: BaseProgressIndicator(
              text: loadingMessage,
            ),
          );
        } else {
          OverlayUtils.closeAnyOverlay();
        }
      }

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
