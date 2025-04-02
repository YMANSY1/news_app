import 'package:flutter/material.dart';
import 'package:news_app/models/articles.dart';

class NewsTile extends StatelessWidget {
  final Article article;

  const NewsTile({
    super.key,
    required this.article,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            article.urlToImage ??
                'https://static.vecteezy.com/system/resources/thumbnails/021/722/052/small_2x/newspaper-banner-card-with-vintage-style-placeholder-image-for-mockup-or-photo-editing-social-media-editable-text-and-template-vector.jpg',
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(height: 12),
        Text(
          article.title ?? 'Title not found...',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8),
        Text(
          article.description ?? '*no description*',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
        )
      ],
    );
  }
}
