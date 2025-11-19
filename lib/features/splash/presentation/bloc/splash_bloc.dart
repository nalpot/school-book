
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'splash_event.dart';
part 'splash_state.dart';

/// Business Logic Component (BLoC) for handling splash screen functionality.
///
/// This bloc manages the splash screen's lifecycle, including initialization
/// and transition to the next screen after a delay.
/// Manages the splash screen's business logic and state transitions.
///
/// The [SplashBloc] handles:
/// - Initial splash screen display
/// - Loading necessary initial data
/// - Transitioning to the next screen after a delay
class SplashBloc extends Bloc<SplashEvent, SplashState> {
  /// Creates a [SplashBloc] with initial state [SplashInitial].
  ///
  /// Automatically starts the splash screen flow by adding a [SplashRequested] event.
  SplashBloc() : super(const SplashInitial()) {
    // Register event handlers
    on<SplashRequested>(_onSplashRequested);

    // Start the splash screen flow
    add(const SplashRequested());
  }

  /// Handles the [SplashRequested] event.
  ///
  /// This method:
  /// 1. Updates the state to [SplashLoading]
  /// 2. Waits for a fixed duration (2 seconds)
  /// 3. Emits [SplashSuccess] when complete
  ///
  /// Parameters:
  /// - [event]: The [SplashRequested] event
  /// - [emit]: The state emitter
  ///
  /// Throws:
  /// - Emits [SplashFailure] if an error occurs during the splash process
  Future<void> _onSplashRequested(
    SplashRequested event,
    Emitter<SplashState> emit,
  ) async {
    try {
      emit(const SplashLoading());

      // Simulate loading time (e.g., for checking auth state, loading configs)
      await Future<void>.delayed(const Duration(seconds: 2));

      emit(const SplashSuccess());
    } catch (error) {
      emit(SplashFailure(error.toString()));
    }
  }
}
