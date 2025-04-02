import 'package:news_app/models/articles.dart';

class NewsResponse {
  String? status;
  int? totalResults;
  List<Article>? articles;

  NewsResponse({this.status, this.totalResults, this.articles});

  NewsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    totalResults = json['totalResults'];
    if (json['articles'] != null) {
      articles = <Article>[];
      json['articles'].forEach((v) {
        articles!.add(Article.fromJson(v));
      });
    }
  }
}
