import 'package:flutter/material.dart';

/// A class that defines the color scheme used by the application.
///
/// This class contains static properties that describe the colors used by the
/// application. The colors are divided into two categories: primary and
/// secondary. The primary colors are used for the main UI elements, such as
/// buttons, texts, and backgrounds, while the secondary colors are used for
/// highlighting and emphasizing certain parts of the UI.
///
/// The colors are defined as [Color] instances, which can be used directly in
/// [Material] widgets.
///
/// For example, to set the background color of a [Material] widget to the
/// primary color of the application, you can use the following code:
///
class AppTheme {
  AppTheme._();

  /// A [Color] instance that describes the primary color of the application.
  ///
  /// This color is used as the primary color of the application when it is in
  /// light mode.
  ///
  static const Color primary = Color(0xFFF8B631);

  /// A [Color] instance that describes the primary color of the application.
  ///
  /// This color is used as the primary color of the application when it is in
  /// dark mode.
  ///
  static const Color secondary = Color(0xFF006600);

  /// A [Color] instance that describes the primary color of the application.
  ///
  /// This color is used as the primary color of the application when it is in
  /// dark mode.
  ///
  static const Color darkPrimary = Color(0xFFF8B631);

  /// A [Color] instance that describes the secondary color of the application.
  ///
  /// This color is used as the secondary color of the application when it is in
  /// dark mode.
  ///
  static const Color darkSecondary = Color(0xFF045535);


  /// A [ThemeData] instance that describes the visual styling of the
  /// application when it is in dark mode.
  ///
  /// This theme is used when [MaterialApp.themeMode] is set to
  /// [ThemeMode.dark].
  ///
  /// This theme is similar to the default [MaterialApp] theme, but with
  /// a few tweaks to make it more suitable for light mode.
  ///
  /// The primary color is set to [AppTheme.darkPrimary], the secondary color
  /// is set to [AppTheme.darkSecondary], and the scaffold background color is
  /// set to [Colors.black].
  ///
  /// The app bar theme is set to an [AppBarTheme] with a background color
  /// of [AppTheme.darkSecondary].
  ///
  /// The text theme is set to a [TextTheme] with a body large style that
  /// has a color of [Colors.white].
  ///
  /// The color scheme is set to a [ColorScheme.dark] with the primary color
  /// set to [AppTheme.darkPrimary], and the secondary color set to
  /// [AppTheme.darkSecondary].
  ///
  /// The brightness is set to [Brightness.dark].
  ///
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: darkPrimary,
    colorScheme: const ColorScheme.dark(
      primary: darkPrimary,
      secondary: darkSecondary,
    ),
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: const AppBarTheme(backgroundColor: darkSecondary),
    textTheme: const TextTheme(bodyLarge: TextStyle(color: Colors.white)),
    fontFamily: 'Nunito Sans',
    drawerTheme: const DrawerThemeData(
      width: 250,
    )
  );

  /// A [ThemeData] instance that describes the visual styling of the
  /// application when it is in light mode.
  ///
  /// This theme is used when [MaterialApp.themeMode] is set to
  /// [ThemeMode.light].
  ///
  /// This theme is similar to the default [MaterialApp] theme, but with
  /// a few tweaks to make it more suitable for light mode.
  ///
  /// The primary color is set to [AppTheme.primary], the secondary color
  /// is set to [AppTheme.secondary], and the scaffold background color is
  /// set to [Colors.white].
  ///
  /// The app bar theme is set to an [AppBarTheme] with a background color
  /// of [AppTheme.secondary].
  ///
  /// The text theme is set to a [TextTheme] with a body large style that
  /// has a color of [Colors.black].
  ///
  /// The color scheme is set to a [ColorScheme.light] with the primary color
  /// set to [AppTheme.primary], and the secondary color set to
  /// [AppTheme.secondary].
  ///
  /// The brightness is set to [Brightness.light].
  ///
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: primary,
    colorScheme: const ColorScheme.light(
      primary: primary,
      secondary: secondary,
    ),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(backgroundColor: secondary.withValues(alpha: 0.9)),
    textTheme: const TextTheme(bodyLarge: TextStyle(color: Colors.black)),
    fontFamily: 'Nunito Sans',
    drawerTheme: const DrawerThemeData(
      width: 250,
    )
  );
}
