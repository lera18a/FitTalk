import 'package:fit_talk/core/utils/app_failure.dart';
import 'package:fit_talk/feature/auth/domain/auth_repository.dart';
import 'package:fit_talk/feature/auth/presentation/view/model/email_params.dart';
import 'package:fpdart/fpdart.dart';

class RequestOtpUseCase {
  final AuthRepository _repository;

  RequestOtpUseCase(this._repository);

  Future<Either<AppFailure, void>> call(EmailParams? emailParams) async {
    if (emailParams == null) return Left(UnknownFailure());

    if (emailParams.email.isEmpty) {
      return Left(EnterEmailFailure());
    }

    final emailRegExp = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
    if (!emailRegExp.hasMatch(emailParams.email)) {
      return Left(InvalidEmailFormatFailure());
    }
    try {
      await _repository.requestOtp(email: emailParams.email);
      return Right(null);
    } on Exception catch (e) {
      // Можно детализировать по типу исключения
      return Left(DefaultAppFailure(message: e.toString(), cause: e));
    } catch (e) {
      return Left(UnknownFailure());
    }
  }
}
