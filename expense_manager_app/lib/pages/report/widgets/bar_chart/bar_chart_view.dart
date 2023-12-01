import 'package:expense_manager_app/models/enums/date_change_type_enum.dart';
import 'package:expense_manager_app/pages/report/widgets/report_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../controller/report/report_bloc.dart';
import '../../../../controller/report/report_event.dart';
import '../../../../controller/report/report_state.dart';
import 'bar_chart_data.dart';

class BarChartView extends StatelessWidget {
  const BarChartView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportBloc, ReportState>(
      builder: (context, state) {
        final String yearlyDateView = "${state.viewingDate.year}";
        return Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 3.6,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      dateChangeButton(
                        context,
                        icon: Icons.arrow_left_rounded,
                        isIncrement: false,
                        dateChangeType: DateChangeType.year,
                      ),
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
                            yearlyDateView,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      dateChangeButton(
                        context,
                        icon: Icons.arrow_right_rounded,
                        isIncrement: true,
                        dateChangeType: DateChangeType.year,
                      ),
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
                    const SizedBox(
                      width: 6,
                    ),
                    recordTypeButton(
                      context,
                      title: "Balance",
                      buttonIndex: 2,
                    ),
                  ],
                )
              ],
            ),
            const ReportBarChartData(),
          ],
        );
      },
    );
  }
}
