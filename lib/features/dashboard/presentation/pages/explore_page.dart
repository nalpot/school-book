import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widget/masonry/masonry_gridview.dart';
import '../../../../core/widget/scroll_request_controller.dart';
import '../../../../core/widget/scroll_request_handler.dart';
import '../../../../di.dart';
import '../../../../routes/app_route.dart';
import '../../../shared/domain/entities/category_node.dart';
import '../../../shared/domain/usecases/fetch_book_usecase.dart';
import '../../../shared/widgets/node_tile.dart';

class ExplorePage extends StatefulWidget {
  /// Creates an [ExplorePage] instance.
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

/// The state class for the [ExplorePage] widget.
///
/// Manages the layout and rendering of the grid of book covers.
class _ExplorePageState extends State<ExplorePage> {
  late final ScrollRequestController<CategoryNode> controller;

  @override
  void initState() {
    super.initState();
    controller = ScrollRequestController<CategoryNode>(fetcher: fetchImages);
    controller.refresh();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  /// API call
  Future<List<CategoryNode>> fetchImages([int page = 1]) async {
    if (page > 1) return []; // no more data
    return sl<FetchBookUseCase>().call(page);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ScrollRequestHandler(
        enableLoadMore: false,
        controller: controller,
        child: AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            return MasonryGridView(
              children: List.generate(controller.length, (index) {
                final item = controller.getItem(index);

                return Card(
                  margin: EdgeInsets.zero,
                  clipBehavior: Clip.hardEdge,
                  child: NodeTile(
                    node: item,
                    onCategoryTap: (category) {
                      context.pushNamed(
                        AppRoutePath.category.name,
                        pathParameters: {'id': category.id.toString()},
                      );
                    },
                    onBookTap: (book) {},
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
