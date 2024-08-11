import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_genesis/feature/daily_news/domain/usecases/remove_article.dart';
import 'package:flutter_genesis/feature/daily_news/domain/usecases/get_saved_articles.dart';
import 'package:flutter_genesis/feature/daily_news/domain/usecases/save_article.dart';
import 'package:flutter_genesis/feature/daily_news/presentation/bloc/article/local/local_article_event.dart';
import 'package:flutter_genesis/feature/daily_news/presentation/bloc/article/local/local_article_state.dart';

class LocalArticlesBloc extends Bloc<LocalArticlesEvent, LocalArticleState> {
  final GetSavedArticlesUseCase _getSavedArticlesUseCase;
  final RemoveArticleUseCase _removeArticleUseCase;
  final SaveArticleUseCase _saveArticleUseCase;

  LocalArticlesBloc(this._getSavedArticlesUseCase, this._removeArticleUseCase,
      this._saveArticleUseCase)
      : super(const LocalArticlesLoading()) {
    on<GetSavedArticles>(onGetSavedArticles);
    on<SaveArticle>(onSaveArticle);
    on<RemoveArticle>(onRemoveArticle);
  }

  void onGetSavedArticles(
      GetSavedArticles event, Emitter<LocalArticleState> emit) async {
    final articles = await _getSavedArticlesUseCase();
    emit(LocalArticleDone(articles));
  }

  void onSaveArticle(
      SaveArticle saveArticle, Emitter<LocalArticleState> emit) async {
    await _saveArticleUseCase(params: saveArticle.article);
    final articles = await _getSavedArticlesUseCase();
    emit(LocalArticleDone(articles));
  }

  void onRemoveArticle(
      RemoveArticle removeArticle, Emitter<LocalArticleState> emit) async {
    await _removeArticleUseCase(params: removeArticle.article);
    final articles = await _getSavedArticlesUseCase();
    emit(LocalArticleDone(articles));
  }
}
