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
  String query = '';
  List<Article> filteredArticles = [];
  List<Article> allArticles = [];

  @override
  void initState() {
    super.initState();
    future = NewsService(dio: Dio()).getNews(category: widget.category);
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
        title: Center(child: Text('${widget.category} News')),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: CustomScrollView(
          slivers: [
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
            // News List
            FutureBuilder<List<Article>>(
              future: future,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SliverFillRemaining(
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
                  // Store all articles for filtering
                  if (allArticles.isEmpty) {
                    allArticles = snapshot.data!;
                    if (query.isEmpty) {
                      filteredArticles = allArticles;
                    }
                  }

                  return NewsTileListView(
                      articles:
                          query.isEmpty ? snapshot.data! : filteredArticles);
                } else {
                  return const SliverFillRemaining(
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
