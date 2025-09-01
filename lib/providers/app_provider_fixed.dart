import 'package:flutter/foundation.dart';
import '../models/language.dart';
import '../models/interest_category.dart';
import '../models/sentence.dart';
import '../services/settings_service.dart';
import '../services/sentence_service.dart';
import '../services/notification_service.dart';
import '../services/database_service.dart';
import '../services/tts_service.dart';

class AppProvider with ChangeNotifier {
  final SettingsService _settingsService = SettingsService();
  final SentenceService _sentenceService = SentenceService();

  Language _selectedLanguage = Language.english;
  Language _nativeLanguage = Language.japanese;
  List<InterestCategory> _selectedCategories = [InterestCategory.technology];
  int _notificationHour = 10;
  int _notificationMinute = 0;
  Sentence? _todaysSentence;
  bool _isLoading = false;
  bool _isSpeaking = false;
  List<Sentence> _sentenceHistory = [];

  // Getters
  Language get selectedLanguage => _selectedLanguage;
  Language get nativeLanguage => _nativeLanguage;
  List<InterestCategory> get selectedCategories => _selectedCategories;
  int get notificationHour => _notificationHour;
  int get notificationMinute => _notificationMinute;
  Sentence? get todaysSentence => _todaysSentence;
  bool get isLoading => _isLoading;
  bool get isSpeaking => _isSpeaking;
  List<Sentence> get sentenceHistory => _sentenceHistory;

  Future<void> initialize() async {
    _isLoading = true;
    notifyListeners();

    try {
      // Load saved settings
      _selectedLanguage = await _settingsService.getSelectedLanguage();
      _nativeLanguage = await _settingsService.getNativeLanguage();
      _selectedCategories = await _settingsService.getSelectedCategories();

      if (_selectedCategories.isEmpty) {
        _selectedCategories = [InterestCategory.technology];
      }

      final notificationTime = await _settingsService.getNotificationTime();
      _notificationHour = notificationTime['hour']!;
      _notificationMinute = notificationTime['minute']!;

      // Load today's sentence
      await loadTodaysSentence();

      // Load sentence history
      await loadSentenceHistory();

      // Initialize TTS
      await TextToSpeechService.initialize();
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

  Future<void> setNativeLanguage(Language language) async {
    _nativeLanguage = language;
    await _settingsService.saveNativeLanguage(language);
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

      // Save to history when loaded
      if (_todaysSentence != null) {
        await DatabaseService.saveSentenceToHistory(_todaysSentence!);
        await loadSentenceHistory(); // Refresh history
      }
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

  Future<void> loadSentenceHistory() async {
    try {
      _sentenceHistory = await DatabaseService.getHistory();
    } catch (e) {
      if (kDebugMode) {
        print('Error loading sentence history: $e');
      }
    }
    notifyListeners();
  }

  Future<void> generateNewSentence() async {
    _isLoading = true;
    notifyListeners();

    try {
      _todaysSentence = await _sentenceService.getRandomSentence(
        _selectedLanguage,
        _selectedCategories,
      );

      if (_todaysSentence != null) {
        await DatabaseService.saveSentenceToHistory(_todaysSentence!);
        await loadSentenceHistory();
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error generating new sentence: $e');
      }
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> speakSentence(String text) async {
    if (_isSpeaking) {
      await TextToSpeechService.stop();
      _isSpeaking = false;
    } else {
      _isSpeaking = true;
      notifyListeners();

      try {
        await TextToSpeechService.speak(text, _selectedLanguage);
      } catch (e) {
        if (kDebugMode) {
          print('Error speaking sentence: $e');
        }
      }

      _isSpeaking = false;
    }
    notifyListeners();
  }

  Future<void> clearHistory() async {
    await DatabaseService.clearHistory();
    _sentenceHistory = [];
    notifyListeners();
  }

  /// 中国語の簡体字/繁体字変換を取得
  Map<String, String> getChineseVariations() {
    if (_todaysSentence == null) return {};
    return _sentenceService.getChineseVariations(_todaysSentence!);
  }

  /// 現在の文章が中国語かどうか確認
  bool get isCurrentSentenceChinese {
    return _todaysSentence?.language.startsWith('zh') ?? false;
  }
}
