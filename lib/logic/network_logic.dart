import 'package:news_app/models/NewsModel.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/constants.dart';
import 'dart:convert';

Future<List<NewsModel>> getNewsArticles(
    String category, String country_code) async {
  List<NewsModel> models = [];
  try {
    //top_headlines_api = "<BASE_URL>/top-headlines/category/<category>/<country_code>.json"
    var url = Uri.parse(
        '$BASE_URL/top-headlines/category/$category/$country_code.json');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      int i = 2;
      while (i < data['totalResults']) {
        //print("-------------------- LOG --------------------");
        //print("TESTING!!!");
        //print(i);
        //print(current_article['source']['name']);
        //print(current_article['author']);
        //print(current_article['title']);
        //print(current_article['description']);
        //print(current_article['url']);
        //print(current_article['urlToImage']);
        //print(current_article['publishedAt']);
        //print(current_article['content']);
        //print("-------------------- LOG --------------------");
        models.add(
          NewsModel(
            name: data['articles'][i]['source']['name'] ?? "",
            author: data['articles'][i]['author'] ?? "",
            title: data['articles'][i]['title'] ?? "",
            description: data['articles'][i]['description'] ?? "",
            url: data['articles'][i]['url'] ?? "",
            urlToImage: data['articles'][i]['urlToImage'] ?? "",
            publishedAt: data['articles'][i]['publishedAt'] ?? "",
            content: data['articles'][i]['content'] ?? "",
          ),
        );
        i += 1;
      }
    }
  } catch (e) {
    print(e.toString());
    // Rethrow the exception so that it can be caught by the caller
    throw e;
  }
  return models;
}
