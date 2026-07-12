import 'package:fit_talk/core/utils/app_failure.dart';
import 'package:fit_talk/feature/auth/domain/auth_repository.dart';
import 'package:fit_talk/feature/auth/presentation/view/model/email_params.dart';
import 'package:fpdart/fpdart.dart';

class VerifyOtpUseCase {
  final AuthRepository _repository;

  VerifyOtpUseCase(this._repository);

  Future<Either<AppFailure, void>> call(EmailParams? emailParams) async {
    if (emailParams == null) throw 'emailParams is null';
    if (emailParams.otp == null) return Left(InvalidOtpFailure());
    if (emailParams.otp == null || emailParams.otp!.isEmpty) {
      return Left(InvalidOtpFailure());
    }

    final result = await _repository.verifyOtp(
      email: emailParams.email,
      token: emailParams.otp,
    );
    return result.fold((failure) => left(failure), (_) => right(null));
  }
}
