import 'package:package_info_plus/package_info_plus.dart';
import 'package:signals/signals.dart';

class MetaSignals {
  static MetaSignals? _instance;

  final appVersion = futureSignal<String>(() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return '${packageInfo.version}+${packageInfo.buildNumber}';
  });

  MetaSignals._();

  factory MetaSignals() => _instance ??= MetaSignals._();
}
