import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news_app/models/news_category.dart';
import 'package:news_app/services/news_service.dart';

import '../models/articles.dart';
import '../widgets/category_list_view.dart';
import '../widgets/news_tile_list_view.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final categories = <NewsCategory>[
    NewsCategory('Business', AssetImage('assets/business.jpg')),
    NewsCategory('Entertainment', AssetImage('assets/entertaiment.jpg')),
    NewsCategory('General', AssetImage('assets/general.jpg')),
    NewsCategory('Health', AssetImage('assets/health.jpg')),
    NewsCategory('Science', AssetImage('assets/science.jpg')),
    NewsCategory('Sports', AssetImage('assets/sports.jpg')),
    NewsCategory('Technology', AssetImage('assets/technology.jpeg')),
  ];

  var isLoading = true;
  late Future<List<Article>> future;

  @override
  void initState() {
    super.initState();
    future = NewsService(dio: Dio()).getNews(category: 'general');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'News',
                style: TextStyle(color: Colors.black),
              ),
              Text(
                'Cloud',
                style: TextStyle(color: Colors.orange),
              ),
            ],
          ),
        ),
      ),
      body: FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                    child: CategoryListView(categories: categories)),
                SliverToBoxAdapter(child: SizedBox(height: 32)),
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
