import 'dart:math';
import '../models/sentence.dart';
import '../models/language.dart';
import '../models/interest_category.dart';

class SentenceService {
  // 事前定義された文章データベース（実際のAPIの代替）
  static final Map<String, Map<String, List<Map<String, dynamic>>>> _sentenceDatabase = {
    'en': {
      'Technology': [
        {
          'text': 'Artificial intelligence is transforming how we work and live.',
          'translation': '人工知能は、私たちの働き方や生活を変革しています。',
          'words': [
            {
              'word': 'artificial',
              'definition': 'made by humans; not natural',
              'pronunciation': '/ˌɑːr.t̬əˈfɪʃ.əl/',
              'examples': ['artificial flowers', 'artificial intelligence']
            },
            {
              'word': 'transforming',
              'definition': 'changing completely',
              'pronunciation': '/trænsˈfɔːrmɪŋ/',
              'examples': ['transforming the industry', 'transforming society']
            }
          ]
        },
        {
          'text': 'Cloud computing enables access to data from anywhere.',
          'translation': 'クラウドコンピューティングにより、どこからでもデータにアクセスできます。',
          'words': [
            {
              'word': 'cloud',
              'definition': 'remote servers accessed via internet',
              'pronunciation': '/klaʊd/',
              'examples': ['cloud storage', 'cloud computing']
            },
            {
              'word': 'enables',
              'definition': 'makes possible',
              'pronunciation': '/ɪˈneɪbəlz/',
              'examples': ['enables access', 'enables communication']
            }
          ]
        }
      ],
      'Science': [
        {
          'text': 'Scientists discovered a new species in the Amazon rainforest.',
          'translation': '科学者たちはアマゾンの熱帯雨林で新しい種を発見しました。',
          'words': [
            {
              'word': 'discovered',
              'definition': 'found for the first time',
              'pronunciation': '/dɪˈskʌvərd/',
              'examples': ['discovered a planet', 'discovered the truth']
            },
            {
              'word': 'species',
              'definition': 'a group of similar living things',
              'pronunciation': '/ˈspiːʃiːz/',
              'examples': ['endangered species', 'new species']
            }
          ]
        },
        {
          'text': 'The telescope captured images of distant galaxies.',
          'translation': '望遠鏡は遠い銀河の画像を捉えました。',
          'words': [
            {
              'word': 'telescope',
              'definition': 'instrument for viewing distant objects',
              'pronunciation': '/ˈtelɪskoʊp/',
              'examples': ['space telescope', 'radio telescope']
            },
            {
              'word': 'captured',
              'definition': 'took or recorded',
              'pronunciation': '/ˈkæptʃərd/',
              'examples': ['captured the moment', 'captured data']
            }
          ]
        }
      ],
      'Health': [
        {
          'text': 'Regular exercise improves both physical and mental health.',
          'translation': '定期的な運動は身体的・精神的健康の両方を改善します。',
          'words': [
            {
              'word': 'regular',
              'definition': 'happening often at the same times',
              'pronunciation': '/ˈreɡjələr/',
              'examples': ['regular exercise', 'regular meetings']
            },
            {
              'word': 'improves',
              'definition': 'makes better',
              'pronunciation': '/ɪmˈpruːvz/',
              'examples': ['improves health', 'improves performance']
            }
          ]
        },
        {
          'text': 'A balanced diet provides essential nutrients for the body.',
          'translation': 'バランスの取れた食事は体に必要な栄養素を提供します。',
          'words': [
            {
              'word': 'balanced',
              'definition': 'having the right proportions',
              'pronunciation': '/ˈbælənst/',
              'examples': ['balanced diet', 'balanced approach']
            },
            {
              'word': 'essential',
              'definition': 'absolutely necessary',
              'pronunciation': '/ɪˈsenʃəl/',
              'examples': ['essential nutrients', 'essential skills']
            }
          ]
        }
      ],
      'Travel': [
        {
          'text': 'Exploring new cultures broadens your perspective on life.',
          'translation': '新しい文化を探求することで、人生の視野が広がります。',
          'words': [
            {
              'word': 'exploring',
              'definition': 'discovering or investigating',
              'pronunciation': '/ɪkˈsplɔːrɪŋ/',
              'examples': ['exploring new places', 'exploring ideas']
            },
            {
              'word': 'perspective',
              'definition': 'point of view or way of thinking',
              'pronunciation': '/pərˈspektɪv/',
              'examples': ['different perspective', 'new perspective']
            }
          ]
        }
      ],
      'Business': [
        {
          'text': 'Innovation drives sustainable business growth.',
          'translation': 'イノベーションは持続可能な事業成長を推進します。',
          'words': [
            {
              'word': 'innovation',
              'definition': 'new ideas or methods',
              'pronunciation': '/ˌɪnəˈveɪʃən/',
              'examples': ['technological innovation', 'product innovation']
            },
            {
              'word': 'sustainable',
              'definition': 'able to continue over time',
              'pronunciation': '/səˈsteɪnəbəl/',
              'examples': ['sustainable development', 'sustainable practices']
            }
          ]
        }
      ]
    },
    'ja': {
      'Technology': [
        {
          'text': '量子コンピュータは従来の計算能力を大幅に超える可能性があります。',
          'translation': 'Quantum computers have the potential to greatly exceed conventional computing power.',
          'words': [
            {
              'word': '量子',
              'definition': 'エネルギーや物質の最小単位',
              'pronunciation': 'りょうし',
              'examples': ['量子物理学', '量子もつれ']
            },
            {
              'word': '従来',
              'definition': '今まで行われてきた方法や状態',
              'pronunciation': 'じゅうらい',
              'examples': ['従来の方法', '従来型']
            }
          ]
        },
        {
          'text': '人工知能の発達により、多くの業界で自動化が進んでいます。',
          'translation': 'Due to the development of artificial intelligence, automation is advancing in many industries.',
          'words': [
            {
              'word': '発達',
              'definition': '成長して完全な形になること',
              'pronunciation': 'はったつ',
              'examples': ['技術の発達', '経済発達']
            },
            {
              'word': '自動化',
              'definition': '人の手を介さずに自動で行うこと',
              'pronunciation': 'じどうか',
              'examples': ['工場の自動化', 'プロセス自動化']
            }
          ]
        }
      ],
      'Health': [
        {
          'text': '適度な運動と十分な睡眠は健康維持の基本です。',
          'translation': 'Moderate exercise and adequate sleep are the basics of maintaining health.',
          'words': [
            {
              'word': '適度',
              'definition': 'ちょうどよい程度',
              'pronunciation': 'てきど',
              'examples': ['適度な運動', '適度な温度']
            },
            {
              'word': '維持',
              'definition': '保ち続けること',
              'pronunciation': 'いじ',
              'examples': ['健康維持', '関係維持']
            }
          ]
        }
      ]
    },
    'zh': {
      'Technology': [
        {
          'text': '机器学习正在改变我们处理数据的方式。',
          'translation': 'Machine learning is changing the way we process data.',
          'words': [
            {
              'word': '机器学习',
              'definition': '让计算机通过数据学习的技术',
              'pronunciation': 'jīqì xuéxí',
              'examples': ['机器学习算法', '机器学习模型']
            },
            {
              'word': '处理',
              'definition': '对事物进行加工、整理',
              'pronunciation': 'chǔlǐ',
              'examples': ['处理数据', '处理问题']
            }
          ]
        },
        {
          'text': '云计算为企业提供了灵活的解决方案。',
          'translation': 'Cloud computing provides flexible solutions for businesses.',
          'words': [
            {
              'word': '灵活',
              'definition': '能够适应变化的',
              'pronunciation': 'línghuó',
              'examples': ['灵活应对', '灵活安排']
            },
            {
              'word': '解决方案',
              'definition': '解决问题的办法',
              'pronunciation': 'jiějué fāng\'àn',
              'examples': ['技术解决方案', '创新解决方案']
            }
          ]
        }
      ]
    },
    'de': {
      'Technology': [
        {
          'text': 'Die Digitalisierung verändert unsere Arbeitswelt grundlegend.',
          'translation': 'Digitalization is fundamentally changing our working world.',
          'words': [
            {
              'word': 'Digitalisierung',
              'definition': 'der Prozess der digitalen Umwandlung',
              'pronunciation': '/diɡitaliˈziːʁʊŋ/',
              'examples': ['die Digitalisierung der Wirtschaft', 'Digitalisierung vorantreiben']
            },
            {
              'word': 'grundlegend',
              'definition': 'sehr wichtig, fundamental',
              'pronunciation': '/ˈɡʁʊntleːɡənt/',
              'examples': ['grundlegende Veränderung', 'grundlegend anders']
            }
          ]
        }
      ],
      'Science': [
        {
          'text': 'Wissenschaftler erforschen die Geheimnisse des Universums.',
          'translation': 'Scientists are researching the secrets of the universe.',
          'words': [
            {
              'word': 'erforschen',
              'definition': 'systematisch untersuchen',
              'pronunciation': '/ɛrˈfɔrʃən/',
              'examples': ['die Natur erforschen', 'neue Gebiete erforschen']
            },
            {
              'word': 'Geheimnisse',
              'definition': 'verborgene oder unbekannte Dinge',
              'pronunciation': '/ɡəˈhaɪmnɪsə/',
              'examples': ['die Geheimnisse der Natur', 'ein Geheimnis lüften']
            }
          ]
        }
      ]
    },
    'sv': {
      'Technology': [
        {
          'text': 'Artificiell intelligens kommer att förändra framtiden.',
          'translation': 'Artificial intelligence will change the future.',
          'words': [
            {
              'word': 'artificiell',
              'definition': 'konstgjord, inte naturlig',
              'pronunciation': '/artɪfɪˈseːl/',
              'examples': ['artificiell intelligens', 'artificiella blommor']
            },
            {
              'word': 'förändra',
              'definition': 'göra annorlunda',
              'pronunciation': '/fœˈrɛndra/',
              'examples': ['förändra världen', 'förändra sig själv']
            }
          ]
        }
      ],
      'Science': [
        {
          'text': 'Forskare studerar klimatförändringar globalt.',
          'translation': 'Researchers are studying climate change globally.',
          'words': [
            {
              'word': 'forskare',
              'definition': 'personer som bedriver forskning',
              'pronunciation': '/ˈfɔːʂkarɛ/',
              'examples': ['medicinsk forskare', 'vetenskaplig forskare']
            },
            {
              'word': 'globalt',
              'definition': 'över hela världen',
              'pronunciation': '/ɡloˈbaːlt/',
              'examples': ['globalt problem', 'globalt perspektiv']
            }
          ]
        }
      ]
    }
  };

  Future<Sentence> getTodaysSentence(Language language, List<InterestCategory> categories) async {
    final languageCode = language.code;
    final availableCategories = _sentenceDatabase[languageCode]?.keys.toList() ?? [];

    // 選択されたカテゴリと利用可能なカテゴリの交集合を取得
    final validCategories = categories
        .where((cat) => availableCategories.contains(cat.englishName))
        .map((cat) => cat.englishName)
        .toList();

    if (validCategories.isEmpty) {
      // フォールバック：利用可能な最初のカテゴリを使用
      validCategories.add(availableCategories.first);
    }

    // ランダムにカテゴリと文章を選択
    final random = Random();
    final selectedCategory = validCategories[random.nextInt(validCategories.length)];
    final sentences = _sentenceDatabase[languageCode]![selectedCategory]!;
    final selectedSentence = sentences[random.nextInt(sentences.length)];

    return Sentence(
      id: '${DateTime.now().millisecondsSinceEpoch}',
      text: selectedSentence['text'],
      language: languageCode,
      category: selectedCategory,
      translation: selectedSentence['translation'],
      words: (selectedSentence['words'] as List)
          .map((word) => WordDefinition.fromJson(word))
          .toList(),
      createdAt: DateTime.now(),
    );
  }

  Future<Sentence> getRandomSentence(Language language, List<InterestCategory> categories) async {
    // Use a different random seed to ensure different sentences
    final random = Random(DateTime.now().millisecondsSinceEpoch);
    
    final languageCode = language.code;
    final availableCategories = _sentenceDatabase[languageCode]?.keys.toList() ?? [];

    final validCategories = categories
        .where((cat) => availableCategories.contains(cat.englishName))
        .map((cat) => cat.englishName)
        .toList();

    if (validCategories.isEmpty) {
      validCategories.add(availableCategories.first);
    }

    final selectedCategory = validCategories[random.nextInt(validCategories.length)];
    final sentences = _sentenceDatabase[languageCode]![selectedCategory]!;
    final selectedSentence = sentences[random.nextInt(sentences.length)];

    return Sentence(
      id: '${DateTime.now().millisecondsSinceEpoch}_${random.nextInt(1000)}',
      text: selectedSentence['text'],
      language: languageCode,
      category: selectedCategory,
      translation: selectedSentence['translation'],
      words: (selectedSentence['words'] as List)
          .map((word) => WordDefinition.fromJson(word))
          .toList(),
      createdAt: DateTime.now(),
    );
  }
}
