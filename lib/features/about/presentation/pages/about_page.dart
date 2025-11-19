import 'dart:io';

import 'package:flutter/material.dart';

import '../../domain/entities/about_item_entity.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  final items = const [
    AboutItemEntity(title: 'Version 1.0.0 (1)'),
    AboutItemEntity(title: 'Privacy Policy'),
    AboutItemEntity(title: 'Terms of Use'),
  ];

  final description =
      'SchoolBook merupakan aplikasi terapan untuk buku sekolah '
      'elektronik dalam rangka memenuhi kebutuhan buku ajar pelajar. '
      'Memanfaatkan kemajuan teknologi, Aplikasi ini menjadi sumber '
      'bagi para pelajar untuk mendapatkan koleksi buku secara '
      'lengkap, mudah dan gratis.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'ABOUT',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: DividerTheme(
          data: const DividerThemeData(color: Colors.grey, thickness: 0.2),
          child: Column(
            children: [
              const SizedBox(height: 24),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const FlutterLogo(size: 56),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          description,
                          textAlign: TextAlign.center,
                        ),
                      ),

                      for (final item in items) ...[
                        const Divider(),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 16,
                          ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              item.title,
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(fontStyle: FontStyle.italic),
                            ),
                          ),
                        ),
                      ],
                      const Divider(),
                    ],
                  ),
                ),
              ),
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
      ),
    );
  }
}
