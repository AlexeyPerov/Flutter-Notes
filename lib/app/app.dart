import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mynotes/repositories/notes_repository.dart';
import 'package:mynotes/repositories/settings_repository.dart';

GetIt getIt = GetIt.instance;

class App {
  static Future initializeApp() async {
    WidgetsFlutterBinding.ensureInitialized();

    getIt.registerSingleton<SettingsRepository>(HiveSettingsRepository());

    initializeLogging();

    await getIt.get<SettingsRepository>().initialize();

    getIt.registerSingleton<NotesRepository>(InMemoryNotesRepository(),
        signalsReady: true);

    getIt<NotesRepository>().initialize();
  }

  static void initializeLogging() {}
}
