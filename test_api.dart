import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  const String baseUrl = 'https://newsapi.org/v2';
  const String apiKey = 'c0ce8b7db6d747408aafd0758a823a67';

  print('🔥 Testing NewsAPI...');

  try {
    // Test 1: Basic headlines
    final url1 = '$baseUrl/top-headlines?country=in&apiKey=$apiKey';
    print('🔗 Testing URL 1: $url1');

    final response1 = await http.get(Uri.parse(url1));
    print('📊 Status 1: ${response1.statusCode}');

    if (response1.statusCode == 200) {
      final data1 = json.decode(response1.body);
      print('✅ Articles from headlines: ${data1['totalResults']}');
      if (data1['articles'] != null && data1['articles'].isNotEmpty) {
        print('📰 First article: ${data1['articles'][0]['title']}');
      }
    } else {
      print('❌ Error 1: ${response1.body}');
    }

    // Test 2: Everything API
    final url2 =
        '$baseUrl/everything?q=india&sortBy=publishedAt&pageSize=5&apiKey=$apiKey';
    print('\n🔗 Testing URL 2: $url2');

    final response2 = await http.get(Uri.parse(url2));
    print('📊 Status 2: ${response2.statusCode}');

    if (response2.statusCode == 200) {
      final data2 = json.decode(response2.body);
      print('✅ Articles from everything: ${data2['totalResults']}');
      if (data2['articles'] != null && data2['articles'].isNotEmpty) {
        print('📰 First article: ${data2['articles'][0]['title']}');
      }
    } else {
      print('❌ Error 2: ${response2.body}');
    }
  } catch (e) {
    print('🚨 Exception: $e');
  }
}
