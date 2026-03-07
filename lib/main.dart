import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/services/bloc_observer.dart';
import 'core/services/get_it_service.dart';
import 'core/services/shared_preferences_service.dart';
import 'dashboard_app.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = const AppBlocObserver();
  await dotenv.load(fileName: '.env');
  await Future.wait([
    SharedPreferencesService.init(),
    Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform),

    Supabase.initialize(
      url: dotenv.env['SUPABASE_URL']!,
      anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
    ),
  ]);

  await setupServiceLocator();

  runApp(const DashboardApp());
}
