enum BoxName {
  theme,
  accounts,
  books,
  categories,
}

abstract class LocalStorage {

  /// Save the data to storage
  Future<void> save<T>({
    required String key,
    required T value,
    BoxName? boxName,
  });

  /// Load the data from storage
  Future<T?> load<T>({
    required String key,
    BoxName? boxName,
  });

  /// Delete the data from storage
  Future<void> delete<T>({
    required String key,
    BoxName? boxName,
  });
}
