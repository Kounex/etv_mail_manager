import 'package:base_components/base_components.dart';
import 'package:etv_mail_manager/app.dart';
import 'package:flutter/material.dart';
import 'package:signals_flutter/signals_flutter.dart';

import '../router/router.dart';

class SignalsUtils {
  static void handledAsyncTask<T, R>(
    Iterable<AsyncSignal<T?>> signals,
    Future<R> Function() task, {
    void Function(R taskResult)? then,
    bool handleLoading = false,
    String loadingMessage = 'Loading...',
  }) {
    if (handleLoading) {
      OverlayUtils.showStatusOverlay(
        overlayKey: overlayKey,
        delayDuration: Duration.zero,
        temporalOverlay: false,
        content: BaseProgressIndicator(
          text: loadingMessage,
        ),
      );
    }

    final disposers = signals.map(
      (signal) => handleSignal(
        signal,
        loadingMessage: loadingMessage,
      ),
    );

    task().then((taskResult) {
      then?.call(taskResult);
      for (final d in disposers) {
        d();
      }
    });
  }

  static void Function() handleSignal<T>(
    AsyncSignal<T?> signal, {
    String loadingMessage = 'Loading...',
  }) {
    return signal.subscribe(
      (state) {
        if (!state.isLoading) {
          OverlayUtils.closeAnyOverlay();
        }

        if (state.hasError) {
          scaffoldMessengerKey.currentState!.hideCurrentMaterialBanner();
          scaffoldMessengerKey.currentState!.showMaterialBanner(
            MaterialBanner(
              content: Text(
                state.error!.toString(),
              ),
              actions: [
                TextButton(
                  onPressed: () => ModalUtils.showBaseDialog(
                    rootKey.currentContext!,
                    InfoDialog(body: state.stackTrace.toString()),
                  ),
                  child: const Text('Details'),
                ),
                TextButton(
                  onPressed: () {
                    signal.overrideWith(AsyncState.data(null));
                    scaffoldMessengerKey.currentState!.clearMaterialBanners();
                  },
                  child: const Text('Ok'),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
