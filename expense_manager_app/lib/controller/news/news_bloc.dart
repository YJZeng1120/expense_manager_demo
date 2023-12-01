import 'package:expense_manager_app/controller/news/news_event.dart';
import 'package:expense_manager_app/controller/news/news_state.dart';
import 'package:expense_manager_app/models/enums/load_status_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/api_news.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsApi _newsApi;
  NewsBloc(this._newsApi) : super(NewsState()) {
    _onEvent();
  }
  void _onEvent() {
    on<FetchNewsListEvent>((event, emit) async {
      emit(
        state.copyWith(
          status: LoadStatus.inProgress,
          errorMessage: '',
        ),
      );
      final failureOption = await _newsApi.fetchNews();
      failureOption.fold(
        (f) => emit(
          state.copyWith(
            status: LoadStatus.failed,
            errorMessage: f,
          ),
        ),
        (allNews) => emit(
          state.copyWith(
            fetchNewsList: allNews,
            status: LoadStatus.succeed,
          ),
        ),
      );
    });
    
    on<FetchNewsDetailEvent>((event, emit) async {
      emit(
        state.copyWith(
          status: LoadStatus.inProgress,
          errorMessage: '',
        ),
      );
      final failureOption = await _newsApi.fetchNewsDetail(event.id);
      failureOption.fold(
        (f) => emit(
          state.copyWith(
            status: LoadStatus.failed,
            errorMessage: f,
          ),
        ),
        (news) => emit(
          state.copyWith(
            fetchNewsDetail: news,
            status: LoadStatus.succeed,
          ),
        ),
      );
    });

    on<ScrollControllerEvent>((event, emit) {
      double position = state.scrollController.offset;
      emit(state.copyWith(savedScrollPosition: position));
    });
  }
}
