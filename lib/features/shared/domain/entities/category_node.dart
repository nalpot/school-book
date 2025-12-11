import 'book_entity.dart';
import 'category_entity.dart';

sealed class CategoryNode {
  const CategoryNode();
}

class CategoryNodeCategory extends CategoryNode {
  const CategoryNodeCategory(this.category);

  final CategoryEntity category;
}

class CategoryNodeBook extends CategoryNode {
  const CategoryNodeBook(this.book);

  final BookEntity book;
}
