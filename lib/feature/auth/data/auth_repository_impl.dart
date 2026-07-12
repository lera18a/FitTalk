import 'package:fit_talk/core/utils/app_failure.dart';
import 'package:fit_talk/feature/auth/data/datasources/supabase_datasource.dart';
import 'package:fit_talk/feature/auth/domain/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final SupabaseDatasource _supabase;
  AuthRepositoryImpl({required SupabaseDatasource supabase})
    : _supabase = supabase;
  @override
  Future<Either<AppFailure, void>> verifyOtp({
    required String email,
    required String? token,
  }) async {
    return _supabase
        .verifyOtp(email: email, token: token)
        .then((ans) => right(ans), onError: (e, s) => left(e));
  }

  @override
  Future<Either<AppFailure, void>> requestOtp({required String email}) {
    return _supabase
        .requestOtp(email: email)
        .then((ans) => right(ans), onError: (e, s) => left(e));
  }

  @override
  Future<void> signOut() async => await _supabase.signOut();
}
