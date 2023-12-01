import 'package:expense_manager_app/controller/news/news_bloc.dart';
import 'package:expense_manager_app/controller/news/news_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

AppBar newsPageAppBar(BuildContext context, {required bool isDetail}) {
  NewsState state = context.read<NewsBloc>().state;
  return AppBar(
    leading: isDetail
        ? IconButton(
            onPressed: () {
              state.scrollController.jumpTo(state.savedScrollPosition);
              Navigator.of(context).pop(true);
            },
            icon: const Icon(
              Icons.arrow_back,
            ),
          )
        : null,
    backgroundColor: Theme.of(context).colorScheme.primary,
    foregroundColor: Theme.of(context).colorScheme.onPrimary,
    title: const Text(
      "News",
    ),
  );
}
