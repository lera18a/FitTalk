import 'package:freezed_annotation/freezed_annotation.dart';

part 'email_params.freezed.dart';

@freezed
abstract class EmailParams with _$EmailParams {
  const factory EmailParams({
    required String email,
    String? password,
    String? confirmPassword,
  }) = _EmailParams;
}
