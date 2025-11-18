import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(const SplashInitial()) {
    on<SplashRequested>(_onSplashRequested);

    add(const SplashRequested());
  }

  Future<void> _onSplashRequested(
    SplashRequested event,
    Emitter<SplashState> emit,
  ) async {
    emit(const SplashLoading());
    /// Wait for 2 seconds
    await Future<void>.delayed(const Duration(seconds: 2));
    emit(const SplashSuccess());
  }
}
