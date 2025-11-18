import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/blocs/theme/theme_bloc.dart';
import 'core/di.dart';
import 'core/theme.dart';
import 'features/splash/di/splash_dependency.dart';
import 'features/splash/presentation/bloc/splash_bloc.dart';
import 'routes/app_route.dart';

void main() {
  injectDependencies();
  SplashDependency.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = getIt<AppRoute>().router;

    return MultiBlocListener(
      listeners: [
        BlocProvider(create: (_) => getIt<ThemeBloc>()),
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
