import 'package:flutter/foundation.dart';

typedef PageFetcher<T> = Future<List<T>> Function(int page);

class ScrollRequestController<T> extends ChangeNotifier {
  ScrollRequestController({required this.fetcher});

  final PageFetcher<T> fetcher;

  final List<T> _items = [];

  List<T> get items => List.unmodifiable(_items);

  int get length => _items.length;

  T getItem(int index) => _items[index];

  int _page = 1;

  bool _isRefreshing = false;
  bool _isLoadingMore = false;
  bool _hasMore = true;

  bool get isRefreshing => _isRefreshing;

  bool get isLoadingMore => _isLoadingMore;

  bool get hasMore => _hasMore;

  // ======================================================
  // REFRESH
  // ======================================================
  Future<void> refresh() async {
    if (_isRefreshing) return;

    _isLoadingMore = false;
    _isRefreshing = true;
    _page = 1;
    _hasMore = true;

    try {
      final data = await fetcher(_page);
      _items
        ..clear()
        ..addAll(data);

      _hasMore = data.isNotEmpty;
    } finally {
      _isRefreshing = false;
      notifyListeners();
    }
  }

  // ======================================================
  // LOAD MORE
  // ======================================================
  Future<void> loadMore() async {
    if (_isLoadingMore || !_hasMore) return;

    _isLoadingMore = true;
    _page++;

    try {
      print('loadmore requested');
      final data = await fetcher(_page);

      if (data.isEmpty) {
        _hasMore = false;
      } else {
        _items.addAll(data);
      }
    } finally {
      _isLoadingMore = false;
      notifyListeners();
    }
  }
}
