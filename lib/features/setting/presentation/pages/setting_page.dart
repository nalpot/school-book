import 'dart:io';

import 'package:flutter/material.dart';

import '../widgets/cache_storage.dart';
import '../widgets/download_folder.dart';
import '../widgets/language.dart';
import '../widgets/sdcard_storage.dart';
import '../widgets/theme_switcher.dart';

class SettingPage extends StatefulWidget {
  /// Creates a [SettingPage] instance.
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    // Main scaffold for the settings page
    return Scaffold(
      // App bar with title and back button
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'SETTING',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  // Theme selection card
                  const ThemeSwitcher(),
                  const SizedBox(height: 16),
                  // Language selection card
                  const Language(),
                  const SizedBox(height: 16),
                  // Download folder selection card
                  const DownloadFolder(),
                  const SizedBox(height: 48),
                  // Storage information section
                  DividerTheme(
                    data: const DividerThemeData(
                      color: Colors.grey,
                      thickness: 0.2,
                      space: 0, // No extra space around the divider
                    ),
                    child: Card(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              'File Size',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                          const Divider(),
                          const CacheStorage(),
                          const SdcardStorage(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            // App version and platform information footer
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context).disabledColor.withValues(alpha: 0.1),
              ),
              child: Text(
                'SchoolBook (${Platform.operatingSystem}) v1.0.0 (1)',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
