import 'package:hive_flutter/hive_flutter.dart';

import '../../../../core/cache/hive_local_storage.dart';
import '../../../../core/cache/local_storage.dart';
import '../../domain/entities/book_entity.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/entities/category_node.dart';
import '../models/explore_model.dart';

class BookLocalDataSource {
  BookLocalDataSource({required LocalStorage localStorage})
    : _localStorage = localStorage;

  final LocalStorage _localStorage;

  Box<CategoryEntity> get categoryBox => (_localStorage as HiveLocalStorage)
      .box<CategoryEntity>(BoxName.categories);

  Box<BookEntity> get bookBox =>
      (_localStorage as HiveLocalStorage).box<BookEntity>(BoxName.books);

  Future<void> saveExplore(List<CategoryModel> categories) async {
    for (final category in categories) {
      await _parseCategory(category);
    }
  }

  Future<void> _parseCategory(CategoryModel category, {int? parentId}) async {
    final categoryId = category.id;

    // Extract books
    final bookIds = <int>[];
    for (final book in category.data) {
      final model = BookEntity(
        id: book.id,
        categoryId: book.categoryId,
        file: book.file,
        img: book.img,
        name: book.name,
      );
      await bookBox.put(model.id, model);
      bookIds.add(model.id);
    }

    // Extract subcategories
    final subIds = <int>[];
    for (final data in category.dataCategory) {
      subIds.add(data.id);
      await _parseCategory(data, parentId: categoryId);
    }

    // Save category
    final categoryEntity = CategoryEntity(
      id: categoryId,
      parentId: parentId,
      name: category.name,
      img: category.img,
      count: category.count,
      bookIds: List<int>.from(bookIds),
      subCategoryIds: List<int>.from(subIds),
    );

    await categoryBox.put(categoryId, categoryEntity);
  }

  Future<CategoryEntity> getCategory(String id) async {
    final catId = int.tryParse(id);
    if (catId == null) throw Exception('Category id not valid');

    final category = categoryBox.get(catId);

    if (category == null) {
      throw Exception('Category not found');
    }

    return category;
  }

  List<CategoryEntity> searchCategory(String q) {
    return categoryBox.values
        .where((c) => c.name.toLowerCase().contains(q.toLowerCase()))
        .toList();
  }

  List<BookEntity> searchBooks(String q) {
    return bookBox.values
        .where((b) => b.name.toLowerCase().contains(q.toLowerCase()))
        .toList();
  }

  List<BookEntity> getBooks(int categoryId) {
    final category = categoryBox.get(categoryId);
    if (category == null) return [];

    return category.bookIds.map(bookBox.get).whereType<BookEntity>().toList();
  }

  BookEntity getBook(int id) {
    final book = bookBox.get(id);
    if (book == null) throw Exception('Book not found');
    return book;
  }

  /// Get root categories (categories without parent)
  Future<List<CategoryNode>> getRootCategories() async {
    final categories =
        categoryBox.values.where((c) => c.parentId == null).toList();
    final nodes = <CategoryNode>[];
    for (final category in categories) {
      nodes.add(CategoryNodeCategory(category));
    }
    return nodes;
  }

  /// Get category children for sub categories
  Future<List<CategoryNode>> getCategoryChildren(String categoryId) async {
    final catId = int.tryParse(categoryId);
    if (catId == null) return [];

    final cat = categoryBox.get(catId);
    if (cat == null) return [];

    final nodes = <CategoryNode>[];

    // categories
    for (final id in cat.subCategoryIds) {
      final c = categoryBox.get(id);
      if (c != null) nodes.add(CategoryNodeCategory(c));
    }

    // books
    for (final id in cat.bookIds) {
      final b = bookBox.get(id);
      if (b != null) nodes.add(CategoryNodeBook(b));
    }
    return nodes;
  }
}
