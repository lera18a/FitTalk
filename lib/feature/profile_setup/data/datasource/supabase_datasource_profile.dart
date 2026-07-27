import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseDatasourceProfile {
  final SupabaseClient _client;

  SupabaseDatasourceProfile({SupabaseClient? client})
    : _client = client ?? Supabase.instance.client;
  Future<Map<String, dynamic>?> getProfile(String id) async {
    return await _client.from('profiles').select().eq('id', id).maybeSingle();
  }

  Future<void> upsertProfile(Map<String, dynamic> row) async {
    await _client.from('profiles').upsert(row);
  }
}
