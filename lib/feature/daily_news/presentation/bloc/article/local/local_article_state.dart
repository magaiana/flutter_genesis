import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_genesis/feature/daily_news/domain/entities/article.dart';

abstract class LocalArticleState extends Equatable {
  final List<ArticleEntity>? articles;
  final DioException? error;

  const LocalArticleState({this.articles, this.error});

  @override
  List<Object> get props => [articles!, error!];
}

class LocalArticlesLoading extends LocalArticleState {
  const LocalArticlesLoading();
}

class LocalArticleDone extends LocalArticleState {
  const LocalArticleDone(List<ArticleEntity> articles)
      : super(articles: articles);
}

class LocalArticleError extends LocalArticleState {
  const LocalArticleError(DioException error) : super(error: error);
}
