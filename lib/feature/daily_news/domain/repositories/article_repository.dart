import 'package:flutter_genesis/core/resources/data_state.dart';
import 'package:flutter_genesis/feature/daily_news/data/models/article.dart';
import 'package:flutter_genesis/feature/daily_news/domain/entities/article.dart';

abstract class ArticleRepository {
  Future<DataState<List<ArticleEntity>>> getNewsArticles();
  Future<List<ArticleModel>> getSavedArticles();
  Future saveArticle(ArticleEntity article);
  Future removeArticle(ArticleEntity article);
}
