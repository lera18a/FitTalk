import 'package:fit_talk/app/fit_talk_app.dart';
import 'package:fit_talk/core/configs/app_configs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await Supabase.initialize(
    url: AppConfigs.supabaseUrl,
    publishableKey: AppConfigs.supabasePublishableKey,
  );
  runApp(FitTalkApp());
}
