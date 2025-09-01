import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/sentence.dart';

class HistoryService {
  static const String _historyKey = 'sentence_history';

  static Future<void> saveSentenceToHistory(Sentence sentence) async {
    final prefs = await SharedPreferences.getInstance();

    // Get existing history
    final historyJson = prefs.getString(_historyKey) ?? '[]';
    final List<dynamic> historyList = jsonDecode(historyJson);

    // Check if sentence already exists
    final existingIndex =
        historyList.indexWhere((item) => item['id'] == sentence.id);

    final sentenceData = {
      'id': sentence.id,
      'text': sentence.text,
      'language': sentence.language,
      'category': sentence.category,
      'translation': sentence.translation,
      'words': sentence.words.map((word) => word.toJson()).toList(),
      'createdAt': sentence.createdAt.toIso8601String(),
      'viewedAt': DateTime.now().toIso8601String(),
    };

    if (existingIndex >= 0) {
      // Update existing entry
      historyList[existingIndex]['viewedAt'] = DateTime.now().toIso8601String();
    } else {
      // Add new entry
      historyList.insert(0, sentenceData);

      // Keep only last 50 entries
      if (historyList.length > 50) {
        historyList.removeRange(50, historyList.length);
      }
    }

    await prefs.setString(_historyKey, jsonEncode(historyList));
  }

  static Future<List<Sentence>> getHistory({int limit = 50}) async {
    final prefs = await SharedPreferences.getInstance();
    final historyJson = prefs.getString(_historyKey) ?? '[]';

    final List<dynamic> historyList = jsonDecode(historyJson);

    return historyList.take(limit).map((item) {
      return Sentence(
        id: item['id'],
        text: item['text'],
        language: item['language'],
        category: item['category'],
        translation: item['translation'],
        words: (item['words'] as List)
            .map((word) => WordDefinition.fromJson(word))
            .toList(),
        createdAt: DateTime.parse(item['createdAt']),
      );
    }).toList();
  }

  static Future<void> clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_historyKey);
  }
}
