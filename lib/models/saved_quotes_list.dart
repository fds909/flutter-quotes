import 'package:get_it/get_it.dart';
import 'package:quotes/models/saved_quote_model.dart';
import 'package:quotes/repositories/saved_quotes_repository.dart';

class SavedQuotesList {
  List<SavedQuotesModel> quotes = [];

  Future<void> initialize() async {
    quotes = await GetIt.I.get<SavedQuotesRepository>().all();
  }

  Future<void> create(String text) async {
    final quote = await GetIt.I.get<SavedQuotesRepository>().create(text);
    // insert al contrario di add permette di specificare la posizione
    // in uqesto caso vogliamo inserire la quote in testa alla lista
    quotes.insert(0, quote);
  }

  Future<void> delete(SavedQuotesModel savedQuotesModel) async {
    await GetIt.I.get<SavedQuotesRepository>().delete(savedQuotesModel);
    // insert al contrario di add permette di specificare la posizione
    // in uqesto caso vogliamo inserire la quote in testa alla lista
    quotes.removeWhere((it) => it.id == savedQuotesModel.id);
  }

  // Verifica se esiste una quote con lo stesso testo del parametro passato
  bool contains(String text) {
    return quotes.any((item) => item.text == text);
  }
}
