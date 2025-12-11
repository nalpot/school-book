import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key, this.size = 46});

  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size * 0.1),
        child: Image.asset('assets/images/logo.png', fit: BoxFit.contain),
      ),
    );
  }
}
