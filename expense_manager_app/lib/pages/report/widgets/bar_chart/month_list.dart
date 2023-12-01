import 'package:expense_manager_app/controller/report/report_bloc.dart';
import 'package:expense_manager_app/controller/report/report_state.dart';
import 'package:expense_manager_app/functions/chart_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../functions/record_utils.dart';

class MonthList extends StatelessWidget {
  const MonthList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportBloc, ReportState>(
      builder: (context, state) {
        bool isExpense = state.isViewingExpense;
        return Column(
          children: [
            ...selectedMonthMap(context, state.selectedButtonIndex)
                .entries
                .map((e) {
              bool isNoRecord = e.value == 0;
              Color recordTypeColor = isNoRecord
                  ? Colors.black26
                  : e.value < 0 || isExpense
                      ? Colors.red
                      : Colors.blue;
              return Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                child: Row(
                  children: [
                    Container(
                      width: 8,
                      height: 26,
                      decoration: BoxDecoration(
                        color: recordTypeColor,
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    monthName(
                      e.key - 1,
                      isNoRecord ? Colors.black26 : Colors.black,
                    ),
                    const Spacer(),
                    Text(
                      isNoRecord
                          ? "\$ 0"
                          : isExpense
                              ? "\$-${numberFormatter.format(e.value)}"
                              : "\$ ${numberFormatter.format(e.value)}",
                      style: TextStyle(
                        fontSize: 16,
                        color: recordTypeColor,
                      ),
                    )
                  ],
                ),
              );
            })
          ],
        );
      },
    );
  }
}

Widget monthName(int value, Color textColor) {
  final style = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: textColor,
  );
  String text;
  switch (value.toInt()) {
    case 0:
      text = 'January';
      break;
    case 1:
      text = 'February';
      break;
    case 2:
      text = 'March';
      break;
    case 3:
      text = 'April';
      break;
    case 4:
      text = 'May';
      break;
    case 5:
      text = 'June';
      break;
    case 6:
      text = 'July';
      break;
    case 7:
      text = 'August';
      break;
    case 8:
      text = 'September';
      break;
    case 9:
      text = 'October';
      break;
    case 10:
      text = 'November';
      break;
    case 11:
      text = 'December';
      break;
    default:
      text = '';
  }
  return Text(
    text,
    style: style,
  );
}
