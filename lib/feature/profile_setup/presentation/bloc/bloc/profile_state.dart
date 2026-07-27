part of 'profile_bloc.dart';

enum ProfileSetupStatus { initial, loading, success, failure }

@freezed
class ProfileState with _$ProfileState {
  final String firstName;
  final String username;
  final Uint8List? avatarBytes;
  final ProfileSetupStatus status;
  final String? errorMessage;

  const ProfileState({
    this.firstName = '',
    this.username = '',
    this.avatarBytes,
    this.status = ProfileSetupStatus.initial,
    this.errorMessage,
  });

  // Валидация вынесена из верстки в геттеры состояния
  String? get firstNameError {
    final text = firstName.trim();
    if (text.isEmpty) return 'Введите имя';
    if (text.length < 2) return 'Минимум 2 символа';
    return null;
  }

  String? get usernameError {
    final text = username.trim();
    if (text.isEmpty) return 'Введите ник';
    if (text.length < 3) return 'Минимум 3 символа';
    if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(text)) {
      return 'Используйте только буквы, цифры и _';
    }
    return null;
  }

  bool get isAvatarValid => avatarBytes != null;

  bool get isFormValid =>
      firstNameError == null && usernameError == null && isAvatarValid;
}
