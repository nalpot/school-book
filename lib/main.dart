import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

import 'core/blocs/theme/theme_bloc.dart';
import 'core/cache/local_storage.dart';
import 'core/services/theme_service.dart';
import 'core/theme.dart';
import 'di.dart';
import 'features/shared/domain/entities/book_entity.dart';
import 'features/shared/domain/entities/category_entity.dart';
import 'features/splash/presentation/bloc/splash_bloc.dart';
import 'firebase_options.dart';
import 'routes/app_route.dart';

/// The entry point of the application.
///
/// Initializes all required dependencies and starts the Flutter app.
/// This function:
/// 1. Sets up dependency injection
/// 2. Initializes splash screen dependencies
/// 3. Runs the application with [MyApp] as the root widget
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  await _initHive();

  await Firebase.initializeApp(options: DefaultFirebaseOptions().currentPlatform);

  // Initialize dependency injection
  injectDependencies();

  // Start the Flutter application
  runApp(const MyApp());
}

Future<void> _initHive() async {
  Hive
    ..registerAdapter<CategoryEntity>(CategoryEntityAdapter())
    ..registerAdapter<BookEntity>(BookEntityAdapter());

  await Hive.openBox<bool>(BoxName.theme.name);
  await Hive.openBox<BookEntity>(BoxName.books.name);
  await Hive.openBox<CategoryEntity>(BoxName.categories.name);
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
    final router = sl<AppRoute>().router;

    return MultiBlocProvider(
      providers: [
        // Initialize theme management
        BlocProvider(create: (_) => sl<ThemeBloc>()),
        // Initialize splash screen state management
        BlocProvider(create: (_) => sl<SplashBloc>()),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<SplashBloc, SplashState>(
            listenWhen: (_, current) => current is SplashSuccess,
            listener: (context, state) {
              if (state is SplashSuccess) {
                router.goNamed(AppRoutePath.dashboard.name);
              }
            },
          ),
        ],
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            return MaterialApp.router(
              title: 'SchoolBook',
              themeMode:
                  sl<ThemeService>().isDarkMode
                      ? ThemeMode.dark
                      : ThemeMode.light,
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
