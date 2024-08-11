import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_genesis/core/resources/data_state.dart';
import 'package:flutter_genesis/feature/daily_news/domain/usecases/get_articles.dart';
import 'package:flutter_genesis/feature/daily_news/presentation/bloc/article/remote/remote_article_event.dart';
import 'package:flutter_genesis/feature/daily_news/presentation/bloc/article/remote/remote_article_state.dart';

class RemoteArticlesBloc extends Bloc<RemoteArticlesEvent, RemoteArticleState> {
  final GetArticlesUseCase _getArticleUseCase;

  RemoteArticlesBloc(this._getArticleUseCase)
      : super(const RemoteArticlesLoading()) {
    on<GetArticles>(onGetArticles);
  }

  void onGetArticles(
      GetArticles event, Emitter<RemoteArticleState> emit) async {
    final dataState = await _getArticleUseCase();
    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(RemoteArticleDone(dataState.data!));
    }

    if (dataState is DataFailed) {
      emit(RemoteArticleError(dataState.error!));
    }
  }
}
