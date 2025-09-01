enum Language {
  japanese('Japanese', '日本語', 'ja'),
  english('English', 'English', 'en'),
  chineseSimplified('Chinese (Simplified)', '简体中文', 'zh-cn'),
  chineseTraditional('Chinese (Traditional)', '繁體中文', 'zh-tw'),
  german('German', 'Deutsch', 'de'),
  swedish('Swedish', 'Svenska', 'sv');

  const Language(this.englishName, this.nativeName, this.code);

  final String englishName;
  final String nativeName;
  final String code;

  String get displayName => nativeName;

  bool get isChinese => this == chineseSimplified || this == chineseTraditional;

  Language get chineseCounterpart {
    if (this == chineseSimplified) return chineseTraditional;
    if (this == chineseTraditional) return chineseSimplified;
    return this;
  }
}
