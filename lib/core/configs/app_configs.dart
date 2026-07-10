import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfigs {
  static final appUrl = dotenv.get('APP_URL');
  static final supabaseUrl = dotenv.get('SUPABASE_URL');
  static final supabasePublishableKey = dotenv.get('SUPABASE_ANON_KEY');

  // // SupabaseAuthCallback
  // static final supabaseAuthCallback = dotenv.get('supabaseAuthCallback');
  // static final supabaseWebRedirect = dotenv.get('supabaseWebRedirect');
  // static final supabaseMobileRedirect = dotenv.get('supabaseMobileRedirect');
}
