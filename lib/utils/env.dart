import 'package:flutter/services.dart';

class Env {
  String? redirectURL;

  Env({
    this.redirectURL,
  });
}

class EnvUtils {
  static EnvUtils? _instance;
  static bool _initialized = false;

  static Env _env = Env();

  EnvUtils._();

  factory EnvUtils() {
    assert(
      _initialized,
      'Env has not been initialized yet! Run the [loadEnv] function!',
    );
    return _instance ??= EnvUtils._();
  }

  static Future<void> loadEnv() async {
    String envString =
        await rootBundle.loadString('assets/env/config', cache: false);

    Map<String, String> envMap = {};

    for (final envLine in envString.split('\n')) {
      envMap.putIfAbsent(envLine.split('=')[0], () => envLine.split('=')[1]);
    }

    _env = Env(
      redirectURL: envMap['REDIRECT_URL'],
    );

    _initialized = true;
  }

  Env get env => _env;
}
