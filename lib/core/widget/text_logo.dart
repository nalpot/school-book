import 'package:flutter/material.dart';

class TextLogo extends StatelessWidget {
  const TextLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: 'School',
        children: [
          TextSpan(
            text: 'Book',
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
        ],
      ),
      style: Theme.of(context).textTheme.headlineMedium!.copyWith(
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}
