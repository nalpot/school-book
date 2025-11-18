part of 'splash_bloc.dart';

class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object?> get props => [];
}

class SplashInitial extends SplashState {
  const SplashInitial();
}

class SplashLoading extends SplashState {
  const SplashLoading();
}

class SplashSuccess extends SplashState {
  const SplashSuccess();
}

class SplashFailure extends SplashState {
  const SplashFailure(this.error);

  final String error;

  @override
  List<Object?> get props => [error];
}
