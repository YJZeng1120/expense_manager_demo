import 'package:expense_manager_app/models/enums/load_status_enum.dart';
import 'package:expense_manager_app/models/news.dart';
import 'package:expense_manager_app/pages/news/widgets/news_item.dart';
import 'package:expense_manager_app/pages/news/widgets/news_page_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controller/news/news_bloc.dart';
import '../../controller/news/news_state.dart';
import '../../services/api_news.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsBloc, NewsState>(
      builder: (context, state) {
        final List<News> fetchNewsList = state.fetchNewsList;
        final NewsApi userApi = NewsApi();
        return Scaffold(
          appBar: newsPageAppBar(
            context,
            isDetail: false,
          ),
          body: state.status == LoadStatus.inProgress
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : RefreshIndicator(
                  onRefresh: () => userApi.fetchNews(),
                  child: ListView.builder(
                    controller: state.scrollController,
                    itemCount: fetchNewsList.length,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          NewsItem(
                            news: fetchNewsList[index],
                          ),
                          const Divider(),
                        ],
                      );
                    },
                  ),
                ),
        );
      },
    );
  }
}
