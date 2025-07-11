import 'dart:developer' as dev;

class DebugLogger {
  bool _devMode = false;
  DebugLogger();

  void setMode(bool isDevMode) {
    _devMode = isDevMode;
  }

  log(String message, {String? logedAt}) {
    if (_devMode) {
      dev.log('[$logedAt]\n$message');
    }
  }

  static late DebugLogger _instance;
  static DebugLogger get instance => _instance;

  factory DebugLogger.init() {
    _instance = DebugLogger();
    return _instance;
  }
}
