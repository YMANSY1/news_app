import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news_app/models/news_category.dart';
import 'package:news_app/services/news_service.dart';
import 'package:news_app/widgets/news_tile_list_view.dart';

import '../models/articles.dart';
import '../widgets/category_list_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final categories = <NewsCategory>[
    NewsCategory('Business', const AssetImage('assets/business.jpg')),
    NewsCategory('Entertainment', const AssetImage('assets/entertaiment.jpg')),
    NewsCategory('General', const AssetImage('assets/general.jpg')),
    NewsCategory('Health', const AssetImage('assets/health.jpg')),
    NewsCategory('Science', const AssetImage('assets/science.jpg')),
    NewsCategory('Sports', const AssetImage('assets/sports.jpg')),
    NewsCategory('Technology', const AssetImage('assets/technology.jpeg')),
  ];

  late Future<List<Article>> future;
  String query = '';
  List<Article> filteredArticles = [];
  List<Article> allArticles = [];

  @override
  void initState() {
    super.initState();
    future = NewsService(dio: Dio()).getNews(category: 'general');
  }

  void updateSearch(String value) {
    setState(() {
      query = value;
      if (allArticles.isNotEmpty) {
        filteredArticles = allArticles
            .where((article) =>
                (article.title?.toLowerCase().contains(query.toLowerCase()) ??
                    false) ||
                (article.description
                        ?.toLowerCase()
                        .contains(query.toLowerCase()) ??
                    false))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: RichText(
            text: const TextSpan(
              text: 'News',
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
              ),
              children: [
                TextSpan(
                  text: 'Portal',
                  style: TextStyle(
                    color: Colors.pinkAccent,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: CategoryListView(categories: categories),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 16)),
            // Search Bar
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextField(
                  onChanged: updateSearch,
                  decoration: InputDecoration(
                    hintText: 'Search articles...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 8)),
            FutureBuilder<List<Article>>(
              future: future,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return const SliverFillRemaining(
                    child: Center(
                      child: Text('Oops, something went wrong.'),
                    ),
                  );
                } else if (snapshot.hasData) {
                  if (allArticles.isEmpty) {
                    allArticles = snapshot.data!;
                    if (query.isEmpty) {
                      filteredArticles = allArticles;
                    } else {
                      updateSearch(query);
                    }
                  }
                  return NewsTileListView(
                      articles:
                          query.isEmpty ? snapshot.data! : filteredArticles);
                } else {
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: Text('No articles found.'),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
