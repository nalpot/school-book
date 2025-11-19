import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/blocs/theme/theme_bloc.dart';

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
            const SizedBox(height: 24),
            SingleChildScrollView(
              child: Column(
                children: [
                  // Theme selection card
                  Card(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    child: InkWell(
                      onTap:
                          () =>
                              context.read<ThemeBloc>().add(ToggleThemeEvent()),
                      borderRadius: BorderRadius.circular(12),
                      child: BlocBuilder<ThemeBloc, ThemeState>(
                        builder: (context, state) {
                          return Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Icon(
                                  state.isDarkMode
                                      ? Icons.dark_mode_rounded
                                      : Icons.light_mode_rounded,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Theme',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                const Spacer(),
                                Text(
                                  state.isDarkMode ? 'Dark' : 'Light',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                const Icon(Icons.arrow_forward_ios_rounded),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Language selection card
                  Card(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          const Icon(Icons.language),
                          const SizedBox(width: 8),
                          Text(
                            'Language',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
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
                  ),
                  const SizedBox(height: 16),
                  // Download folder selection card
                  Card(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          const Icon(Icons.folder_outlined),
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
                  ),
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
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Row(
                              children: [
                                const Icon(Icons.history_edu),
                                const SizedBox(width: 8),
                                Text(
                                  'Cache',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                const Spacer(),
                                const Text('0 KB'),
                                const SizedBox(width: 8),
                                const Icon(Icons.recycling_rounded),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Row(
                              children: [
                                const Icon(Icons.storage_outlined),
                                const SizedBox(width: 8),
                                Text(
                                  'SD Card',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                const Spacer(),
                                const Text('100 MB'),
                                const SizedBox(width: 8),
                                const Icon(Icons.recycling_rounded),
                              ],
                            ),
                          ),
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
                color: Theme.of(context).disabledColor.withValues(alpha: 0.2),
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
