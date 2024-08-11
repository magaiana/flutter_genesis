import 'package:flutter_genesis/core/resources/data_state.dart';
import 'package:flutter_genesis/core/usecases/usecase.dart';
import 'package:flutter_genesis/feature/daily_news/domain/entities/article.dart';
import 'package:flutter_genesis/feature/daily_news/domain/repositories/article_repository.dart';

class GetArticlesUseCase
    implements UseCase<DataState<List<ArticleEntity>>, void> {
  final ArticleRepository _articleRepository;
  GetArticlesUseCase(this._articleRepository);

  @override
  Future<DataState<List<ArticleEntity>>> call({void params}) {
    return _articleRepository.getNewsArticles();
  }
}
