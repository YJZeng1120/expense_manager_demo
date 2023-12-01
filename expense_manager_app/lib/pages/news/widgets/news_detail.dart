import 'package:expense_manager_app/functions/news_utils.dart';
import 'package:expense_manager_app/models/enums/load_status_enum.dart';
import 'package:expense_manager_app/pages/news/widgets/news_page_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../controller/news/news_bloc.dart';
import '../../../controller/news/news_state.dart';

class NewsDetail extends StatelessWidget {
  const NewsDetail({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsBloc, NewsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: newsPageAppBar(
            context,
            isDetail: true,
          ),
          body: state.status == LoadStatus.inProgress
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 14,
                    ),
                    child: Column(
                      children: [
                        Text(
                          state.fetchNewsDetail.title,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Text(
                              "${state.fetchNewsDetail.date.toString().substring(0, 10)}  |  ${state.fetchNewsDetail.reporter}",
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          formattedArticle(
                            state.fetchNewsDetail.content,
                          ),
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }
}
