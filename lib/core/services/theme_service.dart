import 'package:flutter/foundation.dart';

import '../cache/local_storage.dart';

sealed class ThemeService {
  Future<void> saveTheme({bool isDarkMode});

  bool get isDarkMode;
}

class ThemeServiceImpl implements ThemeService {
  ThemeServiceImpl(this._localStorage) {
    _initialize();
  }

  final LocalStorage _localStorage;
  bool _isDarkMode = false;
  bool _initialized = false;

  Future<void> _initialize() async {
    if (_initialized) return;
    _isDarkMode =
        await _localStorage.load<bool>(key: 'dark', boxName: BoxName.theme) ??
        false;

    _initialized = true;
    debugPrint('ThemeService Initialized');
  }

  @override
  Future<void> saveTheme({bool isDarkMode = false}) async {
    _isDarkMode = isDarkMode;

    await _localStorage.save<bool>(
      key: 'dark',
      value: isDarkMode,
      boxName: BoxName.theme,
    );
  }

  @override
  bool get isDarkMode => _isDarkMode;
}
