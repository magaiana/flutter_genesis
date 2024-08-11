import 'package:dio/dio.dart';
import 'package:flutter_genesis/feature/daily_news/domain/usecases/remove_article.dart';
import 'package:flutter_genesis/feature/daily_news/domain/usecases/get_saved_articles.dart';
import 'package:flutter_genesis/feature/daily_news/domain/usecases/save_article.dart';
import 'package:flutter_genesis/feature/daily_news/presentation/bloc/article/local/local_article_block.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_genesis/feature/daily_news/data/datasources/local/dao/app_database.dart';
import 'package:flutter_genesis/feature/daily_news/data/datasources/remote/news_api_service.dart';
import 'package:flutter_genesis/feature/daily_news/data/repositories/article_repository_impl.dart';
import 'package:flutter_genesis/feature/daily_news/domain/repositories/article_repository.dart';
import 'package:flutter_genesis/feature/daily_news/domain/usecases/get_articles.dart';
import 'package:flutter_genesis/feature/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';

final services = GetIt.instance;
Future<void> initializeDependencies() async {
  //Dio
  services.registerSingleton<Dio>(Dio());

  //Init DB
  final database =
      await $FloorAppDatabase.databaseBuilder('newslet_database.db').build();
  services.registerSingleton<AppDatabase>(database);

  //Dependencies
  services.registerSingleton<NewsApiService>(NewsApiService(services()));
  services.registerSingleton<ArticleRepository>(
      ArticleRepositoryImpl(services(), services()));

  //UserCases
  services
      .registerSingleton<GetArticlesUseCase>(GetArticlesUseCase(services()));
  services.registerSingleton<GetSavedArticlesUseCase>(
      GetSavedArticlesUseCase(services()));
  services
      .registerSingleton<SaveArticleUseCase>(SaveArticleUseCase(services()));
  services.registerSingleton<RemoveArticleUseCase>(
      RemoveArticleUseCase(services()));

  //Blocs
  services.registerFactory<RemoteArticlesBloc>(
      () => RemoteArticlesBloc(services()));

  services.registerFactory<LocalArticlesBloc>(
      () => LocalArticlesBloc(services(), services(), services()));
}
