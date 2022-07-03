import 'package:equatable/equatable.dart';
import 'package:newapi_app/features/models/news_article_model/news_article_model.dart';

abstract class NewsListState extends Equatable {}

class NewsListLoadingState extends NewsListState {
  @override
  List<Object?> get props => [];
}

class NewsListLoadedState extends NewsListState {
  NewsListLoadedState({
    required this.articles,
    required this.totalPages,
    required this.currentPage,
  });

  final List<NewsArticle> articles;
  final List<int> totalPages;
  final int currentPage;

  @override
  List<Object?> get props => [articles];
}

class NewsListEmptyState extends NewsListState {
  @override
  List<Object?> get props => [];
}

class NewsListErrorState extends NewsListState {
  NewsListErrorState({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}
