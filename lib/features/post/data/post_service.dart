import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dev_nc/model.dart';

class RealApiClient {
  static const baseUrl = 'https://jsonplaceholder.typicode.com/posts';

  Future<List<Post>> getPosts() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;
      return data.map((json) => Post.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }
}

class NewsApiService {
  static const String apiKey = 'YOUR_NEWS_API_KEY'; // Replace with your API key
  static const String baseUrl = 'https://newsapi.org/v2/everything';

  Future<List<News>> fetchNews() async {
    final url = Uri.parse(
      '$baseUrl?q=everything&sortBy=publishedAt&apiKey=$apiKey',
    );
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final articles = data['articles'] as List;
      return articles.map((json) => News.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load news');
    }
  }
}
