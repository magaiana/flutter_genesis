import 'dart:async';

import 'package:floor/floor.dart';
import 'package:flutter_genesis/feature/daily_news/data/models/article.dart';
import 'package:flutter_genesis/feature/daily_news/data/datasources/local/dao/article_dao.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'app_database.g.dart';

@Database(version: 1, entities: [ArticleModel])
abstract class AppDatabase extends FloorDatabase {
  ArticleDao get articleDao;
}
