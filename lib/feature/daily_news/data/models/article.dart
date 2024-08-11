import 'package:floor/floor.dart';
import 'package:flutter_genesis/core/constants/constants.dart';
import 'package:flutter_genesis/feature/daily_news/domain/entities/article.dart';

@Entity(tableName: 'article', primaryKeys: ['id'])
class ArticleModel extends ArticleEntity {
  const ArticleModel(
      {super.id,
      super.author,
      super.title,
      super.description,
      super.url,
      super.urlToImage,
      super.publishedAt,
      super.content});

  factory ArticleModel.fromJson(Map<String, dynamic> map) {
    return ArticleModel(
      author: map["author"] ?? "",
      title: map["title"] ?? "",
      description: map["description"] ?? "",
      url: map["url"] ?? "",
      urlToImage: (map["urlToImage"] == null || map["urlToImage"] == "")
          ? defaultImage
          : map["urlToImage"],
      publishedAt: map["publishedAt"] ?? "",
      content: map["content"] ?? "",
    );
  }

  factory ArticleModel.fromEntity(ArticleEntity entity) {
    return ArticleModel(
      author: entity.author,
      title: entity.title,
      description: entity.description,
      url: entity.url,
      urlToImage: entity.urlToImage,
      publishedAt: entity.publishedAt,
      content: entity.content,
    );
  }
}
