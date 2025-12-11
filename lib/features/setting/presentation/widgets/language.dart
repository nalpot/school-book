import 'package:flutter/material.dart';

import '../../../../core/widget/svg_icon.dart';

class Language extends StatelessWidget {
  const Language({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            const SvgIcon(Svgs.globe),
            const SizedBox(width: 8),
            Text('Language', style: Theme.of(context).textTheme.bodyMedium),
            const Spacer(),
            // TODO: Implement language selection logic
            Text(
              'English', // Current selected language
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const Icon(Icons.arrow_forward_ios_rounded),
          ],
        ),
      ),
    );
  }
}
