import 'dart:io';

import 'package:fit_talk/core/utils/app_failure.dart';
import 'package:fit_talk/feature/profile_setup/data/datasource/supabase_datasource_profile.dart';
import 'package:fit_talk/feature/profile_setup/domain/repository/profile_repository.dart';
import 'package:fit_talk/feature/profile_setup/presentation/view/model/profile.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final SupabaseDatasourceProfile _datasource;
  final SupabaseClient _client;
  ProfileRepositoryImpl(this._datasource, {SupabaseClient? client})
    : _client = client ?? Supabase.instance.client;

  @override
  Future<Either<AppFailure, ProfileModel?>> getProfile(String id) async {
    try {
      final data = await _datasource.getProfile(id);
      if (data == null) return right(null);
      return right(ProfileModel.fromJson(data));
    } catch (e, s) {
      return left(DefaultAppFailure(cause: e, stackTrace: s));
    }
  }

  @override
  Future<Either<AppFailure, void>> saveProfile(ProfileModel profile) async {
    try {
      await _datasource.upsertProfile(profile.toJson());
      return right(null);
    } catch (e, s) {
      return left(DefaultAppFailure(cause: e, stackTrace: s));
    }
  }

  @override
  Future<Either<AppFailure, String>> uploadAvatar(
    File file,
    String userId,
  ) async {
    try {
      // 1. Указываем путь к файлу в бакете (например, в бакете 'avatars')
      final path = '$userId/avatar.png';

      // 2. Загружаем файл с флагом upsert: true, чтобы перезаписывать старый аватар
      await _client.storage
          .from('avatars')
          .upload(path, file, fileOptions: const FileOptions(upsert: true));

      // 3. Получаем публичную ссылку на загруженное изображение
      final publicUrl = _client.storage.from('avatars').getPublicUrl(path);

      final avatarUrl = '$publicUrl?v=${DateTime.now().millisecondsSinceEpoch}';

      return Right(avatarUrl);
    } on StorageException catch (e) {
      return Left(DefaultAppFailure(cause: e.message));
    } catch (e) {
      return Left(DefaultAppFailure(cause: 'Не удалось загрузить аватар: $e'));
    }
  }
}
