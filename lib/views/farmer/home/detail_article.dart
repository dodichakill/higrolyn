import 'package:agrolyn/providers/article_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailArticle extends StatelessWidget {
  final Map<String, dynamic> article;
  const DetailArticle({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => ArticleNotifier(context: context),
        child: Consumer<ArticleNotifier>(
          builder: (context, value, child) => Scaffold(
            appBar: AppBar(
              title: Text(article['title']),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    article['thumbnail'] != null &&
                            article['thumbnail'].isNotEmpty
                        ? Image.network(
                            article['thumbnail'],
                            height: 234,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          )
                        : const Text("No image available"),
                    const SizedBox(height: 16),
                    Text(
                      "${article['location']}",
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "${article['released_date']}",
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      article['title'],
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      article['description'],
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
