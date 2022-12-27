import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:quotes/pages/home_page.dart';
import 'package:quotes/repositories/saved_quotes_repository.dart';

// occorre definire un singleton per il database

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final savedQuotesRepository = SavedQuotesRepository();
  await savedQuotesRepository.initialize();
  // registro il singleton a livello globale
  GetIt.I.registerSingleton(savedQuotesRepository);

  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}
