import '../../data/models/explore_model.dart';
import '../entities/category_node.dart';
import '../repositories/book_repository.dart';

class FetchBookUseCase {
  FetchBookUseCase({required this.bookRepository});

  final BookRepository bookRepository;

  Future<List<CategoryNode>> call(int page) async {
    return bookRepository.fetchBooks(page);
  }
}
