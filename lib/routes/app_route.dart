import 'package:go_router/go_router.dart';

import '../features/about/presentation/pages/about_page.dart';
import '../features/dashboard/presentation/pages/dashboard_page.dart';
import '../features/download/presentation/pages/download_page.dart';
import '../features/setting/presentation/pages/setting_page.dart';
import '../features/splash/presentation/pages/splash_page.dart';

part 'app_route_path.dart';

class AppRoute {
  GoRouter get router => _router;

  final _router = GoRouter(
    initialLocation: AppRoutePath.splash.path,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: AppRoutePath.splash.path,
        name: AppRoutePath.splash.name,
        builder: (_, state) {
          return const SplashPage();
        },
      ),
      GoRoute(
        path: AppRoutePath.dashboard.path,
        name: AppRoutePath.dashboard.name,
        builder: (_, state) {
          return const DashboardPage();
        },
      ),
      GoRoute(
        path: AppRoutePath.download.path,
        name: AppRoutePath.download.name,
        builder: (_, state) {
          return const DownloadPage();
        },
      ),
      GoRoute(
        path: AppRoutePath.setting.path,
        name: AppRoutePath.setting.name,
        builder: (_, state) {
          return const SettingPage();
        },
      ),
      GoRoute(
        path: AppRoutePath.about.path,
        name: AppRoutePath.about.name,
        builder: (_, state) {
          return const AboutPage();
        },
      ),
    ],
  );
}
