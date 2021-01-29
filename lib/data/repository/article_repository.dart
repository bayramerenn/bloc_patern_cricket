import 'dart:convert';

import 'package:bloc_patern_cricket/data/model/api_result_model.dart';
import 'package:bloc_patern_cricket/res/strings/strings.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

abstract class ArticleRepository {
  Future<List<Articles>> gerArticles();
}

class ArticleRepositoryImpl implements ArticleRepository {
  @override
  Future<List<Articles>> gerArticles() async {
    Response response = await http.get(AppStrings.cricArticleUrl);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var articles = ApiResultModel.fromJson(data).articles;
      return articles;
    } else {
      throw Exception();
    }
  }
}
