import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/safe_convert.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(const ThemeState(isDarkMode: false)) {
    on<LightThemeEvent>(_lightTheme);
    on<DarkThemeEvent>(_darkTheme);
    on<ToggleThemeEvent>(_toggleTheme);
  }

  Future<void> _lightTheme(
    LightThemeEvent event,
    Emitter<ThemeState> emit,
  ) async {
    emit(const ThemeState(isDarkMode: false));
  }

  Future<void> _darkTheme(
    DarkThemeEvent event,
    Emitter<ThemeState> emit,
  ) async {
    emit(const ThemeState(isDarkMode: true));
  }

  Future<void> _toggleTheme(
    ToggleThemeEvent event,
    Emitter<ThemeState> emit,
  ) async {
    emit(ThemeState(isDarkMode: !state.isDarkMode));
  }
}
