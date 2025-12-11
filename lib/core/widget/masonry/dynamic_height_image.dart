import 'dart:async';
import 'dart:ui' as ui;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// A lightweight image widget that:
/// - Reads image header once (cheap)
/// - Computes aspect ratio on the fly
/// - Caches the result to avoid repeated decoding
/// - Works perfectly with grids like WaterfallFlow
class DynamicHeightImage extends StatelessWidget {
  const DynamicHeightImage({
    super.key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.borderRadius,
  });

  final String imageUrl;
  final BoxFit fit;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: fit,
        imageBuilder: (context, imageProvider) {
          return _AspectRatioImage(
            imageProvider: imageProvider,
            fit: fit,
          );
        },
        placeholder: (_, __) => const AspectRatio(
          aspectRatio: 1,
          child: Center(child: CircularProgressIndicator(strokeWidth: 1.5)),
        ),
        errorWidget: (_, __, ___) => const AspectRatio(
          aspectRatio: 1,
          child: Icon(Icons.broken_image),
        ),
      ),
    );
  }
}

class _AspectRatioImage extends StatefulWidget {
  const _AspectRatioImage({
    required this.imageProvider,
    required this.fit,
  });

  final ImageProvider imageProvider;
  final BoxFit fit;

  @override
  State<_AspectRatioImage> createState() => _AspectRatioImageState();
}

class _AspectRatioImageState extends State<_AspectRatioImage> {
  double? _aspectRatio;

  @override
  void initState() {
    super.initState();
    _resolve();
  }

  void _resolve() {
    final stream = widget.imageProvider.resolve(ImageConfiguration.empty);

    late final ImageStreamListener listener;
    listener = ImageStreamListener((info, _) {
      final w = info.image.width.toDouble();
      final h = info.image.height.toDouble();

      if (mounted) {
        setState(() {
          _aspectRatio = (w == 0 || h == 0) ? 1 : w / h;
        });
      }

      stream.removeListener(listener);
    });

    stream.addListener(listener);
  }

  @override
  Widget build(BuildContext context) {
    final ratio = _aspectRatio ?? 1;

    return AspectRatio(
      aspectRatio: ratio,
      child: Image(
        image: widget.imageProvider,
        fit: widget.fit,
      ),
    );
  }
}
