import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/services/bloc_observer.dart';
import 'core/services/get_it_service.dart';
import 'core/services/local/shared_prefs_service.dart';
import 'dashboard_app.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = const AppBlocObserver();
  await dotenv.load(fileName: '.env');
  _assertEnvKeys(['SUPABASE_URL', 'SUPABASE_ANON_KEY']);

  await Future.wait([
    SharedPrefsService.init(),
    Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform),
    Supabase.initialize(
      url: dotenv.env['SUPABASE_URL']!,
      anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
    ),
  ]);

  await setupServiceLocator();
  runApp(const DashboardApp());
}

void _assertEnvKeys(List<String> keys) {
  final missing = keys.where((k) => (dotenv.env[k] ?? '').isEmpty).toList();
  if (missing.isNotEmpty) {
    throw StateError(
      'Missing required .env keys: ${missing.join(', ')}. '
      'Make sure your .env file is present and complete.',
    );
  }
}
