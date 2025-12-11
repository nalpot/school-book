import 'package:firebase_database/firebase_database.dart';

import '../models/explore_model.dart';

/// Handles remote data operations for books from Firebase Database
class BookRemoteDataSources {
  /// Constructor with optional database parameter for testing
  /// If no database is provided, uses the default Firebase Database instance
  BookRemoteDataSources({FirebaseDatabase? database})
    : _database = database ?? FirebaseDatabase.instance;

  // Private instance of FirebaseDatabase for database operations
  final FirebaseDatabase _database;

  /// Fetches books from Firebase Database
  ///
  /// [page] - The page number to fetch (currently not used in implementation)
  /// Returns [ExploreModel] containing the list of books
  /// Throws [Exception] if the explore node is empty or data format is invalid
  Future<ExploreModel> fetchBooks(int page) async {
    // Get reference to 'explore' node in Firebase
    final ref = _database.ref('explore');
    // Fetch data once from the database
    final snapshot = await ref.get();

    // Check if data exists
    if (!snapshot.exists || snapshot.value == null) {
      throw Exception('explore node is empty');
    }

    // Normalize the data to ensure consistent format
    final data = _normalize(snapshot.value);

    // Validate the data format
    if (data is! Map<String, dynamic>) {
      throw Exception('Invalid Firebase data format');
    }

    // Convert JSON data to ExploreModel
    return ExploreModel(explore: Explore.fromJson(data));
  }

  /// Recursively normalizes Firebase data to ensure consistent types
  ///
  /// [value] - The value to normalize (can be Map, List, or primitive type)
  /// Returns normalized data with consistent types
  dynamic _normalize(dynamic value) {
    // Handle Map type - convert all keys to String and normalize values
    if (value is Map) {
      return value.map((k, v) => MapEntry(k.toString(), _normalize(v)));
    }

    // Handle List type - normalize each element
    if (value is List) {
      return value.map(_normalize).toList();
    }

    // Return primitive types as-is
    return value;
  }
}
