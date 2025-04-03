import 'package:flutter/material.dart';

import '../models/articles.dart';
import '../widgets/author_date_text.dart';
import '../widgets/link_button.dart';

class ArticleScreen extends StatelessWidget {
  const ArticleScreen({super.key, required this.article});

  final Article article;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Article View'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                article.title!,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black87,
                ),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                article.urlToImage ??
                    'https://static.vecteezy.com/system/resources/thumbnails/021/722/052/small_2x/newspaper-banner-card-with-vintage-style-placeholder-image-for-mockup-or-photo-editing-social-media-editable-text-and-template-vector.jpg',
                fit: BoxFit.cover,
                width: double.infinity,
                height: 250,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text(
                article.description ?? '*no description*',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 13,
                ),
              ),
            ),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: AuthorDateText(article: article),
            ),
            Text(
              'Article Summary',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            Text(
              article.content ?? 'no article preview available',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            Center(
              child: LinkButton(article: article),
            )
          ],
        ),
      ),
    );
  }
}
