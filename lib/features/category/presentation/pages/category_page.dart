import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widget/masonry/masonry_gridview.dart';
import '../../../../di.dart';
import '../../../../routes/app_route.dart';
import '../../../shared/domain/repositories/book_repository.dart';
import '../../../shared/widgets/node_tile.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({required this.id, super.key});

  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: FutureBuilder(
          future: sl<BookRepository>().getCategory(id),
          builder: (context, snapshot) {
            return Text(
              '${snapshot.data?.name}',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: sl<BookRepository>().getCategoryChildren(id),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final nodes = snapshot.data!;

            return MasonryGridView(
              children: List.generate(nodes.length, (index) {
                final node = nodes[index];
                return Card(
                  margin: EdgeInsets.zero,
                  clipBehavior: Clip.hardEdge,
                  child: NodeTile(
                    node: node,
                    onCategoryTap: (category) {
                      context.pushNamed(
                        AppRoutePath.category.name,
                        pathParameters: {'id': category.id.toString()},
                      );
                    },
                    onBookTap: (book) {
                      context.pushNamed(
                        AppRoutePath.reader.name,
                        pathParameters: {'id': book.id.toString()},
                      );
                    },
                  ),
                );
              }),
            );
          },
        ),
      ),
    );
  }
}
