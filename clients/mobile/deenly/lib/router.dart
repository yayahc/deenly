import 'package:deenly/core/app_routes/app_routes.dart';
import 'package:deenly/features/zikr/presentation/screens/zikr_home_screen.dart';
import 'package:deenly/presentation/screens/main_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static GoRouter get router => _router;
  static final _router = GoRouter(
      debugLogDiagnostics: true,
      initialLocation: AppRoutes.splash,
      routes: [
        GoRoute(
          path: AppRoutes.splash,
          builder: (context, state) => MainScreen(),
        ),
        GoRoute(
            path: AppRoutes.home,
            builder: (context, state) => MainScreen(),
            routes: [
              GoRoute(
                path: AppRoutes.zikr,
                builder: (context, state) => ZikrHomeScreen(),
              ),
            ])
      ]);
}
