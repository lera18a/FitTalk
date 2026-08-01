import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_event.dart';
part 'theme_state.dart';
part 'theme_bloc.freezed.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  static const _themeKey = 'theme_mode';

  ThemeBloc() : super(const ThemeState(ThemeMode.system)) {
    on<_Load>(_onLoad);
    on<_Changed>(_onChanged);

    // Автозагрузка при старте
    add(const ThemeEvent.load());
  }

  Future<void> _onLoad(_Load event, Emitter<ThemeState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    final index = prefs.getInt(_themeKey);

    if (index != null && index < ThemeMode.values.length) {
      emit(state.copyWith(mode: ThemeMode.values[index]));
    }
  }

  Future<void> _onChanged(_Changed event, Emitter<ThemeState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themeKey, event.mode.index);
    emit(state.copyWith(mode: event.mode));
  }
}
