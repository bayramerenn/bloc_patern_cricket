import 'package:bloc_patern_cricket/bloc/article/article_event.dart';
import 'package:bloc_patern_cricket/bloc/article/article_state.dart';
import 'package:bloc_patern_cricket/data/model/api_result_model.dart';
import 'package:bloc_patern_cricket/data/repository/article_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  ArticleRepository repository;
  ArticleBloc({@required this.repository}) : super(ArticleInitialState());

  @override
  void onTransition(Transition<ArticleEvent, ArticleState> transition) {
    print(transition);
    super.onTransition(transition);
  }

  @override
  Stream<ArticleState> mapEventToState(ArticleEvent event) async* {
    if (event is FetchArticleEvent) {
      yield ArticleLoadingState();
      try {
        List<Articles> articles = await repository.gerArticles();
        yield ArticleLoadedState(articles: articles);
      } catch (e) {
        yield ArticleErrorState(message: e.toString());
      }
    }
  }
}
