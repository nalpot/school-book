import 'package:hive/hive.dart';

import 'local_storage.dart';

class HiveLocalStorage extends LocalStorage {
  Box<T> box<T>(BoxName boxName) => Hive.box<T>(boxName.name);

  @override
  Future<void> delete<T>({required String key, BoxName? boxName}) async {
    assert(boxName != null, 'boxName is required');

    final box = Hive.box<T>(boxName!.name);
    await box.delete(key);
  }

  @override
  Future<T?> load<T>({required String key, BoxName? boxName}) async {
    assert(boxName != null, 'boxName is required');

    final box = Hive.box<T>(boxName!.name);
    final value = box.get(key);
    if (value == null) return null;
    return value as T;
  }

  @override
  Future<void> save<T>({
    required String key,
    required value,
    BoxName? boxName,
  }) async {
    assert(boxName != null, 'boxName is required');

    final box = Hive.box<T>(boxName!.name);
    await box.put(key, value);
  }
}
