import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/helper.dart';
import '../../../core/widget/masonry/dynamic_height_image.dart';
import '../domain/entities/book_entity.dart';
import '../domain/entities/category_entity.dart';
import '../domain/entities/category_node.dart';

typedef CategoryTap = void Function(CategoryEntity category);
typedef BookTap = void Function(BookEntity book);

class NodeTile extends StatelessWidget {
  const NodeTile({
    required this.node,
    required this.onCategoryTap,
    required this.onBookTap,
    super.key,
  });

  final CategoryNode node;
  final CategoryTap onCategoryTap;
  final BookTap onBookTap;

  @override
  Widget build(BuildContext context) {
    return switch (node) {
      CategoryNodeCategory(:final category) => _CategoryTile(
        category: category,
        onTap: () => onCategoryTap(category),
      ),
      CategoryNodeBook(:final book) => _BookTile(
        book: book,
        onTap: () => onBookTap(book),
      ),
    };
  }
}

class _CategoryTile extends StatelessWidget {
  const _CategoryTile({required this.category, required this.onTap});

  final CategoryEntity category;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Stack(children: [_buildCover(context), _TextName(category.name)]),
    );
  }

  Widget _buildCover(BuildContext context) {
    if (isValidImage(category.img)) {
      return DynamicHeightImage(imageUrl: category.img);
    }

    return AspectRatio(
      aspectRatio: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: FittedBox(
          fit: BoxFit.fitWidth,
          child: Icon(
            CupertinoIcons.folder_fill,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}

class _BookTile extends StatelessWidget {
  const _BookTile({required this.book, required this.onTap});

  final BookEntity book;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Stack(
        children: [
          _buildCover(context),
          const SizedBox(height: 4),
          _TextName(book.name),
        ],
      ),
    );
  }

  Widget _buildCover(BuildContext context) {
    if (isValidImage(book.img)) {
      return DynamicHeightImage(imageUrl: book.img);
    }

    return AspectRatio(
      aspectRatio: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: FittedBox(
          fit: BoxFit.fitWidth,
          child: Icon(
            CupertinoIcons.book,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}

class _TextName extends StatelessWidget {
  const _TextName(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          // Gradient from transparent to semi-transparent black
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.black.withValues(alpha: 0.6),
              // 90% opacity black
            ],
          ),
        ),
        // Book title text
        child: Text(
          text,
          overflow: TextOverflow.ellipsis,
          // Handle long titles
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Colors.white, // White text for contrast
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
