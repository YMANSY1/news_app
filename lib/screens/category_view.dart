import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news_app/services/news_service.dart';

import '../models/articles.dart';
import '../widgets/news_tile_list_view.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({super.key, required this.category});

  final String category;

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  late Future<List<Article>> future;

  @override
  void initState() {
    super.initState();
    future = NewsService(dio: Dio()).getNews(category: widget.category);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('${widget.category} News')),
      ),
      body: FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CustomScrollView(
              slivers: [
                snapshot.hasData
                    ? NewsTileListView(
                        articles: snapshot.data!,
                      )
                    : snapshot.hasError
                        ? SliverFillRemaining(
                            child: Center(
                              child: Text('Oops, something went wrong.'),
                            ),
                          )
                        : SliverFillRemaining(
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
              ],
            ),
          );
        },
      ),
    );
  }
}
