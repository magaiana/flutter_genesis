import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:flutter_genesis/core/constants/constants.dart';
import 'package:flutter_genesis/feature/daily_news/data/models/article.dart';
part 'news_api_service.g.dart';

@RestApi(baseUrl: newAPIBaseUrl)
abstract class NewsApiService {
  factory NewsApiService(Dio dio) = _NewsApiService;

  @GET('/top-headlines')
  Future<HttpResponse<List<ArticleModel>>> getNewsArticles({
    @Query('apiKey') String? apiKey,
    @Query('country') String? country,
    @Query('category') String? category,
  });
}
