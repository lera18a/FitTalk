import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseDatasource {
  final SupabaseClient _client;

  @override
  SupabaseDatasource({SupabaseClient? client})
    : _client = client ?? Supabase.instance.client;

  Future<User?> get user async => _client.auth.currentUser;

  Future<void> signOut() async => await _client.auth.signOut();

  Future<void> requestOtp({required String email}) async {
    await _client.auth.signInWithOtp(email: email);
  }

  Future<void> verifyOtp({
    required String? email,
    required String? token,
  }) async => await _client.auth.verifyOTP(
    type: OtpType.email,
    email: email,
    token: token,
  );
}
