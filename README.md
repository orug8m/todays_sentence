# todays_sentence

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

# Today's Sentence - 語学学習アプリ

多言語対応の語学学習アプリです。毎日異なる短文を表示し、単語の意味や翻訳を学習できます。

## 機能

- **多言語サポート**: 日本語、英語、中国語、ドイツ語、スウェーデン語
- **興味別カテゴリ**: 20の興味分野から選択可能
  - Technology (テクノロジー)
  - Science (サイエンス)  
  - Health (健康)
  - Travel (旅行)
  - Business (ビジネス)
  - Sports (スポーツ)
  - Music (音楽)
  - Movies (映画)
  - Books (本)
  - Nature (自然)
  - History (歴史)
  - Art (アート)
  - Education (教育)
  - Philosophy (哲学)
  - Psychology (心理学)
  - Economics (経済)
  - Politics (政治)
  - Environment (環境)
  - Culture (文化)
  - Food (料理)

- **詳細表示機能**:
  - 母国語への翻訳
  - 単語辞書（発音、意味、例文）
  - Show Detailsボタンで詳細の表示/非表示

- **毎日の通知**: 毎日10時（カスタマイズ可能）に新しい文章をお知らせ

## 使い方

1. **言語選択**: 学習したい言語を選択
2. **興味分野選択**: 学びたいトピックを複数選択
3. **毎日の学習**: 表示された文章を読む
4. **詳細学習**: "Show Details"ボタンを押して翻訳や単語の詳細を確認
5. **通知設定**: 好きな時間に通知を設定

## 技術仕様

- **フレームワーク**: Flutter 3.x
- **状態管理**: Provider パターン
- **ローカルストレージ**: SharedPreferences
- **通知**: flutter_local_notifications
- **権限管理**: permission_handler

## 依存関係

```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.1.2
  shared_preferences: ^2.2.2
  http: ^1.2.0
  flutter_local_notifications: ^17.0.0
  permission_handler: ^11.3.1
  json_annotation: ^4.8.1
```

## セットアップ

1. リポジトリをクローン
```bash
git clone <repository-url>
cd todays_sentence
```

2. 依存関係をインストール
```bash
flutter pub get
```

3. JSONシリアライゼーションコードを生成
```bash
dart run build_runner build
```

4. アプリを実行
```bash
flutter run
```

## 文章データについて

現在は事前定義された文章データベースを使用しています。将来的には以下のような外部APIとの連携を検討しています：

- ニュースAPI（多言語対応）
- 教育コンテンツAPI
- 辞書API

## プラットフォーム対応

- ✅ Android
- ✅ iOS
- ✅ Web（制限付き）

## ライセンス

MIT License

## 貢献

プルリクエストやイシューの報告を歓迎します。

## 今後の予定

- [ ] より多くの言語サポート
- [ ] 学習履歴機能
- [ ] 音声読み上げ機能
- [ ] 外部API連携
- [ ] ユーザー設定のクラウド同期
- [ ] 学習統計とプログレス表示
