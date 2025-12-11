import 'package:flutter/material.dart';

import '../../../../core/widget/svg_icon.dart';

class SdcardStorage extends StatelessWidget {
  const SdcardStorage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          const SvgIcon(Svgs.server),
          const SizedBox(width: 8),
          Text('SD Card', style: Theme.of(context).textTheme.bodySmall),
          const Spacer(),
          const Text('100 MB'),
          const SizedBox(width: 8),
          const SvgIcon(Svgs.sync),
        ],
      ),
    );
  }
}
