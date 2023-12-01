import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../controller/report/report_bloc.dart';
import '../../../../controller/report/report_state.dart';
import '../../../../functions/record_utils.dart';
import '../no_record_date.dart';
import 'category_list.dart';

class ReportPieChartData extends StatelessWidget {
  const ReportPieChartData({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportBloc, ReportState>(
      builder: (context, state) {
        bool isExpense = state.isViewingExpense;
        return Column(
          children: isExpense && state.filterExpenseList.isEmpty ||
                  !isExpense && state.filterIncomeList.isEmpty
              ? [
                  noRecordData(
                    context,
                  ),
                ]
              : [
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    alignment: Alignment.topCenter,
                    width: double.infinity,
                    height: 260,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        isExpense &&
                                    state.filterExpenseList.first.value.isNaN ||
                                !isExpense &&
                                    state.filterIncomeList.first.value.isNaN
                            ? Container(
                                width: MediaQuery.of(context).size.width / 3,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 3,
                                  ),
                                ),
                              )
                            : categoryPieChart(
                                context,
                              ),
                        SizedBox(
                          width: 90,
                          height: 30,
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Text(
                              isExpense
                                  ? "\$${numberFormatter.format(state.sumExpenseByMonth)}"
                                  : "\$${numberFormatter.format(state.sumIncomeByMonth)}",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const CategoryList()
                ],
        );
      },
    );
  }
}

PieChart categoryPieChart(BuildContext context) {
  final ReportState state = context.read<ReportBloc>().state;

  return PieChart(
    PieChartData(
      centerSpaceRadius: 50,
      sectionsSpace: 1,
      sections: state.isViewingExpense
          ? state.filterExpenseList
          : state.filterIncomeList,
    ),
  );
}

PieChartSectionData pieChartSectionData({
  required Color color,
  required String title,
  required String value,
}) {
  return PieChartSectionData(
    radius: 45,
    color: color,
    badgeWidget: Text(
      title,
      style: const TextStyle(
        fontSize: 13,
      ),
    ),
    badgePositionPercentageOffset: 1.9,
    showTitle: true,
    titleStyle: const TextStyle(
      fontSize: 10,
    ),
    value: double.parse(value),
  );
}
