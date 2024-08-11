import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_genesis/config/routes/routes.dart';
import 'package:flutter_genesis/config/theme/app_theme.dart';
import 'package:flutter_genesis/dependency_injection.dart';
import 'package:flutter_genesis/feature/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:flutter_genesis/feature/daily_news/presentation/bloc/article/remote/remote_article_event.dart';
import 'package:flutter_genesis/feature/daily_news/presentation/pages/home/daily_news_dashboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<RemoteArticlesBloc>(
          create: (BuildContext context) =>
              services()..add(const GetArticles())),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme(),
      onGenerateRoute: AppRoutes.onGenerateRoutes,
      home: const DailyNewsDashboard(),
    );
  }
}
