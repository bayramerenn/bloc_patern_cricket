import 'package:bloc_patern_cricket/bloc/article/article_bloc.dart';
import 'package:bloc_patern_cricket/data/repository/article_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'ui/pages/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cricket',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
          create: (context) => ArticleBloc(repository: ArticleRepositoryImpl()),
          child: HomePage()),
    );
  }
}
