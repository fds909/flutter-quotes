import 'package:quotes/models/saved_quote_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class SavedQuotesRepository {
  late Database database;

  Future<void> initialize() async {
    final databasesPath = await getDatabasesPath();
    // il join compila automaticamente il path usando il separatore corretto
    // a secondo del sistema operativo
    final dbPath = path.join(databasesPath, 'persistenza_dati.db');

    database = await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute("""
        CREATE TABLE saved_quotes(
          id INTEGER PRIMARY KEY,
          text TEXT NOT NULL
        );
      """);
      },
    );
  }

  Future<List<SavedQuotesModel>> all() async {
    // non indicando la clausola where ottengo tutti i record
    final rows = await database.query("saved_quotes");
    return rows.map((row) => SavedQuotesModel.fromRecord(row)).toList();
  }

  Future<SavedQuotesModel> create(String text) async {
    final id = await database.insert("saved_quotes", {
      "text": text,
    });

    return SavedQuotesModel(
      id: id,
      text: text,
    );
  }

  Future<void> delete(SavedQuotesModel savedQuoteModel) async {
    await database.delete(
      "saved_quotes",
      where: "id = ?",
      whereArgs: [savedQuoteModel.id],
    );
  }
}
