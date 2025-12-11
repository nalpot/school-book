import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DownloadFolder extends StatelessWidget {
  const DownloadFolder({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            const Icon(CupertinoIcons.folder),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Download Folder',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  // TODO: Implement folder picker
                  Text(
                    '/sdcard/schoolbook', // Current download path
                    style: Theme.of(context).textTheme.labelSmall,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.arrow_forward_ios_rounded),
          ],
        ),
      ),
    );
  }
}
