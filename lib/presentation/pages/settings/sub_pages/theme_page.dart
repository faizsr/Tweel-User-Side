import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/core/utils/ktweel_icons.dart';
import 'package:tweel_social_media/presentation/cubit/theme/theme_cubit.dart';

class ThemeSwitchPage extends StatelessWidget {
  const ThemeSwitchPage({
    super.key,
  });

  final List<(String, ThemeMode)> _themes = const [
    ('Dark', ThemeMode.dark),
    ('Light', ThemeMode.light),
    ('System', ThemeMode.system),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'Change Theme',
          style: TextStyle(fontSize: 20),
        ),
        titleSpacing: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Ktweel.arrow_left),
        ),
      ),
      body: Center(
        child: BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, selectedTheme) {
            return Column(
              children: List.generate(
                _themes.length,
                (index) {
                  final String label = _themes[index].$1;
                  final ThemeMode theme = _themes[index].$2;
                  return ListTile(
                    title: Text(label),
                    onTap: () => context.read<ThemeCubit>().updateTheme(theme),
                    leading: selectedTheme == theme
                        ? const Icon(
                            Icons.radio_button_checked,
                            size: 20,
                          )
                        : const Icon(
                            Icons.radio_button_off,
                            size: 20,
                          ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
