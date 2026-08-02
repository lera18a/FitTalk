import 'package:supabase_flutter/supabase_flutter.dart';

class FriendsDatasource {
  FriendsDatasource(this._client);

  final SupabaseClient _client;

  Future<List<Map<String, dynamic>>> searchUsers({
    required String query,
    required String currentUserId,
  }) async {
    final result = await _client
        .from('profiles')
        .select()
        .neq('id', currentUserId)
        .or('username.ilike.%$query%,first_name.ilike.%$query%')
        .limit(30);

    return List<Map<String, dynamic>>.from(result);
  }

  Future<Map<String, dynamic>> getProfile(String id) async {
    return await _client.from('profiles').select().eq('id', id).single();
  }
}
