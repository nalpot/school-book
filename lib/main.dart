import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

/// The root widget of the SchoolBook application.
///
/// This widget is the root of your application and is responsible for:
/// - Setting up the app's theme and styling
/// - Initializing the main navigation
/// - Providing global configurations and dependencies
class MyApp extends StatelessWidget {
  /// Creates the root widget of the application.
  ///
  /// The [key] parameter is used to control how one widget replaces
  /// another widget in the tree. It is optional and typically not
  /// required for the root widget.
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      /// The title of the application.
      ///
      /// This value appears in the task manager and is used to identify
      /// the app.
      title: 'SchoolBook',
      
      /// The theme data for the application.
      ///
      /// Defines the default visual properties of Material widgets like colors,
      /// typography, and shape.
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        fontFamily: 'Nunito Sans',
      ),
      
      /// The widget for the home page of the application.
      ///
      /// This is the first screen users see when they launch the app.
      home: const MyHomePage(title: 'SchoolBook'),
    );
  }
}

/// The main screen of the SchoolBook application.
///
/// This widget is the home page of the application. It is stateful,
/// meaning that it has a State object that contains fields that affect
/// how it looks.
///
/// This page demonstrates how to use StatefulWidget and State classes to
/// manage state in a Flutter application.
class MyHomePage extends StatefulWidget {
  /// Creates a [MyHomePage] widget.
  ///
  /// The [title] parameter is required and will be displayed in the app bar.
  /// The [key] parameter is used to control how one widget replaces another
  /// widget in the tree.
  const MyHomePage({
    required this.title,
    super.key,
  });

  /// The title that will be displayed in the app bar.
  ///
  /// This is typically the name of the application and is displayed at the top
  /// of the screen in the app bar.
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

/// State for the [MyHomePage] widget.
///
/// This class holds the mutable state for the home page, including the counter
/// value and the method to increment it.
class _MyHomePageState extends State<MyHomePage> {
  /// The current value of the counter.
  ///
  /// This variable is private (denoted by the leading underscore) and
  /// should only be modified by calling [_incrementCounter].
  int _counter = 0;

  /// Increments the counter and triggers a rebuild of the UI.
  ///
  /// This method uses [setState] to increment the counter and notify
  /// the framework that the internal state has changed, which causes
  /// the widget to rebuild with the new counter value.
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// The application bar at the top of the screen.
      appBar: AppBar(
        /// The background color of the app bar, derived from the theme.
        backgroundColor: Theme.of(context)
            .colorScheme
            .inversePrimary,
        
        /// The title of the app bar, displaying the widget's title.
        title: Text(widget.title),
      ),
      
      /// The main content of the home page.
      body: Center(
        /// A column widget that centers its children both
        /// vertically and horizontally.
        child: Column(
          /// Aligns the children to the center of the main axis (vertically).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
