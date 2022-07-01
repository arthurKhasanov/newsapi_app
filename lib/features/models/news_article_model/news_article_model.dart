import 'package:freezed_annotation/freezed_annotation.dart';

part 'news_article_model.freezed.dart';
part 'news_article_model.g.dart';

@freezed
class NewsArticle with _$NewsArticle {
  const factory NewsArticle({
    required final String? author,
    required final String? title,
    required final String? description,
    required final String? url,
    required final String? urlToImage,
    required final DateTime? publishedAt,
    required final String? content,
  })= _NewsArticle;

  factory NewsArticle.fromJson(Map<String, dynamic> json) =>
      _$NewsArticleFromJson(json);
}