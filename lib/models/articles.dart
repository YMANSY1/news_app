import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/models/sources.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

class Article {
  Source? source;
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? publishedAt;
  String? content;

  Article(
      {this.source,
      this.author,
      this.title,
      this.description,
      this.url,
      this.urlToImage,
      this.publishedAt,
      this.content});

  Article.fromJson(Map<String, dynamic> json) {
    source = json['source'] != null ? Source.fromJson(json['source']) : null;
    author = json['author'];
    title = json['title'];
    description = json['description'];
    url = json['url'];
    urlToImage = json['urlToImage'];
    publishedAt = json['publishedAt'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (source != null) {
      data['source'] = source!.toJson();
    }
    data['author'] = author;
    data['title'] = title;
    data['description'] = description;
    data['url'] = url;
    data['urlToImage'] = urlToImage;
    data['publishedAt'] = publishedAt;
    data['content'] = content;
    return data;
  }
}

extension ArticleExtensions on Article {
  Future<void> launchUrl(BuildContext context) async {
    if (url == null || url!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('The article does not have a valid URL.'),
        ),
      );
      return;
    }
    final uri = Uri.tryParse(url!);
    if (uri == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Invalid URL format. Please try another article.'),
        ),
      );
      return;
    }

    try {
      await launcher.launchUrl(uri);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'An error occurred while trying to open the URL. Please try again.'),
        ),
      );
      print(e);
    }
  }

  String formatDate() {
    if (publishedAt == null || publishedAt!.isEmpty) return 'Date Unknown';
    DateTime parsedDate = DateTime.parse(publishedAt!);
    return DateFormat('MMMM dd, yyyy hh:mm a').format(parsedDate);
  }
}
