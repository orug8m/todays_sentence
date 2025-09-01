import 'package:flutter_tts/flutter_tts.dart';
import '../models/language.dart';

class TextToSpeechService {
  static final FlutterTts _flutterTts = FlutterTts();
  static bool _isInitialized = false;

  static Future<void> initialize() async {
    if (_isInitialized) return;

    await _flutterTts.setVolume(0.8);
    await _flutterTts.setSpeechRate(0.5);
    await _flutterTts.setPitch(1.0);
    
    _isInitialized = true;
  }

  static Future<void> speak(String text, Language language) async {
    await initialize();
    
    // Set language for TTS
    String ttsLanguage = _getLanguageCode(language);
    await _flutterTts.setLanguage(ttsLanguage);
    
    await _flutterTts.speak(text);
  }

  static Future<void> stop() async {
    await _flutterTts.stop();
  }

  static Future<bool> isPlaying() async {
    // flutter_tts doesn't have a direct isPlaying method
    // We'll track this state manually or assume false for now
    return false;
  }

  static String _getLanguageCode(Language language) {
    switch (language) {
      case Language.japanese:
        return 'ja-JP';
      case Language.english:
        return 'en-US';
      case Language.chinese:
        return 'zh-CN';
      case Language.german:
        return 'de-DE';
      case Language.swedish:
        return 'sv-SE';
      default:
        return 'en-US';
    }
  }

  static Future<List<dynamic>> getAvailableLanguages() async {
    await initialize();
    // Return commonly supported languages
    return ['en-US', 'ja-JP', 'zh-CN', 'de-DE', 'sv-SE'];
  }

  static Future<void> setSpeechRate(double rate) async {
    await _flutterTts.setSpeechRate(rate);
  }

  static Future<void> setPitch(double pitch) async {
    await _flutterTts.setPitch(pitch);
  }

  static Future<void> setVolume(double volume) async {
    await _flutterTts.setVolume(volume);
  }
}
