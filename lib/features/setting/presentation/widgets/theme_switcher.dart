import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/blocs/theme/theme_bloc.dart';

class ThemeSwitcher extends StatelessWidget {
  const ThemeSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: InkWell(
        onTap: () => context.read<ThemeBloc>().add(ToggleThemeEvent()),
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
                  Text('Theme', style: Theme.of(context).textTheme.bodyMedium),
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
    );
  }
}
