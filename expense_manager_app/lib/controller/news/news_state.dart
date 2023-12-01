import 'package:expense_manager_app/models/enums/load_status_enum.dart';
import 'package:expense_manager_app/models/news.dart';
import 'package:flutter/material.dart';

class NewsState {
  final List<News> fetchNewsList;
  final News fetchNewsDetail;
  final LoadStatus status;
  final String errorMessage;
  final double savedScrollPosition;
  final ScrollController scrollController;

  NewsState({
    this.fetchNewsList = const <News>[],
    News? fetchNewsDetail,
    this.status = LoadStatus.initial,
    this.errorMessage = '',
    this.savedScrollPosition = 0.0,
    ScrollController? scrollController,
  })  : fetchNewsDetail = fetchNewsDetail ??
            News(
              id: '',
              reporter: '',
              title: '',
              content: '',
              date: DateTime.now(),
            ),
        scrollController = scrollController ?? ScrollController();

  NewsState copyWith({
    List<News>? fetchNewsList,
    News? fetchNewsDetail,
    String? newsId,
    LoadStatus? status,
    String? errorMessage,
    double? savedScrollPosition,
    ScrollController? scrollController,
  }) {
    return NewsState(
      fetchNewsList: fetchNewsList ?? this.fetchNewsList,
      fetchNewsDetail: fetchNewsDetail ?? this.fetchNewsDetail,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      savedScrollPosition: savedScrollPosition ?? this.savedScrollPosition,
      scrollController: scrollController ?? this.scrollController,
    );
  }
}
