import 'package:flutter/material.dart';
import 'package:flutter_genesis/feature/daily_news/domain/entities/article.dart';
import 'package:flutter_genesis/feature/daily_news/presentation/pages/details/article_details.dart';
import 'package:flutter_genesis/feature/daily_news/presentation/pages/home/daily_news_dashboard.dart';
import 'package:flutter_genesis/feature/daily_news/presentation/pages/saved_articles/saved_articles.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _materialRoutes(const DailyNewsDashboard());

      case '/ArticleDetails':
        return _materialRoutes(
            ArticleDetailsView(article: settings.arguments as ArticleEntity));

      case '/SavedArticles':
        return _materialRoutes(const SavedArticles());

      default:
        return _materialRoutes(const DailyNewsDashboard());
    }
  }

  static Route<dynamic> _materialRoutes(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
