import '../../../shared/domain/entities/book_entity.dart';
import '../../../shared/domain/repositories/book_repository.dart';

class GetBookUseCase {
  GetBookUseCase({required BookRepository bookRepository})
    : repository = bookRepository;

  final BookRepository repository;

  Future<BookEntity> call(int id) async {
    return repository.getBook(id);
  }
}
