import 'package:get_it/get_it.dart';

import '../routes/app_route.dart';
import 'blocs/theme/theme_bloc.dart';

final GetIt getIt = GetIt.I;

void injectDependencies() {
  getIt
    ..registerLazySingleton(AppRoute.new)
    ..registerFactory(ThemeBloc.new);
}
