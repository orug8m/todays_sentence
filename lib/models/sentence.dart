import 'package:json_annotation/json_annotation.dart';

part 'sentence.g.dart';

@JsonSerializable()
class Sentence {
  final String id;
  final String text;
  final String language;
  final String category;
  final String? translation;
  final List<WordDefinition> words;
  final DateTime createdAt;

  Sentence({
    required this.id,
    required this.text,
    required this.language,
    required this.category,
    this.translation,
    required this.words,
    required this.createdAt,
  });

  factory Sentence.fromJson(Map<String, dynamic> json) =>
      _$SentenceFromJson(json);

  Map<String, dynamic> toJson() => _$SentenceToJson(this);
}

@JsonSerializable()
class WordDefinition {
  final String word;
  final String definition;
  final String? pronunciation;
  final List<String> examples;

  WordDefinition({
    required this.word,
    required this.definition,
    this.pronunciation,
    required this.examples,
  });

  factory WordDefinition.fromJson(Map<String, dynamic> json) =>
      _$WordDefinitionFromJson(json);

  Map<String, dynamic> toJson() => _$WordDefinitionToJson(this);
}
