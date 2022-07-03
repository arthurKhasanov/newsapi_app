import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newapi_app/features/models/filter_model.dart/filter_model.dart';
import 'package:newapi_app/features/models/news_article_model/news_article_model.dart';
import 'package:newapi_app/features/news_list_feature/news_list_cubit/news_list_state.dart';
import 'package:newapi_app/features/news_list_feature/news_list_interface/news_list_interface.dart';

class NewsListCubit extends Cubit<NewsListState> {
  NewsListCubit(this._newsListRepository) : super(NewsListLoadingState()) {
    getArticles();
  }

  final NewsListInterface _newsListRepository;
  Filter filter = const Filter();
  late List<NewsArticle> articles;
  List<NewsArticle> sortedByTitleArticles = [];
  bool isReversed = false;
  bool searchByTitle = false;
  int currentPage = 1;

  //Получаем все статьи по ключу
  getArticles() async {
    searchByTitle = false;
    emit(NewsListLoadingState());
    try {
      final List<NewsArticle> newArticles =
          await _newsListRepository.getNewsArticles(filterToQuery());
      articles = newArticles;
      if (articles.isNotEmpty) {
        emit(NewsListLoadedState(
            articles: getCurrentArticleList(),
            totalPages: List.generate(countPages(), (int index) => index + 1),
            currentPage: 1));
      } else {
        emit(NewsListEmptyState());
      }
    } catch (e) {
      debugPrint(e.toString());
      emit(NewsListErrorState(message: e.toString()));
    }
  }

  int countPages() {
    if(searchByTitle) {
      var totalPages = (sortedByTitleArticles.length / 4).ceil();
    return totalPages;
    } else {
      var totalPages = (articles.length / 4).ceil();
    return totalPages;
    }
    
  }

  List<NewsArticle> getCurrentArticleList() {
    if (isReversed) {
      articles = articles.reversed.toList();
    }

    int startIndex = (currentPage - 1) * 4;
    int endIndex = (currentPage * 4);
    if (searchByTitle) {
      List<NewsArticle> currentList = sortedByTitleArticles.sublist(
          startIndex,
          endIndex <= sortedByTitleArticles.length
              ? endIndex
              : sortedByTitleArticles.length);
      return currentList;
    } else {
      List<NewsArticle> currentList = articles.sublist(
          startIndex, endIndex <= articles.length ? endIndex : articles.length);
      return currentList;
    }
  }

  addFilter(Filter newFilter) {
    filter = newFilter;
    currentPage = 1;
    getArticles();
  }

  changeOrder() {
    isReversed = !isReversed;
  }

  //Превращаем фильтр в запрос
  String filterToQuery() {
    List<String> res = [];
    if (filter.search != null && filter.search!.isNotEmpty) {
      final request = 'q=${filter.search}';
      res.add(request);
    } else {
      const request = 'q=iOS';
      res.add(request);
    }
    if (filter.from != null) {
      final request = '&from=${filter.from}';
      res.add(request);
    }
    if (filter.to != null) {
      final request = '&to=${filter.to}';
      res.add(request);
    }
    return res.join();
  }

  findArticlesByTitle(String title) {
    sortedByTitleArticles = [];
    for (var article in articles) {
      if (article.title != null && article.title!.contains(title)) {
        sortedByTitleArticles.add(article);
      }
    }
    if (sortedByTitleArticles.isNotEmpty) {
      emit(NewsListLoadingState());
      emit(NewsListLoadedState(
          articles: getCurrentArticleList(),
          totalPages: List.generate(countPages(), (int index) => index + 1),
          currentPage: 1));
    } else {
      emit(NewsListEmptyState());
    }
  }

  choosePage(int page) {
    currentPage = page;
    emit(NewsListLoadedState(
      articles: getCurrentArticleList(),
      totalPages: List.generate(countPages(), (int index) => index + 1),
      currentPage: page,
    ));
  }
}
