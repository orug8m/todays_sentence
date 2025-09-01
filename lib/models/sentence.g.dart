// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sentence.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sentence _$SentenceFromJson(Map<String, dynamic> json) => Sentence(
      id: json['id'] as String,
      text: json['text'] as String,
      language: json['language'] as String,
      category: json['category'] as String,
      translation: json['translation'] as String?,
      words: (json['words'] as List<dynamic>)
          .map((e) => WordDefinition.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$SentenceToJson(Sentence instance) => <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'language': instance.language,
      'category': instance.category,
      'translation': instance.translation,
      'words': instance.words,
      'createdAt': instance.createdAt.toIso8601String(),
    };

WordDefinition _$WordDefinitionFromJson(Map<String, dynamic> json) =>
    WordDefinition(
      word: json['word'] as String,
      definition: json['definition'] as String,
      pronunciation: json['pronunciation'] as String?,
      examples:
          (json['examples'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$WordDefinitionToJson(WordDefinition instance) =>
    <String, dynamic>{
      'word': instance.word,
      'definition': instance.definition,
      'pronunciation': instance.pronunciation,
      'examples': instance.examples,
    };
