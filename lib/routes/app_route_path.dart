part of 'app_route.dart';

/// Enum that represents the available routes in the application.
///
enum AppRoutePath {
  dashboard('/'),
  about('/about'),
  splash('/splash'),
  download('/download'),
  search('/search'),
  setting('/setting');

  const AppRoutePath(this.path);

  /// The path of the route.
  final String path;

  @override
  String toString() => path;
}
