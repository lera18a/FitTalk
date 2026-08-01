import 'package:fit_talk/core/utils/app_failure.dart';
import 'package:fit_talk/feature/profile_setup/domain/repository/profile_repository.dart';
import 'package:fit_talk/feature/profile_setup/presentation/view/model/profile.dart';
import 'package:fpdart/fpdart.dart';

class GetProfileUseCase {
  final ProfileRepository _repository;

  GetProfileUseCase(this._repository);

  Future<Either<AppFailure, ProfileModel?>> call(String id) async {
    return await _repository.getProfile(id);
  }
}
