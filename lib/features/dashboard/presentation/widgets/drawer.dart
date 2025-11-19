import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widget/text_logo.dart';
import '../../../../routes/app_route.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DividerTheme(
                data: DividerThemeData(color: Colors.grey, thickness: 0.2),
                child: DrawerHeader(
                  child: Column(
                    children: [
                      FlutterLogo(size: 56),
                      SizedBox(height: 24),
                      TextLogo(),
                    ],
                  ),
                ),
              ),
              ListTile(
                title: _widgetTitle(Icons.cloud_download_outlined, 'Download'),
                onTap: () {
                  _onTap(context, AppRoutePath.download);
                },
              ),
              ListTile(
                title: _widgetTitle(Icons.settings_outlined, 'Setting'),
                onTap: () {
                  _onTap(context, AppRoutePath.setting);
                },
              ),
              ListTile(
                title: _widgetTitle(Icons.info_outlined, 'About'),
                onTap: () {
                  _onTap(context, AppRoutePath.about);
                },
              ),
            ],
          ),
        ),

        // copyright
        // Padding(
        //   padding: const EdgeInsets.only(bottom: 56),
        //   child: Text(
        //     '© 2025 ALL RIGHT RESERVED',
        //     textAlign: TextAlign.center,
        //     style: Theme.of(
        //       context,
        //     ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
        //   ),
        // ),
      ],
    );
  }

  void _onTap(BuildContext ctx, AppRoutePath route) {
    ctx
      ..pop()
      ..push(route.path);
  }

  Widget _widgetTitle(IconData icon, String title) {
    return Row(children: [Icon(icon), const SizedBox(width: 10), Text(title)]);
  }
}
