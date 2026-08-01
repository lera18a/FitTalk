part of 'theme_bloc.dart';

@freezed
class ThemeEvent with _$ThemeEvent {
  const factory ThemeEvent.load() = _Load;
  const factory ThemeEvent.changed(ThemeMode mode) = _Changed;
}
