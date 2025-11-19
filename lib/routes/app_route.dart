import 'package:go_router/go_router.dart';

import '../features/about/presentation/pages/about_page.dart';
import '../features/dashboard/presentation/pages/dashboard_page.dart';
import '../features/download/presentation/pages/download_page.dart';
import '../features/setting/presentation/pages/setting_page.dart';
import '../features/splash/presentation/pages/splash_page.dart';

part 'app_route_path.dart';

/// Handles all application navigation and routing configuration.
///
/// This class is responsible for:
/// - Defining all application routes
/// - Managing navigation state
/// - Handling deep linking
/// - Providing route-based dependency injection
///
/// Routes are defined in the [_router] and should be accessed through
/// the [router] getter.
class AppRoute {
  /// Provides access to the application's router instance.
  ///
  /// Use this getter to access the router for navigation purposes.
  GoRouter get router => _router;

  /// Private instance of GoRouter that holds all route configurations.
  ///
  /// Configuration includes:
  /// - Initial route (splash screen)
  /// - Debug logging for route changes
  /// - All application routes with their corresponding pages
  final _router = GoRouter(
    initialLocation: AppRoutePath.splash.path,
    debugLogDiagnostics: true, // Set to false in production
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
