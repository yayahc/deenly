import 'package:flutter/widgets.dart';
import 'core/dev_tools/debug_logger.dart';
import 'di.dart';
import 'features/zikr/services/local_storage/local_storage.dart';

Future<void> initApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  await LocalStorage.init();
  DebugLogger.init();
}
