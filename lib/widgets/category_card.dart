import 'package:flutter/material.dart';
import 'package:news_app/screens/category_view.dart';

import '../models/news_category.dart';

class CategoryCard extends StatelessWidget {
  final NewsCategory category;

  const CategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => CategoryView(
            category: category.name,
          ),
        ),
      ),
      child: Container(
        width: 200,
        height: 120,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: category.image,
            fit: BoxFit.fill,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
            child: Text(
          category.name,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        )),
      ),
    );
  }
}
