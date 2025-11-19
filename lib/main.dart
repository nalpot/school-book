import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/blocs/theme/theme_bloc.dart';
import 'core/di.dart';
import 'core/theme.dart';
import 'features/splash/di/splash_dependency.dart';
import 'features/splash/presentation/bloc/splash_bloc.dart';
import 'routes/app_route.dart';

/// The entry point of the application.
///
/// Initializes all required dependencies and starts the Flutter app.
/// This function:
/// 1. Sets up dependency injection
/// 2. Initializes splash screen dependencies
/// 3. Runs the application with [MyApp] as the root widget
void main() {
  // Initialize dependency injection
  injectDependencies();

  // Initialize splash screen specific dependencies
  SplashDependency.initialize();

  // Start the Flutter application
  runApp(const MyApp());
}

/// The root widget of the application.
///
/// Sets up the application's theme, routing, and global state management.
/// Manages:
/// - Theme state (light/dark mode)
/// - Splash screen flow
/// - Navigation routing
class MyApp extends StatelessWidget {
  /// Creates a [MyApp] widget.
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the router for navigation
    final router = getIt<AppRoute>().router;

    return MultiBlocListener(
      listeners: [
        // Initialize theme management
        BlocProvider(create: (_) => getIt<ThemeBloc>()),
        // Initialize splash screen state management
        BlocProvider(create: (_) => getIt<SplashBloc>()),
      ],
      child: BlocListener<SplashBloc, SplashState>(
        listenWhen: (_, current) => current is SplashSuccess,
        listener: (context, state) {
          if (state is SplashSuccess) {
            router.goNamed(AppRoutePath.dashboard.name);
          }
        },
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            return MaterialApp.router(
              title: 'SchoolBook',
              themeMode: state.isDarkMode ? ThemeMode.dark : ThemeMode.light,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              routerConfig: router,
            );
          },
        ),
      ),
    );
  }
}
