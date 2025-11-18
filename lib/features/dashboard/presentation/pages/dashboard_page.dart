import 'package:flutter/material.dart';

import '../widgets/drawer.dart';
import 'explore_page.dart';
import 'library_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with SingleTickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'SCHOOL BOOK',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
        bottom: TabBar(
          unselectedLabelColor: Colors.white,
          controller: controller,
          dividerColor: Colors.transparent,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold),
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
      drawer: const Drawer(child: AppDrawer()),
      body: TabBarView(
        controller: controller,
        children: const [LibraryPage(), ExplorePage()],
      ),
    );
  }
}
