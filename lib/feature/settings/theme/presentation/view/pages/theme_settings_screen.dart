import 'package:fit_talk/feature/settings/theme/presentation/bloc/bloc/theme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeSettingsScreen extends StatelessWidget {
  const ThemeSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Тема')),
      body: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          final mode = state.mode;

          return ListView(
            children: [
              SwitchListTile(
                title: const Text('Системная тема'),
                subtitle: const Text('Использовать тему устройства'),
                value: mode == ThemeMode.system,
                onChanged: (value) {
                  context.read<ThemeBloc>().add(
                    ThemeEvent.changed(
                      value ? ThemeMode.system : ThemeMode.light,
                    ),
                  );
                },
              ),

              const Divider(height: 1),

              SwitchListTile(
                title: const Text('Тёмная тема'),
                subtitle: const Text(
                  'Используется, если системная тема отключена',
                ),
                value: mode == ThemeMode.dark,
                onChanged: mode == ThemeMode.system
                    ? null
                    : (value) {
                        context.read<ThemeBloc>().add(
                          ThemeEvent.changed(
                            value ? ThemeMode.dark : ThemeMode.light,
                          ),
                        );
                      },
              ),
            ],
          );
        },
      ),
    );
  }
}
