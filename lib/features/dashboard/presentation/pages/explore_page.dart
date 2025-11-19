import 'package:flutter/material.dart';

class ExplorePage extends StatefulWidget {
  /// Creates an [ExplorePage] instance.
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

/// The state class for the [ExplorePage] widget.
///
/// Manages the layout and rendering of the grid of book covers.
class _ExplorePageState extends State<ExplorePage> {
  @override
  Widget build(BuildContext context) {
    // Calculate responsive dimensions for grid items
    final size = MediaQuery.of(context).size;
    final itemWidth = size.width / 2; // 2 items per row
    const itemHeight = 300; // Fixed height for each grid item

    return GridView.count(
      // Configure grid layout
      childAspectRatio: itemWidth / itemHeight,
      // Maintain aspect ratio
      padding: const EdgeInsets.all(8),
      // Consistent spacing around grid
      crossAxisCount: 3,
      // Number of columns in the grid
      shrinkWrap: true,
      // Allow the grid to be scrolled within parent
      // Generate list of book cards
      children: List.generate(10, (index) {
        return Card(
          clipBehavior: Clip.hardEdge,
          // Ensure content stays within card bounds
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Book cover image
              // TODO: Replace with actual book data from a repository
              Image.asset(
                'assets/images/Bahasa_Indonesia_BS_KLS_X_Rev_Cover.png',
                // Cover the available space while maintaining aspect ratio
                fit: BoxFit.cover,
              ),
              // Book title overlay with gradient background
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    // Gradient from transparent to semi-transparent black
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.9),
                        // 90% opacity black
                      ],
                    ),
                  ),
                  // Book title text
                  child: Text(
                    'Bahasa Indonesia', // TODO: Replace with actual book title
                    overflow: TextOverflow.ellipsis, // Handle long titles
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white, // White text for contrast
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
