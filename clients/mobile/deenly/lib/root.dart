import 'package:deenly/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/dev_tools/debug_logger.dart';

class Deenly extends StatelessWidget {
  final bool isDevMode;
  const Deenly({super.key, required this.isDevMode});

  @override
  Widget build(BuildContext context) {
    DebugLogger.instance.setMode(isDevMode);
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp.router(
        routerConfig: AppRouter.router,
        title: 'Deenly',
        theme: ThemeData(
          primarySwatch: Colors.green,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
      ),
    );
  }
}
