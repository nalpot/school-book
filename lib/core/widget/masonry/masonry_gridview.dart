import 'package:flutter/material.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

class MasonryGridView extends StatelessWidget {
  const MasonryGridView({
    required this.children,
    this.footer,
    super.key,
  });

  final List<Widget> children;
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.all(10),
          sliver: SliverWaterfallFlow.extent(
            maxCrossAxisExtent: 300,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            children: children,
          ),
        ),

        // --- Load More Indicator ---
        SliverToBoxAdapter(child: footer),
      ],
    );
  }
}
