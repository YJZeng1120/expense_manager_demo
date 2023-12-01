import 'package:expense_manager_app/controller/home/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../functions/record_utils.dart';

class ClacRecord extends StatelessWidget {
  const ClacRecord({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        int balanceCalculate =
            (state.countMonthIncome ?? 0) - (state.countMonthExpense ?? 0);
        return Container(
          padding: const EdgeInsets.symmetric(
            vertical: 13,
            horizontal: 21,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              20,
            ),
            color: Theme.of(context).colorScheme.secondary,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              viewCalcRecord(
                context,
                title: "Mo. Expense",
                count: state.countMonthExpense,
                color: Colors.red,
              ),
              viewCalcRecord(
                context,
                title: "D. Expense",
                count: state.countDayExpense,
                color: Colors.red,
              ),
              viewCalcRecord(
                context,
                title: "Mo. Income",
                count: state.countMonthIncome,
                color: Colors.blue,
              ),
              viewCalcRecord(
                context,
                title: "Mo. Balance",
                count: balanceCalculate,
                color: balanceCalculate < 0 ? Colors.red : Colors.blue,
              ),
            ],
          ),
        );
      },
    );
  }
}

SizedBox viewCalcRecord(
  BuildContext context, {
  required String title,
  required int? count,
  required Color color,
}) {
  return SizedBox(
    width: 75,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FittedBox(
          fit: BoxFit.contain,
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 11,
            ),
          ),
        ),
        const SizedBox(
          height: 2,
        ),
        Text(
          "\$ ${numberFormatter.format(count ?? 0)}",
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 16,
            color: color,
          ),
        ),
      ],
    ),
  );
}
