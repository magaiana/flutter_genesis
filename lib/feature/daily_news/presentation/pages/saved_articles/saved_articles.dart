import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_genesis/dependency_injection.dart';
import 'package:flutter_genesis/feature/daily_news/domain/entities/article.dart';
import 'package:flutter_genesis/feature/daily_news/presentation/bloc/article/local/local_article_block.dart';
import 'package:flutter_genesis/feature/daily_news/presentation/bloc/article/local/local_article_event.dart';
import 'package:flutter_genesis/feature/daily_news/presentation/bloc/article/local/local_article_state.dart';
import 'package:flutter_genesis/feature/daily_news/presentation/widget/articles_widget.dart';

class SavedArticles extends StatelessWidget {
  const SavedArticles({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          services<LocalArticlesBloc>()..add(const GetSavedArticles()),
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      leading: Builder(
          builder: (context) => GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => _onBackButtonTapped(context),
                child: const Icon(
                  Icons.chevron_left,
                  color: Colors.black,
                ),
              )),
      title: const Text(
        'Saves Articles',
        style: TextStyle(color: Colors.black),
      ),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<LocalArticlesBloc, LocalArticleState>(
        builder: (context, state) {
      if (state is LocalArticlesLoading) {
        return const Center(child: CupertinoActivityIndicator());
      }

      if (state is LocalArticleDone) {
        return _buildArticlesList(state.articles!);
      }

      return Container();
    });
  }

  Widget _buildArticlesList(List<ArticleEntity> articles) {
    if (articles.isEmpty) {
      return const Center(
          child: Text(
        'Nothing saved yet',
        style: TextStyle(color: Colors.black),
      ));
    }

    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (context, index) {
        return ArticlesWidget(
          article: articles[index],
          isRemovable: true,
          onRemove: (article) => _onRemoveArticledPressed(context, article),
          onArticlePressed: (article) => _onArticlePressed(context, article),
        );
      },
    );
  }

  void _onBackButtonTapped(BuildContext context) {
    Navigator.pop(context);
  }

  void _onRemoveArticledPressed(BuildContext context, article) {
    BlocProvider.of<LocalArticlesBloc>(context).add(RemoveArticle(article));
  }

  void _onArticlePressed(BuildContext context, ArticleEntity article) {
    Navigator.of(context).pushNamed('/ArticleDetails', arguments: article);
  }
}
