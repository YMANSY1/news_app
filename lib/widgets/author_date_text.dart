import 'package:flutter/material.dart';

import '../models/articles.dart';

class AuthorDateText extends StatelessWidget {
  const AuthorDateText({
    super.key,
    required this.article,
  });

  final Article article;

  @override
  Widget build(BuildContext context) {
    return Text(
      'By ${article.author == null || article.author!.isEmpty ? 'an unknown author' : article.author}\n${article.formatDate()}',
      style: TextStyle(
        fontSize: 14,
        color: Colors.black54,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
