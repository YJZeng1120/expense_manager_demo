import 'package:expense_manager_app/controller/news/news_event.dart';
import 'package:expense_manager_app/models/news.dart';
import 'package:expense_manager_app/pages/news/widgets/news_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../controller/news/news_bloc.dart';
import '../../../controller/news/news_state.dart';

class NewsItem extends StatelessWidget {
  const NewsItem({
    super.key,
    required this.news,
  });
  final News news;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsBloc, NewsState>(
      builder: (context, state) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque, //整個Container都可以觸發手勢事件
          onTap: () {
            BlocProvider.of<NewsBloc>(context)
              ..add(
                FetchNewsDetailEvent(news.id),
              )
              ..add(
                ScrollControllerEvent(state.scrollController),
              );
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const NewsDetail(),
            ));
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 14,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  child: Text(
                    news.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  news.date.toString().substring(0, 10),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
