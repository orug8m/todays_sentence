# todays_sentence

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

# Today's Sentence - Language Learning App

A multilingual language learning application built with Flutter that displays daily sentences with translations, word definitions, and audio pronunciation support.

## Features

### 🌍 Multi-language Support
- **Learning Languages**: English, Japanese, Chinese (Simplified & Traditional), German, Swedish
- **Native Language Settings**: Separate configuration for translation display
- **Chinese Conversion**: Automatic conversion between Traditional and Simplified Chinese

### 📚 Content Categories
Choose from 20 different interest categories:
- Technology, Science, Health, Travel, Business
- Sports, Music, Movies, Books, Nature
- History, Art, Education, Philosophy, Psychology
- Economics, Politics, Environment, Culture, Food

### 🔧 Core Features
- **Daily Sentences**: New sentence every day based on selected languages and categories
- **Smart Translations**: Translations displayed in your native language
- **Word Dictionary**: Detailed word definitions with pronunciation and examples
- **Text-to-Speech**: Audio pronunciation for all supported languages
- **Learning History**: Track your learning progress over time
- **Push Notifications**: Daily reminders at customizable times
- **Chinese Variants**: Support for both Simplified and Traditional Chinese with conversion

### 🎨 User Interface
- Clean, intuitive Material Design interface
- Show/hide translation and word details
- Responsive layout for all screen sizes
- Dark/light mode support

## Screenshots

| Home Screen | Settings | History |
|------------|----------|---------|
| Daily sentence display with audio | Language and category selection | Learning progress tracking |

## Quick Start

### Prerequisites
- Flutter SDK 3.0 or higher
- Dart SDK 3.0 or higher
- Android Studio / VS Code with Flutter plugins
- Git

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/orug8m/todays_sentence.git
   cd todays_sentence
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate code (JSON serialization)**
   ```bash
   dart run build_runner build
   ```

4. **Run the app**
   ```bash
   # For web (recommended for development)
   flutter run -d chrome
   
   # For mobile (requires device/emulator)
   flutter run -d android
   flutter run -d ios
   ```

### Platform-specific Setup

#### Android
- Minimum SDK: 21 (Android 5.0)
- Permissions: Notifications, Audio

#### iOS
- Minimum deployment target: iOS 12.0
- Permissions: Notifications, Audio

#### Web
- Supports all modern browsers
- Some features (notifications, TTS) may have limited functionality

## Configuration

### Language Settings
1. Open the app and navigate to Settings
2. Set your **Native Language** (for translations)
3. Choose your **Learning Language** (for sentences)
4. Select **Interest Categories** (multiple selection allowed)

### Notifications
- Default: Daily at 10:00 AM
- Customizable through Settings screen
- Requires notification permissions

## Architecture

### Project Structure
```
lib/
├── models/           # Data models (Language, Sentence, etc.)
├── services/         # Business logic services
│   ├── sentence_service.dart
│   ├── settings_service.dart
│   ├── tts_service.dart
│   ├── history_service.dart
│   └── chinese_translation_service.dart
├── providers/        # State management (Provider pattern)
├── screens/          # UI screens
│   ├── home_screen.dart
│   ├── settings_screen.dart
│   └── history_screen.dart
└── main.dart
```

### Key Technologies
- **Flutter 3.x**: Cross-platform UI framework
- **Provider**: State management pattern
- **SharedPreferences**: Local data persistence
- **flutter_local_notifications**: Push notifications
- **flutter_tts**: Text-to-speech functionality
- **JSON serialization**: Data model serialization

## Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.1.2
  shared_preferences: ^2.2.2
  flutter_local_notifications: ^17.0.0
  flutter_tts: ^3.8.3
  permission_handler: ^11.3.1
  json_annotation: ^4.8.1

dev_dependencies:
  flutter_test:
    sdk: flutter
  build_runner: ^2.4.9
  json_serializable: ^6.7.1
  flutter_lints: ^3.0.0
```

## Development

### Running Tests
```bash
flutter test
```

### Building for Production

#### Web
```bash
flutter build web
```

#### Android APK
```bash
flutter build apk --release
```

#### iOS
```bash
flutter build ios --release
```

### Adding New Languages

1. Update the `Language` enum in `lib/models/language.dart`
2. Add sentence data to `_sentenceDatabase` in `lib/services/sentence_service.dart`
3. Add translation mappings in `_getBasicTranslation` method
4. Update TTS language codes in `lib/services/tts_service.dart`

### Adding New Categories

1. Update `InterestCategory` enum in `lib/models/interest_category.dart`
2. Add corresponding sentence data for all supported languages
3. Update UI strings and icons as needed

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Contribution Guidelines
- Follow Flutter/Dart style guide
- Add tests for new features
- Update documentation
- Ensure all languages have equivalent content

## Troubleshooting

### Common Issues

**Build errors after cloning**
```bash
flutter clean
flutter pub get
dart run build_runner build --delete-conflicting-outputs
```

**Notification not working**
- Check device notification permissions
- Verify notification time settings
- Test on physical device (notifications may not work in simulators)

**TTS not working**
- Verify device has TTS engine installed
- Check audio permissions
- Test with different languages

**Web platform limitations**
- TTS functionality is limited on web
- Notifications require user interaction
- Some mobile-specific features unavailable

## Roadmap

### Upcoming Features
- [ ] Cloud synchronization for settings and history
- [ ] Offline mode with cached content
- [ ] Learning statistics and progress tracking
- [ ] Spaced repetition algorithm
- [ ] Community features and sentence sharing
- [ ] Integration with external language APIs
- [ ] Widget support for home screen
- [ ] Apple Watch / Android Wear support

### Long-term Goals
- [ ] AI-powered personalized content
- [ ] Voice recognition for pronunciation practice
- [ ] Gamification elements
- [ ] Social learning features
- [ ] Premium subscription model

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Flutter team for the amazing framework
- Community contributors for language content
- Open source libraries that made this project possible

## Support

- 📧 Email: [your-email@example.com]
- 🐛 Issues: [GitHub Issues](https://github.com/orug8m/todays_sentence/issues)
- 💬 Discussions: [GitHub Discussions](https://github.com/orug8m/todays_sentence/discussions)

---

**Happy Learning! 📚✨**
