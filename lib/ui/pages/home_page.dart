import 'package:bloc_patern_cricket/bloc/article/article_bloc.dart';
import 'package:bloc_patern_cricket/bloc/article/article_event.dart';
import 'package:bloc_patern_cricket/bloc/article/article_state.dart';
import 'package:bloc_patern_cricket/data/model/api_result_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'about_page.dart';
import 'article_detail_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ArticleBloc articleBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    articleBloc = BlocProvider.of(context);
    articleBloc.add(FetchArticleEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cricket"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () => articleBloc.add(FetchArticleEvent()),
          ),
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () => navigateToAutPage(context),
          )
        ],
      ),
      body: Container(
        child: BlocListener<ArticleBloc, ArticleState>(
          listener: (context, state) {
            if (state is ArticleErrorState) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          child: BlocBuilder<ArticleBloc, ArticleState>(
            builder: (context, state) {
              if (state is ArticleInitialState) {
                return buildLoading();
              } else if (state is ArticleLoadingState) {
                return buildLoading();
              } else if (state is ArticleLoadedState) {
                return buildArticleList(state.articles);
              } else if (state is ArticleErrorState) {
                return buildErrorUi(state.message);
              }
              return SizedBox(
                height: 0,
              );
            },
          ),
        ),
      ),
    );
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildArticleList(List<Articles> articles) {
    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.all(8),
          child: InkWell(
            child: ListTile(
              leading: ClipOval(
                child: Hero(
                  tag: articles[index].urlToImage,
                  child: Image.network(
                    articles[index].urlToImage,
                    fit: BoxFit.cover,
                    height: 70,
                    width: 70,
                  ),
                ),
              ),
              title: Text(articles[index].title),
              subtitle: Text(articles[index].publishedAt),
            ),
            onTap: () => navigateToArticleDetailPage(context, articles[index]),
          ),
        );
      },
    );
  }

  navigateToAutPage(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AboutPage(),
        ));
  }

  navigateToArticleDetailPage(BuildContext context, Articles article) {
    return Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ArticleDetailPage(articles: article),
        ));
  }

  Widget buildErrorUi(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          message,
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }
}
