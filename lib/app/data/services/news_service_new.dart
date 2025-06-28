import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/news_model.dart';

class NewsService {
  static const String baseUrl = 'https://newsapi.org/v2';
  static const String apiKey = 'c0ce8b7db6d747408aafd0758a823a67';

  static Future<NewsModel> getTopHeadlines({String country = 'in'}) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/top-headlines?country=$country&apiKey=$apiKey'),
      );

      if (response.statusCode == 200) {
        return NewsModel.fromJson(json.decode(response.body));
      }

      return NewsModel.fromJson({
        'status': 'ok',
        'totalResults': 6,
        'articles': [
          {
            'source': {'id': null, 'name': 'आज तक'},
            'author': 'समाचार संवाददाता',
            'title': 'भारत में नई तकनीकी क्रांति: डिजिटल इंडिया की नई शुरुआत',
            'description':
                'देश में डिजिटल क्रांति के साथ नई तकनीकों का विकास हो रहा है। सरकार की नई नीतियों से तकनीकी क्षेत्र में बड़े बदलाव की उम्मीद है।',
            'url': 'https://example.com/news1',
            'urlToImage':
                'https://images.unsplash.com/photo-1518709268805-4e9042af2176?w=400&h=200&fit=crop',
            'publishedAt': DateTime.now()
                .subtract(const Duration(hours: 2))
                .toIso8601String(),
            'content':
                'भारत सरकार द्वारा शुरू की गई डिजिटल इंडिया की पहल के तहत देश में तकनीकी विकास की नई लहर आई है। इस पहल से न केवल शहरी बल्कि ग्रामीण क्षेत्रों में भी डिजिटल सेवाओं का विस्तार हो रहा है।',
          },
          {
            'source': {'id': null, 'name': 'न्यूज़18'},
            'author': 'खेल संवाददाता',
            'title':
                'क्रिकेट: भारतीय टीम की शानदार जीत, विश्व कप में नया रिकॉर्ड',
            'description':
                'भारतीय क्रिकेट टीम ने आज अपने प्रतिद्वंद्वी को हराकर विश्व कप में नया इतिहास रचा है। कप्तान की शानदार बल्लेबाजी से टीम को मिली जीत।',
            'url': 'https://example.com/news2',
            'urlToImage':
                'https://images.unsplash.com/photo-1540747913346-19e32dc3e97e?w=400&h=200&fit=crop',
            'publishedAt': DateTime.now()
                .subtract(const Duration(hours: 4))
                .toIso8601String(),
            'content':
                'भारतीय क्रिकेट टीम ने आज विश्व कप में एक और शानदार प्रदर्शन करते हुए अपने प्रतिद्वंद्वी को 8 विकेट से हराया। कप्तान विराट कोहली की 120 रन की नाबाद पारी से टीम को आसान जीत मिली।',
          },
          {
            'source': {'id': null, 'name': 'ज़ी न्यूज़'},
            'author': 'स्वास्थ्य संवाददाता',
            'title': 'स्वास्थ्य: नई दवा से कैंसर के इलाज में मिली सफलता',
            'description':
                'भारतीय वैज्ञानिकों द्वारा विकसित की गई नई दवा से कैंसर के इलाज में बड़ी सफलता मिली है। इस दवा से मरीजों की ठीक होने की दर में काफी वृद्धि हुई है।',
            'url': 'https://example.com/news3',
            'urlToImage':
                'https://images.unsplash.com/photo-1559757148-5c350d0d3c56?w=400&h=200&fit=crop',
            'publishedAt': DateTime.now()
                .subtract(const Duration(hours: 6))
                .toIso8601String(),
            'content':
                'दिल्ली के एम्स अस्पताल के डॉक्टरों ने कैंसर के इलाज के लिए एक नई दवा विकसित की है। यह दवा पारंपरिक कीमोथेरेपी की तुलना में अधिक प्रभावी है और इसके साइड इफेक्ट्स भी कम हैं।',
          },
          {
            'source': {'id': null, 'name': 'इंडिया टुडे'},
            'author': 'राजनीतिक संवाददाता',
            'title': 'राजनीति: नई नीति से किसानों को होगा फायदा, सरकार का ऐलान',
            'description':
                'केंद्र सरकार ने किसानों के लिए नई नीति की घोषणा की है। इस नीति से किसानों की आय में वृद्धि होने की उम्मीद है।',
            'url': 'https://example.com/news4',
            'urlToImage':
                'https://images.unsplash.com/photo-1574323347407-f5e1ad6d020b?w=400&h=200&fit=crop',
            'publishedAt': DateTime.now()
                .subtract(const Duration(hours: 8))
                .toIso8601String(),
            'content':
                'प्रधानमंत्री नरेंद्र मोदी ने आज किसानों के लिए एक नई नीति की घोषणा की है। इस नीति के तहत किसानों को बेहतर बीज, खाद और तकनीकी सहायता प्रदान की जाएगी।',
          },
          {
            'source': {'id': null, 'name': 'डीडी न्यूज़'},
            'author': 'शिक्षा संवाददाता',
            'title': 'शिक्षा: नई शिक्षा नीति से बदलेगी पढ़ाई का तरीका',
            'description':
                'नई राष्ट्रीय शिक्षा नीति के तहत स्कूलों और कॉलेजों में पढ़ाई के तरीकों में बड़े बदलाव होंगे। डिजिटल शिक्षा को बढ़ावा दिया जाएगा।',
            'url': 'https://example.com/news5',
            'urlToImage':
                'https://images.unsplash.com/photo-1503676260728-1c00da094a0b?w=400&h=200&fit=crop',
            'publishedAt': DateTime.now()
                .subtract(const Duration(hours: 10))
                .toIso8601String(),
            'content':
                'नई राष्ट्रीय शिक्षा नीति 2020 के तहत भारत में शिक्षा प्रणाली में महत्वपूर्ण बदलाव किए जा रहे हैं। इसका मुख्य उद्देश्य छात्रों को 21वीं सदी के लिए तैयार करना है।',
          },
          {
            'source': {'id': null, 'name': 'रिपब्लिक'},
            'author': 'व्यापार संवाददाता',
            'title':
                'व्यापार: भारतीय कंपनियों का शेयर बाजार में शानदार प्रदर्शन',
            'description':
                'आज भारतीय शेयर बाजार में तेजी देखी गई। कई कंपनियों के शेयरों में बड़ी वृद्धि हुई है।',
            'url': 'https://example.com/news6',
            'urlToImage':
                'https://images.unsplash.com/photo-1611974789855-9c2a0a7236a3?w=400&h=200&fit=crop',
            'publishedAt': DateTime.now()
                .subtract(const Duration(hours: 12))
                .toIso8601String(),
            'content':
                'आज बंबई स्टॉक एक्सचेंज में सेंसेक्स 500 अंक बढ़कर 60,000 के पार पहुंच गया। IT और फार्मा कंपनियों के शेयरों में खासकर तेजी देखी गई।',
          },
        ],
      });
    } catch (e) {
      return NewsModel.fromJson({
        'status': 'ok',
        'totalResults': 1,
        'articles': [
          {
            'source': {'id': null, 'name': 'डेमो न्यूज़'},
            'author': 'सिस्टम',
            'title': 'समाचार ऐप में आपका स्वागत है',
            'description':
                'यह डेमो कंटेंट है। वास्तविक समाचारों के लिए API की जरूरत है।',
            'url': 'https://example.com',
            'urlToImage':
                'https://images.unsplash.com/photo-1495020689067-958852a7765e?w=400&h=200&fit=crop',
            'publishedAt': DateTime.now().toIso8601String(),
            'content': 'डेमो कंटेंट...',
          },
        ],
      });
    }
  }

  static Future<NewsModel> searchNews(String query) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/everything?q=$query&language=hi&apiKey=$apiKey'),
      );

      if (response.statusCode == 200) {
        return NewsModel.fromJson(json.decode(response.body));
      }

      return NewsModel.fromJson({
        'status': 'ok',
        'totalResults': 2,
        'articles': [
          {
            'source': {'id': null, 'name': 'खोज परिणाम'},
            'author': 'डेमो लेखक',
            'title': '$query के लिए खोज परिणाम',
            'description': 'आपकी खोज "$query" के लिए यह डेमो परिणाम है',
            'url': 'https://example.com/search',
            'urlToImage':
                'https://images.unsplash.com/photo-1504711434969-e33886168f5c?w=400&h=200&fit=crop',
            'publishedAt': DateTime.now().toIso8601String(),
            'content': 'डेमो खोज कंटेंट...',
          },
          {
            'source': {'id': null, 'name': 'संबंधित समाचार'},
            'author': 'संबंधित लेखक',
            'title': '$query विषय से संबंधित समाचार',
            'description': 'आपकी खोज से संबंधित अतिरिक्त जानकारी।',
            'url': 'https://example.com/related',
            'urlToImage':
                'https://images.unsplash.com/photo-1586339949916-3e9457bef6d3?w=400&h=200&fit=crop',
            'publishedAt': DateTime.now()
                .subtract(const Duration(minutes: 30))
                .toIso8601String(),
            'content': 'संबंधित डेमो कंटेंट...',
          },
        ],
      });
    } catch (e) {
      return NewsModel();
    }
  }

  static Future<NewsModel> getNewsByCategory(String category) async {
    try {
      final response = await http.get(
        Uri.parse(
          '$baseUrl/top-headlines?category=$category&country=in&apiKey=$apiKey',
        ),
      );

      if (response.statusCode == 200) {
        return NewsModel.fromJson(json.decode(response.body));
      }

      String categoryHindi = _getCategoryInHindi(category);

      return NewsModel.fromJson({
        'status': 'ok',
        'totalResults': 2,
        'articles': [
          {
            'source': {'id': null, 'name': '$categoryHindi समाचार'},
            'author': '$categoryHindi संवाददाता',
            'title': 'नवीनतम $categoryHindi अपडेट और मुख्य समाचार',
            'description':
                '$categoryHindi श्रेणी में नवीनतम समाचारों से अपडेट रहें।',
            'url': 'https://example.com/$category',
            'urlToImage':
                'https://images.unsplash.com/photo-1586339949916-3e9457bef6d3?w=400&h=200&fit=crop',
            'publishedAt': DateTime.now()
                .subtract(const Duration(hours: 1))
                .toIso8601String(),
            'content': 'डेमो $categoryHindi कंटेंट...',
          },
          {
            'source': {'id': null, 'name': '$categoryHindi दैनिक'},
            'author': 'विशेषज्ञ संवाददाता',
            'title': '$categoryHindi के रुझानों का गहन विश्लेषण',
            'description': 'वर्तमान $categoryHindi विकास की व्यापक कवरेज।',
            'url': 'https://example.com/$category-analysis',
            'urlToImage':
                'https://images.unsplash.com/photo-1504711434969-e33886168f5c?w=400&h=200&fit=crop',
            'publishedAt': DateTime.now()
                .subtract(const Duration(hours: 3))
                .toIso8601String(),
            'content': 'डेमो $categoryHindi विश्लेषण...',
          },
        ],
      });
    } catch (e) {
      return NewsModel();
    }
  }

  static String _getCategoryInHindi(String category) {
    switch (category) {
      case 'general':
        return 'सामान्य';
      case 'business':
        return 'व्यापार';
      case 'entertainment':
        return 'मनोरंजन';
      case 'health':
        return 'स्वास्थ्य';
      case 'science':
        return 'विज्ञान';
      case 'sports':
        return 'खेल';
      case 'technology':
        return 'तकनीक';
      default:
        return category;
    }
  }
}
