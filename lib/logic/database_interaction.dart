import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:news_app/models/NewsModel.dart';

Future<void> insertArticle(NewsModel nm) async {
  final database = openDatabase(
    join(await getDatabasesPath(), 'news_app_database.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE favorites(id TEXT , name TEXT, author TEXT,title TEXT, description TEXT, url TEXT, urlToImage TEXT, publishedAt TEXT, content TEXT)',
      );
    },
    version: 1,
  );
  final db = await database;

  await db.insert(
    'favorites',
    nm.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

Future<List<NewsModel>> getFavoriteNewsModels() async {
  final database = openDatabase(
    join(await getDatabasesPath(), 'news_app_database.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE favorites(id TEXT , name TEXT, author TEXT,title TEXT, description TEXT, url TEXT, urlToImage TEXT, publishedAt TEXT, content TEXT)',
      );
    },
    version: 1,
  );

  final db = await database;

  final List<Map<String, dynamic>> maps = await db.query('favorites');

  return List.generate(maps.length, (i) {
    return NewsModel(
        id: (maps[i]['id'] == null) ? "" : maps[i]['id'] as String,
        name: maps[i]['name'] as String,
        author: maps[i]['author'] as String,
        title: maps[i]['title'],
        description: maps[i]['description'],
        url: maps[i]['url'],
        urlToImage: maps[i]['urlToImage'],
        publishedAt: maps[i]['publishedAt'],
        content: maps[i]['content']);
  });
}

Future<void> removeArticle(NewsModel nm) async {
  final database = openDatabase(
    join(await getDatabasesPath(), 'news_app_database.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE favorites(id TEXT , name TEXT, author TEXT,title TEXT, description TEXT, url TEXT, urlToImage TEXT, publishedAt TEXT, content TEXT)',
      );
    },
    version: 1,
  );

  final db = await database;

  await db.delete(
    'favorites',
    where: "title = ?",
    whereArgs: [nm.title],
  );
}
