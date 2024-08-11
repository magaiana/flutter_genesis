import 'package:flutter_genesis/core/usecases/usecase.dart';
import 'package:flutter_genesis/feature/daily_news/domain/entities/article.dart';
import 'package:flutter_genesis/feature/daily_news/domain/repositories/article_repository.dart';

class SaveArticleUseCase implements UseCase<void, ArticleEntity> {
  final ArticleRepository _articleRepository;
  SaveArticleUseCase(this._articleRepository);

  @override
  Future<void> call({ArticleEntity? params}) {
    return _articleRepository.saveArticle(params!);
  }
}
