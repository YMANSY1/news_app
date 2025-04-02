import 'package:flutter/material.dart';
import 'package:news_app/models/articles.dart';
import 'package:news_app/widgets/news_tile.dart';

class NewsTileListView extends StatelessWidget {
  final List<Article> articles;

  const NewsTileListView({
    super.key,
    required this.articles,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList.separated(
      itemCount: articles.length,
      itemBuilder: (context, index) => NewsTile(
        article: articles[index],
      ),
      separatorBuilder: (BuildContext context, int index) =>
          SizedBox(height: 8),
    );
  }
}
