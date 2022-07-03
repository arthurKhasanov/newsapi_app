import 'package:dio/dio.dart';
import 'package:newapi_app/features/models/news_article_model/news_article_model.dart';
import 'package:newapi_app/features/news_list_feature/news_list_interface/news_list_interface.dart';
import 'package:newapi_app/utils/locator.dart';
import 'package:newapi_app/utils/server_util.dart';

class NewsListRepository extends NewsListInterface {
  final _api = locator<ServerUtil>().api;

  NewsListRepository();

  @override
  Future<List<NewsArticle>> getNewsArticles(String? filter) async {
    final Response response;
    if (filter != null && filter.isNotEmpty) {
      response = await _api.get(
          '$filter&language=ru&sortBy=publishedAt&apiKey=8e599788f2a9488d8384f513b1350b38');
    } else {
      response = await _api.get(
          '{q=iOS&language=ru&sortBy=publishedAt&apiKey=8e599788f2a9488d8384f513b1350b38');
    }

    final List<NewsArticle> articles = (response.data['articles'] as List)
        .map((json) => NewsArticle.fromJson(json))
        .toList();
    return articles;
  }


}


// &apiKey=8e599788f2a9488d8384f513b1350b38