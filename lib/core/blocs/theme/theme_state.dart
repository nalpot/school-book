part of 'theme_bloc.dart';

class ThemeState extends Equatable {
  const ThemeState({required this.isDarkMode});

  factory ThemeState.fromMap(Map<String, dynamic>? json) {
    return ThemeState(isDarkMode: asBool(json, 'isDarkMode'));
  }

  final bool isDarkMode;

  @override
  List<Object> get props => [isDarkMode];

  Map<String, dynamic> toMap() {
    return {'isDarkMode': isDarkMode};
  }
}
