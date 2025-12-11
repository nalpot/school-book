import 'package:hive_flutter/hive_flutter.dart';

part 'category_entity.g.dart';

@HiveType(typeId: 1)
class CategoryEntity extends HiveObject {
  CategoryEntity({
    required this.id,
    required this.parentId,
    required this.name,
    required this.img,
    required this.count,
    required this.bookIds,
    required this.subCategoryIds,
  });

  @HiveField(0)
  int id;

  @HiveField(6)
  int? parentId;

  @HiveField(1)
  String name;

  @HiveField(2)
  String img;

  @HiveField(3)
  int count;

  @HiveField(4)
  List<int> bookIds;    // IDs of books in "data"

  @HiveField(5)
  List<int> subCategoryIds;  // IDs of "data_category"
}
