import '../../../core/di.dart';
import '../presentation/bloc/splash_bloc.dart';

class SplashDependency {
  SplashDependency._();

  static void initialize() {
    getIt.registerFactory<SplashBloc>(SplashBloc.new);
  }
}
