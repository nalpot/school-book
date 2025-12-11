import '../../domain/entities/book_entity.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/entities/category_node.dart';
import '../../domain/repositories/book_repository.dart';
import '../datasources/book_local_datasource.dart';
import '../datasources/book_remote_datasources.dart';
import '../models/explore_model.dart';

class BookRepositoryImpl implements BookRepository {
  BookRepositoryImpl({
    required this.bookRemoteDataSources,
    required this.bookLocalDataSource,
  });

  final BookRemoteDataSources bookRemoteDataSources;
  final BookLocalDataSource bookLocalDataSource;

  @override
  Future<List<CategoryNode>> fetchBooks(int page) async {
    final result = await bookRemoteDataSources.fetchBooks(page);
    await bookLocalDataSource.saveExplore(result.explore.category);
    return getRootCategories();
  }

  @override
  Future<CategoryEntity> getCategory(String id) {
    return bookLocalDataSource.getCategory(id);
  }

  @override
  Future<List<CategoryNode>> getRootCategories() {
    return bookLocalDataSource.getRootCategories();
  }

  @override
  Future<List<CategoryNode>> getCategoryChildren(String id) {
    return bookLocalDataSource.getCategoryChildren(id);
  }

  @override
  Future<BookEntity> getBook(int id) async {
    return bookLocalDataSource.getBook(id);
  }
}
