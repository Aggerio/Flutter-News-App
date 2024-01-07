import 'package:flutter/material.dart';

/*
Class to model the API return state

{
    "source": {
        "id": null,
        "name": "Livemint"
    },
    "author": "Livemint",
    "title": "Long Covid More Severe In Women Than Men, Suggests Study - Mint",
    "description": "The study found that 91% of patients, who were followed up for five months on average, continued to experience Covid-19 symptoms. Breathlessness was the most common symptom of long Covid-19, followed by fatigue",
    "url": "https://www.livemint.com/news/india/long-covid-more-severe-in-women-than-men-suggests-study-11650538683775.html",
    "urlToImage": "https://images.livemint.com/img/2022/04/21/600x338/long_covid_symptoms_1650540839356_1650540839488.jpg",
    "publishedAt": "2022-04-21T11:37:19Z",
    "content": "Post-coronavirus complications, also called long Covid syndrome, induce more symptoms in women than men, a new study has found. \r\nThe new research, published in the Journal of Women's Health, reveale… [+2402 chars]"
},
*/

class NewsModel with ChangeNotifier {
  String? id;
  String name;
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  String publishedAt;
  String content;

  NewsModel({
    this.id,
    required this.name,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });
  Map<String, dynamic> toMap() {
    return {
      'id': (id == null) ? "defaultId" : id,
      'name': name,
      'author': author,
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt,
      'content': content
    };
  }
}
