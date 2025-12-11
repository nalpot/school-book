import 'package:hive_flutter/hive_flutter.dart';

part 'book_entity.g.dart';

@HiveType(typeId: 2)
class BookEntity extends HiveObject{
  BookEntity({
    required this.id,
    required this.categoryId,
    required this.file,
    required this.img,
    required this.name,
  });

  @HiveField(0)
  int id;

  @HiveField(1)
  int categoryId;

  @HiveField(2)
  String file;

  @HiveField(3)
  String img;

  @HiveField(4)
  String name;
}
