import 'package:base_components/base_components.dart';
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
    final disposers = signals.map(
      (signal) => handleSignal(
        signal,
        handleLoading: handleLoading,
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
    bool handleLoading = false,
    String loadingMessage = 'Loading...',
  }) {
    return signal.subscribe(
      (state) {
        if (handleLoading) {
          if (state.isLoading) {
            OverlayUtils.showStatusOverlay(
              context: rootKey.currentContext!,
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

        if (state.hasError) {
          ScaffoldMessenger.of(rootKey.currentContext!)
              .hideCurrentMaterialBanner();
          ScaffoldMessenger.of(rootKey.currentContext!).showMaterialBanner(
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
                    ScaffoldMessenger.of(rootKey.currentContext!)
                        .clearMaterialBanners();
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
