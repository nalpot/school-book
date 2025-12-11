import '../entities/book_entity.dart';
import '../entities/category_node.dart';
import '../../data/models/explore_model.dart';
import '../entities/category_entity.dart';

abstract class BookRepository {
  Future<List<CategoryNode>> fetchBooks(int page);

  Future<CategoryEntity> getCategory(String id);

  Future<List<CategoryNode>> getRootCategories();

  Future<List<CategoryNode>> getCategoryChildren(String id);

  Future<BookEntity> getBook(int id);
}
