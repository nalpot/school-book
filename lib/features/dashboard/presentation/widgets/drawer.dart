part of '../pages/dashboard_page.dart';

/// Custom drawer widget for the application's navigation.
///
/// This widget provides a navigation drawer with links to various sections
/// of the app, including Download, Settings, and About pages.
/// It's used as the primary navigation component in the [DashboardPage].
///
/// The drawer includes:
/// - App logo and branding
/// - Navigation items with icons
/// - Handles navigation using GoRouter
class AppDrawer extends StatelessWidget {
  /// Creates an [AppDrawer] instance.
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              // Drawer header with app logo and branding
              const DividerTheme(
                data: DividerThemeData(
                  color: Colors.grey,
                  thickness: 0.2,
                ),
                child: DrawerHeader(
                  child: Column(
                    children: [
                      FlutterLogo(size: 56),
                      SizedBox(height: 24),
                      TextLogo(),
                    ],
                  ),
                ),
              ),
              // Navigation items
              ListTile(
                title: _widgetTitle(Icons.cloud_download_outlined, 'Download'),
                onTap: () => _onTap(context, AppRoutePath.download),
              ),
              ListTile(
                title: _widgetTitle(Icons.settings_outlined, 'Setting'),
                onTap: () => _onTap(context, AppRoutePath.setting),
              ),
              ListTile(
                title: _widgetTitle(Icons.info_outlined, 'About'),
                onTap: () => _onTap(context, AppRoutePath.about),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Handles navigation when a drawer item is tapped.
  ///
  /// This method:
  /// 1. Closes the drawer
  /// 2. Navigates to the specified route
  ///
  /// Parameters:
  /// * [ctx] - The build context for navigation
  /// * [route] - The target route to navigate to
  void _onTap(BuildContext ctx, AppRoutePath route) {
    ctx
      ..pop()
      ..push(route.path);
  }

  /// Creates a row widget with an icon and text, typically used for drawer items.
  ///
  /// Parameters:
  /// * [icon] - The icon to display
  /// * [title] - The text to display next to the icon
  ///
  /// Returns a [Row] containing the icon and text with proper spacing.
  Widget _widgetTitle(IconData icon, String title) {
    return Row(
      children: [
        Icon(icon),
        const SizedBox(width: 10),
        Text(title),
      ],
    );
  }
}
