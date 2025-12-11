import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'core/blocs/theme/theme_bloc.dart';
import 'core/cache/hive_local_storage.dart';
import 'core/services/theme_service.dart';
import 'features/reader/domain/usecases/get_book_usecase.dart';
import 'features/shared/data/datasources/book_local_datasource.dart';
import 'features/shared/data/datasources/book_remote_datasources.dart';
import 'features/shared/data/repositories/book_repository_impl.dart';
import 'features/shared/domain/repositories/book_repository.dart';
import 'features/shared/domain/usecases/fetch_book_usecase.dart';
import 'features/splash/presentation/bloc/splash_bloc.dart';
import 'routes/app_route.dart';

final GetIt sl = GetIt.I;

void injectDependencies() {
  sl
    // App Configuration
    ..registerLazySingleton(AppRoute.new)
    ..registerLazySingleton(HiveLocalStorage.new)
    ..registerFactory(
      () => Dio(
        BaseOptions(
          contentType: 'application/json',
          headers: const {'Content-Type': 'application/json'},
        ),
      ),
    )
    // Services
    ..registerLazySingleton<ThemeService>(
      () => ThemeServiceImpl(sl<HiveLocalStorage>()),
    )
    // Data Sources
    ..registerLazySingleton(BookRemoteDataSources.new)
    ..registerLazySingleton(
      () => BookLocalDataSource(localStorage: sl<HiveLocalStorage>()),
    )
    // Repositories
    ..registerLazySingleton<BookRepository>(
      () => BookRepositoryImpl(
        bookRemoteDataSources: sl<BookRemoteDataSources>(),
        bookLocalDataSource: sl<BookLocalDataSource>(),
      ),
    )
    // Use Cases
    ..registerLazySingleton(
      () => FetchBookUseCase(bookRepository: sl<BookRepository>()),
    )
    ..registerLazySingleton(
      () => GetBookUseCase(bookRepository: sl<BookRepository>()),
    )
    // BloC
    ..registerFactory(() => ThemeBloc(themeService: sl<ThemeService>()))
    ..registerFactory<SplashBloc>(SplashBloc.new);
}
