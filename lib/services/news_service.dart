import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:news_app/models/articles.dart';
import 'package:news_app/models/news_response.dart';

class NewsService {
  final Dio dio;
  final String? _apiKey;

  NewsService({required this.dio})
      : _apiKey = dotenv.env['NEWS_API_KEY'] ?? '' {
    if (_apiKey!.isEmpty) throw Exception('API Key missing');
  }

  Future<List<Article>> getNews({required String category}) async {
    final response = await dio.get(
      'https://newsapi.org/v2/top-headlines',
      queryParameters: {
        'country': 'us',
        'category': category,
        'apiKey': _apiKey,
      },
    );
    Map<String, dynamic> data = response.data;
    final newsResponse = NewsResponse.fromJson(data);
    print(newsResponse.articles?[0].content);
    return newsResponse.articles ?? <Article>[];
  }
}
