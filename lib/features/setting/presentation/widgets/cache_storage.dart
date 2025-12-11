import 'package:flutter/material.dart';

import '../../../../core/widget/svg_icon.dart';

class CacheStorage extends StatelessWidget {
  const CacheStorage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          const SvgIcon(Svgs.document),
          const SizedBox(width: 8),
          Text('Cache', style: Theme.of(context).textTheme.bodySmall),
          const Spacer(),
          const Text('0 KB'),
          const SizedBox(width: 8),
          const SvgIcon(Svgs.sync),
        ],
      ),
    );
  }
}
