
import 'package:newapi_app/features/models/news_article_model/news_article_model.dart';

abstract class NewsListInterface {
  Future<List<NewsArticle>> getNewsArticles(String? filter);
}
