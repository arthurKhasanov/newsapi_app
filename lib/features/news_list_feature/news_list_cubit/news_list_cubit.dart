import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newapi_app/features/models/filter_model.dart/filter_model.dart';
import 'package:newapi_app/features/models/news_article_model/news_article_model.dart';
import 'package:newapi_app/features/news_list_feature/news_list_cubit/news_list_state.dart';
import 'package:newapi_app/features/news_list_feature/news_list_interface/news_list_interface.dart';

class NewsListCubit extends Cubit<NewsListState> {
  NewsListCubit(this._newsListRepository) : super(NewsListLoadingState()) {
    init();
  }

  final NewsListInterface _newsListRepository;
  Filter filter = const Filter();
  bool isReversed = false;

  init() async {
    emit(NewsListLoadingState());
    try {
      final List<NewsArticle> articles =
          await _newsListRepository.getNewsArticles(filterToQuery());
      if (articles.isNotEmpty) {
        if(isReversed) {
          emit(NewsListLoadedState(articles: articles.reversed.toList()));
        } else {
          emit(NewsListLoadedState(articles: articles));
        }
        
      } else {
        emit(NewsListEmptyState());
      }
    } catch (e) {
      debugPrint(e.toString());
      emit(NewsListErrorState(message: e.toString()));
    }
  }

  addFilter(String field, String filterPart) {
    if (field == 'from') {
      filter = filter.copyWith(from: filterPart);
    } else if (field == 'to') {
      filter = filter.copyWith(to: filterPart);
    } else if (field == 'search') {
      filter = filter.copyWith(search: filterPart);
    }
    init();
  }

  changeOrder() {
    isReversed = !isReversed;
    init();
  }

  String filterToQuery() {
    List<String> res = [];
    if (filter.search != null && filter.search!.isNotEmpty) {
      final request = 'qInTitle=${filter.search}';
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
}
