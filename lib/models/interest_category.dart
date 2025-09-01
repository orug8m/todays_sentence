enum InterestCategory {
  technology('Technology', 'テクノロジー'),
  science('Science', 'サイエンス'),
  business('Business', 'ビジネス'),
  health('Health', '健康'),
  travel('Travel', '旅行'),
  food('Food', '料理'),
  sports('Sports', 'スポーツ'),
  music('Music', '音楽'),
  movies('Movies', '映画'),
  books('Books', '本'),
  nature('Nature', '自然'),
  history('History', '歴史'),
  art('Art', 'アート'),
  education('Education', '教育'),
  philosophy('Philosophy', '哲学'),
  psychology('Psychology', '心理学'),
  economics('Economics', '経済'),
  politics('Politics', '政治'),
  environment('Environment', '環境'),
  culture('Culture', '文化');

  const InterestCategory(this.englishName, this.japaneseName);

  final String englishName;
  final String japaneseName;

  String getLocalizedName(String languageCode) {
    switch (languageCode) {
      case 'ja':
        return japaneseName;
      default:
        return englishName;
    }
  }
}
