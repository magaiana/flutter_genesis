import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_genesis/core/constants/constants.dart';
import 'package:flutter_genesis/core/resources/data_state.dart';
import 'package:flutter_genesis/feature/daily_news/data/datasources/local/dao/app_database.dart';
import 'package:flutter_genesis/feature/daily_news/data/models/article.dart';
import 'package:flutter_genesis/feature/daily_news/domain/entities/article.dart';
import 'package:flutter_genesis/feature/daily_news/domain/repositories/article_repository.dart';
import 'package:flutter_genesis/feature/daily_news/data/datasources/remote/news_api_service.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final NewsApiService _newsApiService;
  final AppDatabase _database;
  ArticleRepositoryImpl(this._newsApiService, this._database);

  @override
  Future<DataState<List<ArticleEntity>>> getNewsArticles() async {
    try {
      final httpResponse = await _newsApiService.getNewsArticles(
          apiKey: apiKey, country: country, category: category);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions));
      }
    } on DioException catch (exception) {
      return DataFailed(exception);
    }
  }

  @override
  Future<List<ArticleModel>> getSavedArticles() async {
    return await _database.articleDao.getArticles();
  }

  @override
  Future removeArticle(ArticleEntity article) async {
    await _database.articleDao.removeArticle(ArticleModel.fromEntity(article));
  }

  @override
  Future saveArticle(ArticleEntity article) async {
    await _database.articleDao.insertArticle(ArticleModel.fromEntity(article));
  }
}
