import 'package:fit_talk/feature/auth/presentation/bloc/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CONGRADILATION'),
        actions: [
          IconButton(
            onPressed: () {
              context.read<AuthBloc>().add(LogOut());
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(child: Text('Привет с успешной регистрацией тебя')),
    );
  }
}
