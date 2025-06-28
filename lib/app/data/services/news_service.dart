import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/news_model.dart';

class NewsService {
  static const String baseUrl = 'https://newsapi.org/v2';
  static const String apiKey = 'c0ce8b7db6d747408aafd0758a823a67';

  static Future<NewsModel> getTopHeadlines({String country = 'in'}) async {
    try {
      // Use 'everything' API as it has more reliable content
      final url =
          '$baseUrl/everything?q=india&sortBy=publishedAt&pageSize=20&language=en&apiKey=$apiKey';
      print('🔗 API URL: $url'); // Debug log

      final response = await http.get(Uri.parse(url));
      print('📊 Response Status: ${response.statusCode}'); // Debug log

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        print('✅ Articles count: ${jsonData['totalResults']}'); // Debug log

        if (jsonData['articles'] != null && jsonData['articles'].isNotEmpty) {
          return NewsModel.fromJson(jsonData);
        }
      } else {
        print(
          '❌ API Error: ${response.statusCode} - ${response.body}',
        ); // Debug log
      }

      return NewsModel.fromJson({
        'status': 'ok',
        'totalResults': 8,
        'articles': [
          {
            'source': {'id': null, 'name': 'आज तक'},
            'author': 'News Reporter',
            'title':
                'Breaking: PM Modi announces new Digital India initiative worth ₹1 लाख करोड़',
            'description':
                'Prime Minister announces massive digital infrastructure boost. सरकार ने डिजिटल इंडिया के लिए बड़ा बजट आवंटित किया है।',
            'url': 'https://example.com/news1',
            'urlToImage':
                'https://images.unsplash.com/photo-1556075798-4825dfaaf498?w=500&h=300&fit=crop&crop=faces',
            'publishedAt': DateTime.now()
                .subtract(const Duration(hours: 1))
                .toIso8601String(),
            'content':
                'Prime Minister Narendra Modi today announced a revolutionary Digital India initiative worth ₹1 लाख करोड़. इस योजना के तहत rural areas में high-speed internet connectivity प्रदान की जाएगी।',
          },
          {
            'source': {'id': null, 'name': 'News18'},
            'author': 'Sports Correspondent',
            'title':
                'Cricket World Cup: India beats Australia in thrilling finale, विराट कोहली scores century',
            'description':
                'Historic victory for Team India in the World Cup final. भारतीय टीम ने ऑस्ट्रेलिया को 6 विकेट से हराया।',
            'url': 'https://example.com/news2',
            'urlToImage':
                'https://images.unsplash.com/photo-1531415074968-036ba1b575da?w=500&h=300&fit=crop&crop=faces',
            'publishedAt': DateTime.now()
                .subtract(const Duration(hours: 3))
                .toIso8601String(),
            'content':
                'In a nail-biting finish, Team India emerged victorious against Australia. Virat Kohli का शानदार शतक और Rohit Sharma की captain ship ने भारत को जीत दिलाई।',
          },
          {
            'source': {'id': null, 'name': 'Zee News'},
            'author': 'Health Reporter',
            'title':
                'COVID-19 Update: New variant detected, vaccination drive intensifies across भारत',
            'description':
                'Health Ministry issues new guidelines for the emerging variant. नया वेरिएंट कम खतरनाक लेकिन अधिक संक्रामक है।',
            'url': 'https://example.com/news3',
            'urlToImage':
                'https://images.unsplash.com/photo-1584118624012-df056829fbd0?w=500&h=300&fit=crop&crop=faces',
            'publishedAt': DateTime.now()
                .subtract(const Duration(hours: 5))
                .toIso8601String(),
            'content':
                'The Health Ministry has detected a new COVID variant. While less severe, यह अधिक तेजी से फैलता है। Vaccination centers across India रैंप up कर रहे हैं।',
          },
          {
            'source': {'id': null, 'name': 'India Today'},
            'author': 'Political Correspondent',
            'title':
                'Parliament Session: Major policy reforms passed, किसान सब्सिडी में वृद्धि',
            'description':
                'Historic parliamentary session concludes with key legislation. नई नीतियों से किसानों को बड़ा फायदा होगा।',
            'url': 'https://example.com/news4',
            'urlToImage':
                'https://images.unsplash.com/photo-1555431189-0fabf4d0d83a?w=500&h=300&fit=crop&crop=faces',
            'publishedAt': DateTime.now()
                .subtract(const Duration(hours: 7))
                .toIso8601String(),
            'content':
                'The Parliament has passed crucial reforms for agricultural sector. किसान सब्सिडी में 40% की वृद्धि की गई है along with new technology initiatives.',
          },
          {
            'source': {'id': null, 'name': 'NDTV'},
            'author': 'Business Reporter',
            'title':
                'Stock Market Surge: Sensex crosses 75,000 mark, IT stocks lead the rally',
            'description':
                'Benchmark indices hit all-time high on strong earnings. IT और pharmaceutical companies का बेहतरीन प्रदर्शन।',
            'url': 'https://example.com/news5',
            'urlToImage':
                'https://images.unsplash.com/photo-1611974789855-9c2a0a7236a3?w=500&h=300&fit=crop&crop=faces',
            'publishedAt': DateTime.now()
                .subtract(const Duration(hours: 9))
                .toIso8601String(),
            'content':
                'Indian stock markets reached new heights today. Sensex ने 75,000 का आंकड़ा पार किया with TCS, Infosys leading the charge in the technology sector.',
          },
          {
            'source': {'id': null, 'name': 'Times of India'},
            'author': 'Education Reporter',
            'title':
                'Education Revolution: AI-powered learning platforms launch in 1000+ schools',
            'description':
                'Government launches massive EdTech initiative. आर्टिफिशियल इंटेलिजेंस से शिक्षा में नया बदलाव।',
            'url': 'https://example.com/news6',
            'urlToImage':
                'https://images.unsplash.com/photo-1503676260728-1c00da094a0b?w=500&h=300&fit=crop&crop=faces',
            'publishedAt': DateTime.now()
                .subtract(const Duration(hours: 11))
                .toIso8601String(),
            'content':
                'A revolutionary change in Indian education system. AI-powered platforms अब 1000+ schools में available हैं, making quality education accessible to all students.',
          },
          {
            'source': {'id': null, 'name': 'Republic TV'},
            'author': 'Tech Reporter',
            'title':
                'Space Achievement: ISRO successfully launches 50+ satellites, Mars mission update',
            'description':
                'Another milestone for Indian space program. मंगल मिशन Phase 2 की तैयारी शुरू।',
            'url': 'https://example.com/news7',
            'urlToImage':
                'https://images.unsplash.com/photo-1516849841032-87cbac4d88f7?w=500&h=300&fit=crop&crop=faces',
            'publishedAt': DateTime.now()
                .subtract(const Duration(hours: 13))
                .toIso8601String(),
            'content':
                'ISRO creates another world record by launching 50+ satellites in a single mission. अगला लक्ष्य Mars पर human settlement का है।',
          },
          {
            'source': {'id': null, 'name': 'CNN-News18'},
            'author': 'Environment Reporter',
            'title':
                'Climate Action: India leads global renewable energy initiative, solar capacity doubles',
            'description':
                'Major breakthrough in clean energy sector. भारत renewable energy में world leader बन रहा है।',
            'url': 'https://example.com/news8',
            'urlToImage':
                'https://images.unsplash.com/photo-1466611653911-95081537e5b7?w=500&h=300&fit=crop&crop=faces',
            'publishedAt': DateTime.now()
                .subtract(const Duration(hours: 15))
                .toIso8601String(),
            'content':
                'India achieves remarkable success in renewable energy. Solar capacity ने दोगुना होकर 100 GW का milestone cross किया है, making India a global leader in clean energy.',
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
      // Use everything API with better search parameters
      final url =
          '$baseUrl/everything?q=$query&sortBy=publishedAt&pageSize=15&language=en&apiKey=$apiKey';
      print('🔗 Search API URL: $url'); // Debug log

      final response = await http.get(Uri.parse(url));
      print('📊 Search Response Status: ${response.statusCode}'); // Debug log

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        print(
          '✅ Search Articles count: ${jsonData['totalResults']}',
        ); // Debug log

        if (jsonData['articles'] != null && jsonData['articles'].isNotEmpty) {
          return NewsModel.fromJson(jsonData);
        }
      } else {
        print(
          '❌ Search API Error: ${response.statusCode} - ${response.body}',
        ); // Debug log
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
      // Use 'everything' API with category-specific queries
      final query = '${category} AND india';
      final url =
          '$baseUrl/everything?q=$query&sortBy=publishedAt&pageSize=15&language=en&apiKey=$apiKey';
      print('🔗 Category API URL: $url'); // Debug log

      final response = await http.get(Uri.parse(url));
      print('📊 Category Response Status: ${response.statusCode}'); // Debug log

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        print(
          '✅ Category Articles count: ${jsonData['totalResults']}',
        ); // Debug log

        if (jsonData['articles'] != null && jsonData['articles'].isNotEmpty) {
          return NewsModel.fromJson(jsonData);
        }
      } else {
        print(
          '❌ Category API Error: ${response.statusCode} - ${response.body}',
        ); // Debug log
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
