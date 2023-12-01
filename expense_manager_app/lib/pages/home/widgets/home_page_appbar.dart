import 'package:expense_manager_app/controller/home/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

AppBar homePageAppBar(BuildContext context,
    {required void Function() openAddRecord}) {
  return AppBar(
    backgroundColor: Theme.of(context).colorScheme.primary,
    foregroundColor: Theme.of(context).colorScheme.onPrimary,
    title: const Text(
      "Expense Manager",
    ),
    leading: IconButton(
      onPressed: () {
        BlocProvider.of<HomeBloc>(context).add(const IsMonthCalendarEvent());
      },
      icon: Icon(
        Icons.calendar_month,
        color: Theme.of(context).colorScheme.onPrimary,
      ),
    ),
    actions: [
      IconButton(
        onPressed: openAddRecord,
        icon: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
    ],
  );
}
