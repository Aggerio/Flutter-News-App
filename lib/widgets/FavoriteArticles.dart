import 'package:flutter/material.dart';
import 'package:news_app/logic/database_interaction.dart';
import 'package:news_app/widgets/NewsDisplay.dart';
import 'package:news_app/models/NewsModel.dart';

class FavoriteArticles extends StatefulWidget {
  const FavoriteArticles({super.key});

  @override
  State<FavoriteArticles> createState() => _FavoriteArticles();
}

class _FavoriteArticles extends State<FavoriteArticles> {
  dynamic lst = newsModels();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bookmarked Articles"),
      ),
      body: FutureBuilder<List<NewsModel>>(
        future: lst,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No news bookmarked.'),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                NewsModel news = snapshot.data![index];
                return NewsDisplay(info: news);
              },
            );
          }
        },
      ),
    );
  }
}
