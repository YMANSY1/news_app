import 'package:flutter/material.dart';

import '../models/news_category.dart';
import 'category_card.dart';

class CategoryListView extends StatelessWidget {
  const CategoryListView({
    super.key,
    required this.categories,
  });

  final List<NewsCategory> categories;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.separated(
        // physics: BouncingScrollPhysics(),
        itemCount: categories.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          final category = categories[index];
          return CategoryCard(
            category: category,
          );
        },
        separatorBuilder: (BuildContext context, int index) =>
            SizedBox(width: 16),
      ),
    );
  }
}
