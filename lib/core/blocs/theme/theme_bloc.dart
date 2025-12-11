import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/theme_service.dart';
import '../../utils/safe_convert.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc({required ThemeService themeService})
    : _themeService = themeService,
      super(ThemeState(isDarkMode: themeService.isDarkMode)) {
    on<LightThemeEvent>(_lightTheme);
    on<DarkThemeEvent>(_darkTheme);
    on<ToggleThemeEvent>(_toggleTheme);
    on<CurrentThemeEvent>(_currentTheme);

    add(const CurrentThemeEvent());
  }

  final ThemeService _themeService;

  Future<void> _lightTheme(
    LightThemeEvent event,
    Emitter<ThemeState> emit,
  ) async {
    await _themeService.saveTheme(isDarkMode: false);
    emit(const ThemeState(isDarkMode: false));
  }

  Future<void> _darkTheme(
    DarkThemeEvent event,
    Emitter<ThemeState> emit,
  ) async {
    await _themeService.saveTheme(isDarkMode: true);
    emit(const ThemeState(isDarkMode: true));
  }

  Future<void> _toggleTheme(
    ToggleThemeEvent event,
    Emitter<ThemeState> emit,
  ) async {
    await _themeService.saveTheme(isDarkMode: !state.isDarkMode);
    emit(ThemeState(isDarkMode: !state.isDarkMode));
  }

  Future<void> _currentTheme(
    CurrentThemeEvent event,
    Emitter<ThemeState> emit,
  ) async {
    emit(ThemeState(isDarkMode: _themeService.isDarkMode));
  }
}
