class ChineseTranslationService {
  // 簡体字から繁体字への基本的な変換マッピング
  static const Map<String, String> _simplifiedToTraditional = {
    // 一般的な変換例
    '学习': '學習',
    '机器': '機器',
    '处理': '處理',
    '数据': '數據',
    '计算机': '計算機',
    '网络': '網絡',
    '电脑': '電腦',
    '软件': '軟件',
    '硬件': '硬件',
    '程序': '程序',
    '系统': '系統',
    '技术': '技術',
    '开发': '開發',
    '应用': '應用',
    '服务': '服務',
    '问题': '問題',
    '解决': '解決',
    '方案': '方案',
    '创新': '創新',
    '发展': '發展',
    '改变': '改變',
    '提供': '提供',
    '企业': '企業',
    '灵活': '靈活',
    '云计算': '雲計算',
    '人工智能': '人工智慧',
    '大数据': '大數據',
    '物联网': '物聯網',
  };

  // 繁体字から簡体字への変換マッピング（上記の逆）
  static final Map<String, String> _traditionalToSimplified =
      _simplifiedToTraditional.map((key, value) => MapEntry(value, key));

  /// 簡体字を繁体字に変換
  static String convertToTraditional(String simplifiedText) {
    String result = simplifiedText;

    _simplifiedToTraditional.forEach((simplified, traditional) {
      result = result.replaceAll(simplified, traditional);
    });

    return result;
  }

  /// 繁体字を簡体字に変換
  static String convertToSimplified(String traditionalText) {
    String result = traditionalText;

    _traditionalToSimplified.forEach((traditional, simplified) {
      result = result.replaceAll(traditional, simplified);
    });

    return result;
  }

  /// 中国語のバリエーション（簡体字・繁体字）を取得
  static Map<String, String> getChineseVariations(
      String text, bool isSimplified) {
    if (isSimplified) {
      return {
        'simplified': text,
        'traditional': convertToTraditional(text),
      };
    } else {
      return {
        'simplified': convertToSimplified(text),
        'traditional': text,
      };
    }
  }
}
