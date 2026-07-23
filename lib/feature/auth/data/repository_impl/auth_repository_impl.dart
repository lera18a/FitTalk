import 'package:fit_talk/core/utils/app_failure.dart';
import 'package:fit_talk/feature/auth/data/datasources/supabase_datasource.dart';
import 'package:fit_talk/feature/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final SupabaseDatasource _supabase;

  AuthRepositoryImpl({required SupabaseDatasource supabase})
    : _supabase = supabase;

  @override
  Future<void> signOut() async => await _supabase.signOut();

  @override
  Future<Either<AppFailure, void>> signUp({
    required String email,
    required String password,
  }) async {
    try {
      await _supabase.signUp(email: email, password: password);
      return right(null);
    } catch (e, s) {
      return left(DefaultAppFailure(cause: e, stackTrace: s));
    }
  }

  @override
  Future<Either<AppFailure, void>> signinWithPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _supabase.signInWithPassword(email: email, password: password);
      return right(null);
    } catch (e, s) {
      return left(DefaultAppFailure(cause: e, stackTrace: s));
    }
  }
}
