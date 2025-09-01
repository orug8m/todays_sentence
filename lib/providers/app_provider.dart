import 'package:flutter/foundation.dart';
import '../models/language.dart';
import '../models/interest_category.dart';
import '../models/sentence.dart';
import '../services/settings_service.dart';
import '../services/sentence_service.dart';
import '../services/notification_service.dart';

class AppProvider with ChangeNotifier {
  final SettingsService _settingsService = SettingsService();
  final SentenceService _sentenceService = SentenceService();

  Language _selectedLanguage = Language.english;
  List<InterestCategory> _selectedCategories = [InterestCategory.technology];
  int _notificationHour = 10;
  int _notificationMinute = 0;
  Sentence? _todaysSentence;
  bool _isLoading = false;

  // Getters
  Language get selectedLanguage => _selectedLanguage;
  List<InterestCategory> get selectedCategories => _selectedCategories;
  int get notificationHour => _notificationHour;
  int get notificationMinute => _notificationMinute;
  Sentence? get todaysSentence => _todaysSentence;
  bool get isLoading => _isLoading;

  Future<void> initialize() async {
    _isLoading = true;
    notifyListeners();

    try {
      // Load saved settings
      _selectedLanguage = await _settingsService.getSelectedLanguage();
      _selectedCategories = await _settingsService.getSelectedCategories();

      if (_selectedCategories.isEmpty) {
        _selectedCategories = [InterestCategory.technology];
      }

      final notificationTime = await _settingsService.getNotificationTime();
      _notificationHour = notificationTime['hour']!;
      _notificationMinute = notificationTime['minute']!;

      // Load today's sentence
      await loadTodaysSentence();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> setSelectedLanguage(Language language) async {
    _selectedLanguage = language;
    await _settingsService.saveSelectedLanguage(language);
    await loadTodaysSentence(); // Reload sentence for new language
    notifyListeners();
  }

  Future<void> setSelectedCategories(List<InterestCategory> categories) async {
    _selectedCategories = categories;
    await _settingsService.saveSelectedCategories(categories);
    await loadTodaysSentence(); // Reload sentence for new categories
    notifyListeners();
  }

  Future<void> setNotificationTime(int hour, int minute) async {
    _notificationHour = hour;
    _notificationMinute = minute;
    await _settingsService.saveNotificationTime(hour, minute);

    // Schedule new notification
    await NotificationService.scheduleDailyNotification(
      hour: hour,
      minute: minute,
      title: 'Today\'s Language Learning',
      body: 'Check out your daily sentence!',
    );

    notifyListeners();
  }

  Future<void> loadTodaysSentence() async {
    try {
      _todaysSentence = await _sentenceService.getTodaysSentence(
        _selectedLanguage,
        _selectedCategories,
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error loading today\'s sentence: $e');
      }
    }
    notifyListeners();
  }

  Future<void> refreshSentence() async {
    _isLoading = true;
    notifyListeners();

    await loadTodaysSentence();

    _isLoading = false;
    notifyListeners();
  }
}
