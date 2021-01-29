import 'package:bloc_patern_cricket/data/model/api_result_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class ArticleState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ArticleInitialState extends ArticleState {}

class ArticleLoadingState extends ArticleState {
  @override
  String toString() {
    // TODO: implement toString
    return '{ArticleLoadingState : $ArticleLoadingState}';
  }
}

class ArticleLoadedState extends ArticleState {
  List<Articles> articles;

  ArticleLoadedState({@required this.articles});

  @override
  // TODO: implement props
  List<Object> get props => [articles];
}

class ArticleErrorState extends ArticleState {
  String message;

  ArticleErrorState({this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message];
}
