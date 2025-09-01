import 'package:shared_preferences/shared_preferences.dart';
import '../models/language.dart';
import '../models/interest_category.dart';

class SettingsService {
  static const String _selectedLanguageKey = 'selected_language';
  static const String _selectedCategoriesKey = 'selected_categories';
  static const String _notificationTimeKey = 'notification_time';

  Future<void> saveSelectedLanguage(Language language) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_selectedLanguageKey, language.code);
  }

  Future<Language> getSelectedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString(_selectedLanguageKey) ?? 'en';
    return Language.values.firstWhere(
      (lang) => lang.code == languageCode,
      orElse: () => Language.english,
    );
  }

  Future<void> saveSelectedCategories(List<InterestCategory> categories) async {
    final prefs = await SharedPreferences.getInstance();
    final categoryNames = categories.map((c) => c.englishName).toList();
    await prefs.setStringList(_selectedCategoriesKey, categoryNames);
  }

  Future<List<InterestCategory>> getSelectedCategories() async {
    final prefs = await SharedPreferences.getInstance();
    final categoryNames = prefs.getStringList(_selectedCategoriesKey) ?? [];
    return categoryNames
        .map((name) => InterestCategory.values.firstWhere(
              (cat) => cat.englishName == name,
              orElse: () => InterestCategory.technology,
            ))
        .toList();
  }

  Future<void> saveNotificationTime(int hour, int minute) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_notificationTimeKey, hour * 60 + minute);
  }

  Future<Map<String, int>> getNotificationTime() async {
    final prefs = await SharedPreferences.getInstance();
    final totalMinutes =
        prefs.getInt(_notificationTimeKey) ?? 10 * 60; // Default 10:00
    return {
      'hour': totalMinutes ~/ 60,
      'minute': totalMinutes % 60,
    };
  }
}
