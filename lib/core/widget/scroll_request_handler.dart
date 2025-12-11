import 'package:flutter/material.dart';

import 'scroll_request_controller.dart';

class ScrollRequestHandler<T> extends StatelessWidget {
  const ScrollRequestHandler({
    required this.controller,
    required this.child,
    this.enableLoadMore = true,
    super.key,
    this.loadMoreOffset = 200,
  });

  final ScrollRequestController<T> controller;
  final bool enableLoadMore;

  final Widget child;
  final double loadMoreOffset;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: controller.refresh,
      strokeWidth: 2,
      child: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (!enableLoadMore) return false;

          final metrics = notification.metrics;

          final nearBottom =
              metrics.pixels >= metrics.maxScrollExtent - loadMoreOffset;

          if (nearBottom) {
            controller.loadMore();
          }

          return false;
        },
        child: child,
      ),
    );
  }
}
