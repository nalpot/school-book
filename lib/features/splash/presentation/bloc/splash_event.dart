part of 'splash_bloc.dart';

/// Base class for all splash-related events.
///
/// All splash events must extend this class and implement [props] for equality comparison.
abstract class SplashEvent extends Equatable {
  /// Creates a [SplashEvent].
  const SplashEvent();

  @override
  List<Object?> get props => [];
}

/// Event triggered when the splash screen should start its flow.
///
/// This event is typically added automatically when the [SplashBloc] is created.
class SplashRequested extends SplashEvent {
  /// Creates a [SplashRequested] event.
  const SplashRequested();
}
