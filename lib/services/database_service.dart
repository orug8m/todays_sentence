import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/sentence.dart';

class DatabaseService {
  static Database? _database;
  static const String _tableName = 'sentence_history';

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  static Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'todays_sentence.db');
    
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE $_tableName(
            id TEXT PRIMARY KEY,
            text TEXT NOT NULL,
            language TEXT NOT NULL,
            category TEXT NOT NULL,
            translation TEXT,
            words TEXT NOT NULL,
            createdAt TEXT NOT NULL,
            viewedAt TEXT NOT NULL
          )
        ''');
      },
    );
  }

  static Future<void> saveSentenceToHistory(Sentence sentence) async {
    final db = await database;
    
    // Check if sentence already exists
    final existing = await db.query(
      _tableName,
      where: 'id = ?',
      whereArgs: [sentence.id],
    );

    final sentenceData = {
      'id': sentence.id,
      'text': sentence.text,
      'language': sentence.language,
      'category': sentence.category,
      'translation': sentence.translation,
      'words': _encodeWords(sentence.words),
      'createdAt': sentence.createdAt.toIso8601String(),
      'viewedAt': DateTime.now().toIso8601String(),
    };

    if (existing.isEmpty) {
      await db.insert(_tableName, sentenceData);
    } else {
      await db.update(
        _tableName,
        {'viewedAt': DateTime.now().toIso8601String()},
        where: 'id = ?',
        whereArgs: [sentence.id],
      );
    }
  }

  static Future<List<Sentence>> getHistory({int limit = 50}) async {
    final db = await database;
    
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      orderBy: 'viewedAt DESC',
      limit: limit,
    );

    return List.generate(maps.length, (i) {
      return Sentence(
        id: maps[i]['id'],
        text: maps[i]['text'],
        language: maps[i]['language'],
        category: maps[i]['category'],
        translation: maps[i]['translation'],
        words: _decodeWords(maps[i]['words']),
        createdAt: DateTime.parse(maps[i]['createdAt']),
      );
    });
  }

  static Future<void> clearHistory() async {
    final db = await database;
    await db.delete(_tableName);
  }

  static String _encodeWords(List<WordDefinition> words) {
    // Simple JSON-like encoding for words
    final wordsData = words.map((word) => {
      'word': word.word,
      'definition': word.definition,
      'pronunciation': word.pronunciation ?? '',
      'examples': word.examples.join('|'),
    }).toList();
    
    return wordsData.map((word) => 
      '${word['word']}~${word['definition']}~${word['pronunciation']}~${word['examples']}'
    ).join('###');
  }

  static List<WordDefinition> _decodeWords(String wordsString) {
    try {
      if (wordsString.isEmpty) return [];
      
      final wordEntries = wordsString.split('###');
      return wordEntries.map((entry) {
        final parts = entry.split('~');
        if (parts.length >= 4) {
          return WordDefinition(
            word: parts[0],
            definition: parts[1],
            pronunciation: parts[2].isNotEmpty ? parts[2] : null,
            examples: parts[3].isNotEmpty ? parts[3].split('|') : [],
          );
        }
        return WordDefinition(
          word: 'Unknown',
          definition: 'No definition available',
          examples: [],
        );
      }).toList();
    } catch (e) {
      return [];
    }
  }
}
