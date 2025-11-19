import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widget/text_logo.dart';
import '../../../../routes/app_route.dart';
import 'explore_page.dart';
import 'library_page.dart';

part '../widgets/drawer.dart';

/// The root widget for the dashboard screen.
///
/// This widget is a [StatefulWidget] that manages the state for the dashboard's
/// tab controller and layout. It's the main container for the application's
/// primary navigation and content display.
class DashboardPage extends StatefulWidget {
  /// Creates a [DashboardPage] widget.
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

/// The state class for the [DashboardPage] widget.
///
/// Manages the tab controller and builds the dashboard UI with:
/// - App bar with title and search action
/// - Bottom tab bar for switching between main sections
/// - Tab view for displaying the current section's content
/// - Navigation drawer for app-wide navigation
class _DashboardPageState extends State<DashboardPage>
    with SingleTickerProviderStateMixin {
  /// Controller for managing the tab navigation between Library and Explore sections.
  late final TabController controller;

  @override
  void initState() {
    super.initState();
    // Initialize tab controller with 2 tabs: Library and Explore
    controller = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed
    controller.dispose();
    super.dispose();
  }

  /// Builds the dashboard UI with app bar, tab bar, and tab views.
  ///
  /// The layout consists of:
  /// 1. An app bar with the app title and search button
  /// 2. A tab bar for switching between Library and Explore sections
  /// 3. A drawer for app navigation
  /// 4. Tab views that display the current section's content
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'SCHOOL BOOK',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
        // Tab bar for switching between main sections
        bottom: TabBar(
          unselectedLabelColor: Colors.white,
          controller: controller,
          dividerColor: Colors.transparent,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold),
          // Tab bar items with icons and labels
          tabs: const [
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.menu_book),
                  SizedBox(width: 10),
                  Text('Library'),
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.explore),
                  SizedBox(width: 10),
                  Text('Explore'),
                ],
              ),
            ),
          ],
        ),
      ),
      // Navigation drawer for app-wide navigation
      drawer: const Drawer(child: AppDrawer()),
      // Tab views for each section
      body: TabBarView(
        controller: controller,
        children: const [
          LibraryPage(),  // Library tab content
          ExplorePage(),  // Explore tab content
        ],
      ),
    );
  }
}
