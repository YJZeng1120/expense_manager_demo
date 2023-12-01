import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controller/report/report_bloc.dart';
import '../controller/report/report_state.dart';

int selectedSumByYear(BuildContext context, int selectedIndex) {
  final ReportState state = context.read<ReportBloc>().state;
  switch (selectedIndex) {
    case 0:
      return state.sumExpenseByYear;
    case 1:
      return state.sumIncomeByYear;
    case 2:
      return state.sumIncomeByYear - state.sumExpenseByYear;
    default:
      return 0;
  }
}

Map<int, int> selectedMonthMap(BuildContext context, int selectIndex) {
  final ReportState state = context.read<ReportBloc>().state;
  switch (selectIndex) {
    case 0:
      return state.sumExpenseByMonthMap;
    case 1:
      return state.sumIncomeByMonthMap;
    case 2:
      final Map<int, int> balanceMap = {};
      state.sumIncomeByMonthMap.forEach(
        (key, value) {
          if (state.sumExpenseByMonthMap.containsKey(key)) {
            int difference = value - state.sumExpenseByMonthMap[key]!;
            balanceMap[key] = difference;
          }
        },
      );
      return balanceMap;

    default:
      return {};
  }
}
