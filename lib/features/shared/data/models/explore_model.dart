import '../../../../core/utils/safe_convert.dart';

class ExploreModel {
  ExploreModel({required this.explore});

  factory ExploreModel.fromJson(Map<String, dynamic>? json) =>
      ExploreModel(explore: Explore.fromJson(asMap(json, 'explore')));

  final Explore explore;
}

class Explore {
  Explore({this.category = const []});

  factory Explore.fromJson(Map<String, dynamic>? json) => Explore(
    category:
        asList(json, 'category')
            .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>?))
            .toList(),
  );

  final List<CategoryModel> category;
}

class CategoryModel {
  CategoryModel({
    this.id = 0,
    this.count = 0,
    this.data = const [],
    this.img = '',
    this.name = '',
    this.dataCategory = const [],
  });

  factory CategoryModel.fromJson(Map<String, dynamic>? json) => CategoryModel(
    id: asInt(json, '_id'),
    count: asInt(json, 'count'),
    data:
        asList(
          json,
          'data',
        ).map((e) => BookModel.fromJson(e as Map<String, dynamic>?)).toList(),
    img: asString(json, 'img'),
    name: asString(json, 'name'),
    dataCategory:
        asList(json, 'data_category')
            .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>?))
            .toList(),
  );

  final int id;
  final int count;
  final String img;
  final String name;
  final List<BookModel> data;
  final List<CategoryModel> dataCategory;

  Map<String, dynamic> toJson() => {
    '_id': id,
    'count': count,
    'data': data.map((e) => e.toJson()).toList(),
    'img': img,
    'name': name,
    'data_category': dataCategory.map((e) => e.toJson()).toList(),
  };
}

class BookModel {
  BookModel({
    this.id = 0,
    this.categoryId = 0,
    this.file = '',
    this.img = '',
    this.name = '',
  });

  factory BookModel.fromJson(Map<String, dynamic>? json) => BookModel(
    id: asInt(json, '_id'),
    categoryId: asInt(json, 'category_id'),
    file: asString(json, 'file'),
    img: asString(json, 'img'),
    name: asString(json, 'name'),
  );

  final int id;
  final int categoryId;
  final String file;
  final String img;
  final String name;

  Map<String, dynamic> toJson() => {
    '_id': id,
    'category_id': categoryId,
    'file': file,
    'img': img,
    'name': name,
  };
}
