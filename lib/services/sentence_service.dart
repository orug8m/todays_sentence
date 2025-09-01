import 'dart:math';
import '../models/sentence.dart';
import '../models/language.dart';
import '../models/interest_category.dart';
import 'chinese_translation_service.dart';

class SentenceService {
  // 事前定義された文章データベース（実際のAPIの代替）
  static final Map<String, Map<String, List<Map<String, dynamic>>>>
      _sentenceDatabase = {
    'en': {
      'Technology': [
        {
          'text':
              'Artificial intelligence is transforming how we work and live.',
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
          'text':
              'Scientists discovered a new species in the Amazon rainforest.',
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
          'translation':
              'Quantum computers have the potential to greatly exceed conventional computing power.',
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
          'translation':
              'Due to the development of artificial intelligence, automation is advancing in many industries.',
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
          'translation':
              'Moderate exercise and adequate sleep are the basics of maintaining health.',
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
    'zh-cn': {
      'Technology': [
        {
          'text': '机器学习正在改变我们处理数据的方式。',
          'translation':
              'Machine learning is changing the way we process data.',
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
          'translation':
              'Cloud computing provides flexible solutions for businesses.',
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
        },
        {
          'text': '人工智能将改变我们的工作方式。',
          'translation': 'Artificial intelligence will change the way we work.',
          'words': [
            {
              'word': '人工智能',
              'definition': '模拟人类智能的计算机系统',
              'pronunciation': 'réngōng zhìnéng',
              'examples': ['人工智能技术', '人工智能应用']
            },
            {
              'word': '工作方式',
              'definition': '完成工作的方法和模式',
              'pronunciation': 'gōngzuò fāngshì',
              'examples': ['现代工作方式', '灵活工作方式']
            }
          ]
        }
      ],
      'Science': [
        {
          'text': '科学家发现了新的基因治疗方法。',
          'translation': 'Scientists discovered new gene therapy methods.',
          'words': [
            {
              'word': '基因治疗',
              'definition': '通过基因修改治疗疾病的方法',
              'pronunciation': 'jīyīn zhìliáo',
              'examples': ['基因治疗技术', '基因治疗研究']
            },
            {
              'word': '方法',
              'definition': '达到目标的手段或途径',
              'pronunciation': 'fāngfǎ',
              'examples': ['治疗方法', '研究方法']
            }
          ]
        }
      ],
      'Health': [
        {
          'text': '均衡饮食对身体健康至关重要。',
          'translation': 'A balanced diet is crucial for physical health.',
          'words': [
            {
              'word': '均衡饮食',
              'definition': '营养搭配合理的饮食',
              'pronunciation': 'jūnhéng yǐnshí',
              'examples': ['保持均衡饮食', '均衡饮食习惯']
            },
            {
              'word': '至关重要',
              'definition': '极其重要，关键性的',
              'pronunciation': 'zhìguān zhòngyào',
              'examples': ['至关重要的决定', '至关重要的作用']
            }
          ]
        }
      ]
    },
    'zh-tw': {
      'Technology': [
        {
          'text': '機器學習正在改變我們處理數據的方式。',
          'translation':
              'Machine learning is changing the way we process data.',
          'words': [
            {
              'word': '機器學習',
              'definition': '讓計算機通過數據學習的技術',
              'pronunciation': 'jīqì xuéxí',
              'examples': ['機器學習算法', '機器學習模型']
            },
            {
              'word': '處理',
              'definition': '對事物進行加工、整理',
              'pronunciation': 'chǔlǐ',
              'examples': ['處理數據', '處理問題']
            }
          ]
        },
        {
          'text': '雲計算為企業提供了靈活的解決方案。',
          'translation':
              'Cloud computing provides flexible solutions for businesses.',
          'words': [
            {
              'word': '靈活',
              'definition': '能夠適應變化的',
              'pronunciation': 'línghuó',
              'examples': ['靈活應對', '靈活安排']
            },
            {
              'word': '解決方案',
              'definition': '解決問題的辦法',
              'pronunciation': 'jiějué fāng\'àn',
              'examples': ['技術解決方案', '創新解決方案']
            }
          ]
        },
        {
          'text': '人工智能將改變我們的工作方式。',
          'translation': 'Artificial intelligence will change the way we work.',
          'words': [
            {
              'word': '人工智能',
              'definition': '模擬人類智能的計算機系統',
              'pronunciation': 'réngōng zhìnéng',
              'examples': ['人工智能技術', '人工智能應用']
            },
            {
              'word': '工作方式',
              'definition': '完成工作的方法和模式',
              'pronunciation': 'gōngzuò fāngshì',
              'examples': ['現代工作方式', '靈活工作方式']
            }
          ]
        }
      ],
      'Science': [
        {
          'text': '科學家發現了新的基因治療方法。',
          'translation': 'Scientists discovered new gene therapy methods.',
          'words': [
            {
              'word': '基因治療',
              'definition': '通過基因修改治療疾病的方法',
              'pronunciation': 'jīyīn zhìliáo',
              'examples': ['基因治療技術', '基因治療研究']
            },
            {
              'word': '方法',
              'definition': '達到目標的手段或途徑',
              'pronunciation': 'fāngfǎ',
              'examples': ['治療方法', '研究方法']
            }
          ]
        }
      ],
      'Health': [
        {
          'text': '均衡飲食對身體健康至關重要。',
          'translation': 'A balanced diet is crucial for physical health.',
          'words': [
            {
              'word': '均衡飲食',
              'definition': '營養搭配合理的飲食',
              'pronunciation': 'jūnhéng yǐnshí',
              'examples': ['保持均衡飲食', '均衡飲食習慣']
            },
            {
              'word': '至關重要',
              'definition': '極其重要，關鍵性的',
              'pronunciation': 'zhìguān zhòngyào',
              'examples': ['至關重要的決定', '至關重要的作用']
            }
          ]
        }
      ]
    },
    'de': {
      'Technology': [
        {
          'text':
              'Die Digitalisierung verändert unsere Arbeitswelt grundlegend.',
          'translation':
              'Digitalization is fundamentally changing our working world.',
          'words': [
            {
              'word': 'Digitalisierung',
              'definition': 'der Prozess der digitalen Umwandlung',
              'pronunciation': '/diɡitaliˈziːʁʊŋ/',
              'examples': [
                'die Digitalisierung der Wirtschaft',
                'Digitalisierung vorantreiben'
              ]
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
          'translation':
              'Scientists are researching the secrets of the universe.',
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

  Future<Sentence> getTodaysSentence(
      Language language, List<InterestCategory> categories,
      [Language? nativeLanguage]) async {
    final languageCode = language.code;
    final availableCategories =
        _sentenceDatabase[languageCode]?.keys.toList() ?? [];

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
    final selectedCategory =
        validCategories[random.nextInt(validCategories.length)];
    final sentences = _sentenceDatabase[languageCode]![selectedCategory]!;
    final selectedSentence = sentences[random.nextInt(sentences.length)];

    // Native languageに基づいて翻訳を取得
    String translation = selectedSentence['translation'];
    if (nativeLanguage != null) {
      translation = _getTranslationForNativeLanguage(
        selectedSentence['text'],
        languageCode,
        selectedCategory,
        nativeLanguage.code,
      );
    }

    return Sentence(
      id: '${DateTime.now().millisecondsSinceEpoch}',
      text: selectedSentence['text'],
      language: languageCode,
      category: selectedCategory,
      translation: translation,
      words: (selectedSentence['words'] as List)
          .map((word) => WordDefinition.fromJson(word))
          .toList(),
      createdAt: DateTime.now(),
    );
  }

  Future<Sentence> getRandomSentence(
      Language language, List<InterestCategory> categories,
      [Language? nativeLanguage]) async {
    // Use a different random seed to ensure different sentences
    final random = Random(DateTime.now().millisecondsSinceEpoch);

    final languageCode = language.code;
    final availableCategories =
        _sentenceDatabase[languageCode]?.keys.toList() ?? [];

    final validCategories = categories
        .where((cat) => availableCategories.contains(cat.englishName))
        .map((cat) => cat.englishName)
        .toList();

    if (validCategories.isEmpty) {
      validCategories.add(availableCategories.first);
    }

    final selectedCategory =
        validCategories[random.nextInt(validCategories.length)];
    final sentences = _sentenceDatabase[languageCode]![selectedCategory]!;
    final selectedSentence = sentences[random.nextInt(sentences.length)];

    // Native languageに基づいて翻訳を取得
    String translation = selectedSentence['translation'];
    if (nativeLanguage != null) {
      translation = _getTranslationForNativeLanguage(
        selectedSentence['text'],
        languageCode,
        selectedCategory,
        nativeLanguage.code,
      );
    }

    return Sentence(
      id: '${DateTime.now().millisecondsSinceEpoch}_${random.nextInt(1000)}',
      text: selectedSentence['text'],
      language: languageCode,
      category: selectedCategory,
      translation: translation,
      words: (selectedSentence['words'] as List)
          .map((word) => WordDefinition.fromJson(word))
          .toList(),
      createdAt: DateTime.now(),
    );
  }

  /// 中国語の文章の簡体字/繁体字バリエーションを取得
  Map<String, String> getChineseVariations(Sentence sentence) {
    if (!sentence.language.startsWith('zh')) {
      return {'original': sentence.text};
    }

    final isSimplified = sentence.language == 'zh-cn';
    return ChineseTranslationService.getChineseVariations(
        sentence.text, isSimplified);
  }

  /// Native languageに基づいて適切な翻訳を取得
  String _getTranslationForNativeLanguage(
    String originalText,
    String fromLanguage,
    String category,
    String toLanguage,
  ) {
    // まず、対象言語のデータベースから同じ意味の文章を探す
    final targetLanguageData = _sentenceDatabase[toLanguage];
    if (targetLanguageData == null) {
      // フォールバック：元の翻訳を返す
      return _getOriginalTranslation(originalText, fromLanguage, category);
    }

    // カテゴリが存在するかチェック
    final targetCategoryData = targetLanguageData[category];
    if (targetCategoryData == null || targetCategoryData.isEmpty) {
      return _getOriginalTranslation(originalText, fromLanguage, category);
    }

    // 簡単なマッピング（実際のアプリではより高度な翻訳システムが必要）
    // ここでは基本的な翻訳マッピングを提供
    return _getBasicTranslation(originalText, fromLanguage, toLanguage);
  }

  /// 元の翻訳を取得するヘルパーメソッド
  String _getOriginalTranslation(
      String originalText, String fromLanguage, String category) {
    final sentences = _sentenceDatabase[fromLanguage]?[category];
    if (sentences != null) {
      for (final sentence in sentences) {
        if (sentence['text'] == originalText) {
          return sentence['translation'] ?? originalText;
        }
      }
    }
    return originalText;
  }

  /// 基本的な翻訳を提供するヘルパーメソッド
  String _getBasicTranslation(
      String originalText, String fromLanguage, String toLanguage) {
    // 各言語ペアの基本的な翻訳マッピング
    final translationMappings = {
      // English to other languages
      'en-ja': {
        'Artificial intelligence is transforming how we work and live.':
            '人工知能は、私たちの働き方や生活を変革しています。',
        'Cloud computing enables access to data from anywhere.':
            'クラウドコンピューティングにより、どこからでもデータにアクセスできます。',
        'Scientists discovered a new species in the Amazon rainforest.':
            '科学者たちはアマゾンの熱帯雨林で新しい種を発見しました。',
        'The telescope captured images of distant galaxies.':
            '望遠鏡は遠い銀河の画像を捉えました。',
        'Regular exercise improves both physical and mental health.':
            '定期的な運動は身体的・精神的健康の両方を改善します。',
        'A balanced diet provides essential nutrients for the body.':
            'バランスの取れた食事は体に必要な栄養素を提供します。',
        'Exploring new cultures broadens your perspective on life.':
            '新しい文化を探求することで、人生の視野が広がります。',
        'Innovation drives sustainable business growth.':
            'イノベーションは持続可能な事業成長を推進します。',
      },
      'en-de': {
        'Artificial intelligence is transforming how we work and live.':
            'Künstliche Intelligenz verändert, wie wir arbeiten und leben.',
        'Cloud computing enables access to data from anywhere.':
            'Cloud-Computing ermöglicht den Zugang zu Daten von überall.',
        'Scientists discovered a new species in the Amazon rainforest.':
            'Wissenschaftler entdeckten eine neue Art im Amazonas-Regenwald.',
        'The telescope captured images of distant galaxies.':
            'Das Teleskop erfasste Bilder entfernter Galaxien.',
        'Regular exercise improves both physical and mental health.':
            'Regelmäßige Bewegung verbessert sowohl die körperliche als auch die geistige Gesundheit.',
        'A balanced diet provides essential nutrients for the body.':
            'Eine ausgewogene Ernährung versorgt den Körper mit wichtigen Nährstoffen.',
        'Exploring new cultures broadens your perspective on life.':
            'Das Erkunden neuer Kulturen erweitert die Lebensperspektive.',
        'Innovation drives sustainable business growth.':
            'Innovation treibt nachhaltiges Unternehmenswachstum voran.',
      },
      'en-zh-tw': {
        'Artificial intelligence is transforming how we work and live.':
            '人工智能正在改變我們的工作和生活方式。',
        'Cloud computing enables access to data from anywhere.':
            '雲端運算使我們能夠從任何地方存取資料。',
        'Scientists discovered a new species in the Amazon rainforest.':
            '科學家在亞馬遜雨林發現了新物種。',
        'The telescope captured images of distant galaxies.': '望遠鏡捕捉到了遙遠星系的圖像。',
        'Regular exercise improves both physical and mental health.':
            '定期運動可以改善身心健康。',
        'A balanced diet provides essential nutrients for the body.':
            '均衡飲食為身體提供必需的營養素。',
        'Exploring new cultures broadens your perspective on life.':
            '探索新文化能拓展您的人生視野。',
        'Innovation drives sustainable business growth.': '創新推動可持續的商業成長。',
      },
      'en-zh-cn': {
        'Artificial intelligence is transforming how we work and live.':
            '人工智能正在改变我们的工作和生活方式。',
        'Cloud computing enables access to data from anywhere.':
            '云计算使我们能够从任何地方访问数据。',
        'Scientists discovered a new species in the Amazon rainforest.':
            '科学家在亚马逊雨林发现了新物种。',
        'The telescope captured images of distant galaxies.': '望远镜捕捉到了遥远星系的图像。',
        'Regular exercise improves both physical and mental health.':
            '定期运动可以改善身心健康。',
        'A balanced diet provides essential nutrients for the body.':
            '均衡饮食为身体提供必需的营养素。',
        'Exploring new cultures broadens your perspective on life.':
            '探索新文化能拓展您的人生视野。',
        'Innovation drives sustainable business growth.': '创新推动可持续的商业增长。',
      },
      'en-sv': {
        'Artificial intelligence is transforming how we work and live.':
            'Artificiell intelligens förändrar hur vi arbetar och lever.',
        'Cloud computing enables access to data from anywhere.':
            'Molntjänster möjliggör tillgång till data från var som helst.',
        'Scientists discovered a new species in the Amazon rainforest.':
            'Forskare upptäckte en ny art i Amazonas regnskog.',
        'The telescope captured images of distant galaxies.':
            'Teleskopet fångade bilder av avlägsna galaxer.',
        'Regular exercise improves both physical and mental health.':
            'Regelbunden träning förbättrar både fysisk och mental hälsa.',
        'A balanced diet provides essential nutrients for the body.':
            'En balanserad kost ger kroppen viktiga näringsämnen.',
        'Exploring new cultures broadens your perspective on life.':
            'Att utforska nya kulturer vidgar ditt perspektiv på livet.',
        'Innovation drives sustainable business growth.':
            'Innovation driver hållbar affärstillväxt.',
      },
      // German to other languages
      'de-ja': {
        'Die Digitalisierung verändert unsere Arbeitswelt grundlegend.':
            'デジタル化は私たちの労働環境を根本的に変えています。',
        'Wissenschaftler erforschen die Geheimnisse des Universums.':
            '科学者たちは宇宙の秘密を探求しています。',
      },
      'de-en': {
        'Die Digitalisierung verändert unsere Arbeitswelt grundlegend.':
            'Digitalization is fundamentally changing our working world.',
        'Wissenschaftler erforschen die Geheimnisse des Universums.':
            'Scientists are researching the secrets of the universe.',
      },
      'de-zh-tw': {
        'Die Digitalisierung verändert unsere Arbeitswelt grundlegend.':
            '數位化正在從根本上改變我們的工作環境。',
        'Wissenschaftler erforschen die Geheimnisse des Universums.':
            '科學家正在探索宇宙的奧秘。',
      },
      'de-zh-cn': {
        'Die Digitalisierung verändert unsere Arbeitswelt grundlegend.':
            '数字化正在从根本上改变我们的工作环境。',
        'Wissenschaftler erforschen die Geheimnisse des Universums.':
            '科学家正在探索宇宙的奥秘。',
      },
      'de-sv': {
        'Die Digitalisierung verändert unsere Arbeitswelt grundlegend.':
            'Digitaliseringen förändrar vår arbetsmiljö grundläggande.',
        'Wissenschaftler erforschen die Geheimnisse des Universums.':
            'Forskare utforskar universums hemligheter.',
      },
      // Japanese to other languages
      'ja-en': {
        '量子コンピュータは従来の計算能力を大幅に超える可能性があります。':
            'Quantum computers have the potential to greatly exceed conventional computing power.',
        '人工知能の発達により、多くの業界で自動化が進んでいます。':
            'Due to the development of artificial intelligence, automation is advancing in many industries.',
        '適度な運動と十分な睡眠は健康維持の基本です。':
            'Moderate exercise and adequate sleep are the basics of maintaining health.',
      },
      'ja-de': {
        '量子コンピュータは従来の計算能力を大幅に超える可能性があります。':
            'Quantencomputer haben das Potenzial, die herkömmliche Rechenleistung erheblich zu übertreffen.',
        '人工知能の発達により、多くの業界で自動化が進んでいます。':
            'Aufgrund der Entwicklung der künstlichen Intelligenz schreitet die Automatisierung in vielen Branchen voran.',
        '適度な運動と十分な睡眠は健康維持の基本です。':
            'Mäßige Bewegung und ausreichend Schlaf sind die Grundlagen der Gesunderhaltung.',
      },
      'ja-zh-tw': {
        '量子コンピュータは従来の計算能力を大幅に超える可能性があります。': '量子電腦有可能大幅超越傳統的計算能力。',
        '人工知能の発達により、多くの業界で自動化が進んでいます。': '隨著人工智能的發展，許多行業的自動化正在推進。',
        '適度な運動と十分な睡眠は健康維持の基本です。': '適度運動和充足睡眠是維持健康的基礎。',
      },
      'ja-zh-cn': {
        '量子コンピュータは従来の計算能力を大幅に超える可能性があります。': '量子计算机有可能大幅超越传统的计算能力。',
        '人工知能の発達により、多くの業界で自動化が進んでいます。': '随着人工智能的发展，许多行业的自动化正在推进。',
        '適度な運動と十分な睡眠は健康維持の基本です。': '适度运动和充足睡眠是维持健康的基础。',
      },
      'ja-sv': {
        '量子コンピュータは従来の計算能力を大幅に超える可能性があります。':
            'Kvantdatorer har potential att kraftigt överträffa konventionell datorkraft.',
        '人工知能の発達により、多くの業界で自動化が進んでいます。':
            'På grund av utvecklingen av artificiell intelligens framskrider automatiseringen i många branscher.',
        '適度な運動と十分な睡眠は健康維持の基本です。':
            'Måttlig motion och tillräcklig sömn är grunden för att upprätthålla hälsan.',
      },
      // Chinese Simplified to other languages
      'zh-cn-ja': {
        '机器学习正在改变我们处理数据的方式。': '機械学習はデータ処理の方法を変えています。',
        '云计算为企业提供了灵活的解决方案。': 'クラウドコンピューティングは企業に柔軟なソリューションを提供します。',
        '人工智能将改变我们的工作方式。': '人工知能は私たちの働き方を変えるでしょう。',
        '科学家发现了新的基因治疗方法。': '科学者は新しい遺伝子治療方法を発見しました。',
        '均衡饮食对身体健康至关重要。': 'バランスの取れた食事は身体の健康にとって極めて重要です。',
      },
      'zh-cn-en': {
        '机器学习正在改变我们处理数据的方式。':
            'Machine learning is changing the way we process data.',
        '云计算为企业提供了灵活的解决方案。':
            'Cloud computing provides flexible solutions for businesses.',
        '人工智能将改变我们的工作方式。':
            'Artificial intelligence will change the way we work.',
        '科学家发现了新的基因治疗方法。': 'Scientists discovered new gene therapy methods.',
        '均衡饮食对身体健康至关重要。': 'A balanced diet is crucial for physical health.',
      },
      'zh-cn-de': {
        '机器学习正在改变我们处理数据的方式。':
            'Maschinelles Lernen verändert die Art, wie wir Daten verarbeiten.',
        '云计算为企业提供了灵活的解决方案。':
            'Cloud-Computing bietet Unternehmen flexible Lösungen.',
        '人工智能将改变我们的工作方式。':
            'Künstliche Intelligenz wird unsere Arbeitsweise verändern.',
        '科学家发现了新的基因治疗方法。':
            'Wissenschaftler entdeckten neue Gentherapie-Methoden.',
        '均衡饮食对身体健康至关重要。':
            'Eine ausgewogene Ernährung ist für die körperliche Gesundheit von entscheidender Bedeutung.',
      },
      'zh-cn-sv': {
        '机器学习正在改变我们处理数据的方式。':
            'Maskininlärning förändrar sättet vi behandlar data.',
        '云计算为企业提供了灵活的解决方案。': 'Molntjänster ger företag flexibla lösningar.',
        '人工智能将改变我们的工作方式。':
            'Artificiell intelligens kommer att förändra vårt arbetssätt.',
        '科学家发现了新的基因治疗方法。': 'Forskare upptäckte nya genbehandlingsmetoder.',
        '均衡饮食对身体健康至关重要。': 'En balanserad kost är avgörande för fysisk hälsa.',
      },
      'zh-cn-zh-tw': {
        '机器学习正在改变我们处理数据的方式。': '機器學習正在改變我們處理數據的方式。',
        '云计算为企业提供了灵活的解决方案。': '雲計算為企業提供了靈活的解決方案。',
        '人工智能将改变我们的工作方式。': '人工智能將改變我們的工作方式。',
        '科学家发现了新的基因治疗方法。': '科學家發現了新的基因治療方法。',
        '均衡饮食对身体健康至关重要。': '均衡飲食對身體健康至關重要。',
      },
      // Chinese Traditional to other languages
      'zh-tw-ja': {
        '機器學習正在改變我們處理數據的方式。': '機械学習はデータ処理の方法を変えています。',
        '雲計算為企業提供了靈活的解決方案。': 'クラウドコンピューティングは企業に柔軟なソリューションを提供します。',
        '人工智能將改變我們的工作方式。': '人工知能は私たちの働き方を変えるでしょう。',
        '科學家發現了新的基因治療方法。': '科学者は新しい遺伝子治療方法を発見しました。',
        '均衡飲食對身體健康至關重要。': 'バランスの取れた食事は身体の健康にとって極めて重要です。',
      },
      'zh-tw-en': {
        '機器學習正在改變我們處理數據的方式。':
            'Machine learning is changing the way we process data.',
        '雲計算為企業提供了靈活的解決方案。':
            'Cloud computing provides flexible solutions for businesses.',
        '人工智能將改變我們的工作方式。':
            'Artificial intelligence will change the way we work.',
        '科學家發現了新的基因治療方法。': 'Scientists discovered new gene therapy methods.',
        '均衡飲食對身體健康至關重要。': 'A balanced diet is crucial for physical health.',
      },
      'zh-tw-de': {
        '機器學習正在改變我們處理數據的方式。':
            'Maschinelles Lernen verändert die Art, wie wir Daten verarbeiten.',
        '雲計算為企業提供了靈活的解決方案。':
            'Cloud-Computing bietet Unternehmen flexible Lösungen.',
        '人工智能將改變我們的工作方式。':
            'Künstliche Intelligenz wird unsere Arbeitsweise verändern.',
        '科學家發現了新的基因治療方法。':
            'Wissenschaftler entdeckten neue Gentherapie-Methoden.',
        '均衡飲食對身體健康至關重要。':
            'Eine ausgewogene Ernährung ist für die körperliche Gesundheit von entscheidender Bedeutung.',
      },
      'zh-tw-sv': {
        '機器學習正在改變我們處理數據的方式。':
            'Maskininlärning förändrar sättet vi behandlar data.',
        '雲計算為企業提供了靈活的解決方案。': 'Molntjänster ger företag flexibla lösningar.',
        '人工智能將改變我們的工作方式。':
            'Artificiell intelligens kommer att förändra vårt arbetssätt.',
        '科學家發現了新的基因治療方法。': 'Forskare upptäckte nya genbehandlingsmetoder.',
        '均衡飲食對身體健康至關重要。': 'En balanserad kost är avgörande för fysisk hälsa.',
      },
      'zh-tw-zh-cn': {
        '機器學習正在改變我們處理數據的方式。': '机器学习正在改变我们处理数据的方式。',
        '雲計算為企業提供了靈活的解決方案。': '云计算为企业提供了灵活的解决方案。',
        '人工智能將改變我們的工作方式。': '人工智能将改变我们的工作方式。',
        '科學家發現了新的基因治療方法。': '科学家发现了新的基因治疗方法。',
        '均衡飲食對身體健康至關重要。': '均衡饮食对身体健康至关重要。',
      },
      // Swedish to other languages
      'sv-ja': {
        'Artificiell intelligens kommer att förändra framtiden.':
            '人工知能は未来を変えるでしょう。',
        'Forskare studerar klimatförändringar globalt.':
            '研究者は地球規模で気候変動を研究しています。',
      },
      'sv-en': {
        'Artificiell intelligens kommer att förändra framtiden.':
            'Artificial intelligence will change the future.',
        'Forskare studerar klimatförändringar globalt.':
            'Researchers are studying climate change globally.',
      },
      'sv-de': {
        'Artificiell intelligens kommer att förändra framtiden.':
            'Künstliche Intelligenz wird die Zukunft verändern.',
        'Forskare studerar klimatförändringar globalt.':
            'Forscher untersuchen den Klimawandel global.',
      },
      'sv-zh-tw': {
        'Artificiell intelligens kommer att förändra framtiden.': '人工智能將改變未來。',
        'Forskare studerar klimatförändringar globalt.': '研究人員正在全球研究氣候變遷。',
      },
      'sv-zh-cn': {
        'Artificiell intelligens kommer att förändra framtiden.': '人工智能将改变未来。',
        'Forskare studerar klimatförändringar globalt.': '研究人员正在全球研究气候变化。',
      },
    };

    final mappingKey = '$fromLanguage-$toLanguage';
    final mapping = translationMappings[mappingKey];

    return mapping?[originalText] ?? originalText;
  }
}
