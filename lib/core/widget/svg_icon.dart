import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

enum Svgs {
  library('library.svg'),
  document('document-text-outline.svg'),
  server('server-outline.svg'),
  globe('globe-outline.svg'),
  refresh('refresh-outline.svg'),
  sync('sync-outline.svg'),
  ;
  const Svgs(this._path);

  final String _path;

  String get path => 'assets/icons/$_path';
}

class SvgIcon extends StatelessWidget {
  const SvgIcon(this.icons, {super.key, this.color, this.size});

  final Svgs icons;
  final Color? color;
  final double? size;

  @override
  Widget build(BuildContext context) {
    final color = DefaultTextStyle.of(context).style.color;

    final iconSize = Size.square(size ?? 24);

    return SvgPicture.asset(
      icons.path,
      width: iconSize.width,
      height: iconSize.height,
      colorFilter: ColorFilter.mode(color!, BlendMode.srcIn),
    );
  }
}
