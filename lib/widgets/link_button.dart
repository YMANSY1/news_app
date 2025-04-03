import 'package:flutter/material.dart';

import '../models/articles.dart';

class LinkButton extends StatelessWidget {
  const LinkButton({
    super.key,
    required this.article,
  });

  final Article article;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        await article.launchUrl(context);
      },
      child: Text(
        'Open Article Link',
        style: TextStyle(
          color: Colors.blueAccent,
          decoration: TextDecoration.underline,
          decorationColor: Colors.blueAccent,
        ),
      ),
    );
  }
}
