import 'package:expense_manager_app/controller/report/report_state.dart';
import 'package:expense_manager_app/functions/date_calculate.dart';
import 'package:expense_manager_app/models/enums/date_change_type_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../controller/report/report_bloc.dart';
import '../../../controller/report/report_event.dart';

Widget recordTypeButton(
  BuildContext context, {
  required String title,
  required int buttonIndex,
}) {
  ReportState state = context.read<ReportBloc>().state;

  return GestureDetector(
    onTap: () {
      BlocProvider.of<ReportBloc>(context)
        ..add(SelectedButtonEvent(buttonIndex))
        ..add(const IsViewingExpenseEvent());
    },
    child: Container(
      padding: const EdgeInsets.symmetric(
        vertical: 3,
        horizontal: 8,
      ),
      decoration: BoxDecoration(
        color: buttonIndex == state.selectedButtonIndex
            ? const Color.fromARGB(255, 238, 146, 25)
            : Colors.transparent,
        border: Border.all(
          color: buttonIndex == state.selectedButtonIndex
              ? Colors.transparent
              : Colors.black45,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: buttonIndex == state.selectedButtonIndex
              ? Colors.white
              : Colors.black45,
          fontSize: 13,
        ),
      ),
    ),
  );
}

GestureDetector dateChangeButton(
  BuildContext context, {
  required IconData icon,
  required bool isIncrement,
  required DateChangeType dateChangeType,
}) {
  ReportState state = context.read<ReportBloc>().state;
  return GestureDetector(
    onTap: () {
      DateTime operator = calculateNextDate(
        isIncrement: isIncrement,
        date: state.viewingDate,
        dateChangeType: dateChangeType,
      );
      BlocProvider.of<ReportBloc>(context)
        ..add(SelectDayEvent(operator))
        ..add(const LoadCategoryStatsEvent())
        ..add(const LoadTrendStatsEvent());
    },
    child: Icon(
      icon,
      size: 24,
    ),
  );
}
