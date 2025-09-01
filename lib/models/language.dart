enum Language {
  japanese('Japanese', '日本語', 'ja'),
  english('English', 'English', 'en'),
  chinese('Chinese', '中文', 'zh'),
  german('German', 'Deutsch', 'de'),
  swedish('Swedish', 'Svenska', 'sv');

  const Language(this.englishName, this.nativeName, this.code);

  final String englishName;
  final String nativeName;
  final String code;

  String get displayName => nativeName;
}
