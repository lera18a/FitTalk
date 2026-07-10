import 'package:fit_talk/app/app.dart';
import 'package:fit_talk/core/configs/f_t_configs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await Supabase.initialize(
    url: FTConfigs.supabaseUrl,
    publishableKey: FTConfigs.supabasePublishableKey,
  );
  runApp(const MyApp());
}
