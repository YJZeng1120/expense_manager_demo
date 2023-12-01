import 'package:expense_manager_app/models/enums/date_change_type_enum.dart';
import 'package:expense_manager_app/pages/report/widgets/pie_chart/pie_chart_data.dart';
import 'package:expense_manager_app/pages/report/widgets/report_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../controller/report/report_bloc.dart';
import '../../../../controller/report/report_event.dart';
import '../../../../controller/report/report_state.dart';

class PieChartView extends StatelessWidget {
  const PieChartView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportBloc, ReportState>(
      builder: (context, state) {
        final int month = state.viewingDate.month;
        final String formattedMonth = month.toString().padLeft(2, '0');
        final String monthlyDateView =
            "${state.viewingDate.year}-$formattedMonth";
        return Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2.7,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      dateChangeButton(context,
                          icon: Icons.arrow_left_rounded,
                          isIncrement: false,
                          dateChangeType: DateChangeType.month),
                      GestureDetector(
                        onTap: () {
                          BlocProvider.of<ReportBloc>(context)
                            ..add(SelectDayEvent(DateTime.now()))
                            ..add(const LoadCategoryStatsEvent())
                            ..add(const LoadTrendStatsEvent());
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 48,
                          child: Text(
                            monthlyDateView,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      dateChangeButton(context,
                          icon: Icons.arrow_right_rounded,
                          isIncrement: true,
                          dateChangeType: DateChangeType.month),
                    ],
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    recordTypeButton(
                      context,
                      title: "Expense",
                      buttonIndex: 0,
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    recordTypeButton(
                      context,
                      title: "Income",
                      buttonIndex: 1,
                    ),
                  ],
                )
              ],
            ),
            const ReportPieChartData(),
          ],
        );
      },
    );
  }
}
