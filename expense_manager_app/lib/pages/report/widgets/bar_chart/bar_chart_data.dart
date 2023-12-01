import 'package:expense_manager_app/pages/report/widgets/bar_chart/month_list.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../controller/report/report_bloc.dart';
import '../../../../controller/report/report_state.dart';
import '../../../../functions/chart_utils.dart';
import '../../../../functions/record_utils.dart';
import '../no_record_date.dart';

class ReportBarChartData extends StatelessWidget {
  const ReportBarChartData({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportBloc, ReportState>(
      builder: (context, state) {
        bool checkNoRecord(Map<int, int> monthMap) {
          return monthMap.values.every((value) => value == 0);
        }

        final bool isExpense = state.isViewingExpense;
        final yearlySumViewing = selectedSumByYear(
          context,
          state.selectedButtonIndex,
        );
        final sign = isExpense ? "\$ -" : "\$ ";
        return Column(
          children: isExpense && checkNoRecord(state.sumExpenseByMonthMap) ||
                  !isExpense && checkNoRecord(state.sumIncomeByMonthMap)
              ? [
                  noRecordData(
                    context,
                  ),
                ]
              : [
                  Container(
                    padding: const EdgeInsets.only(
                      left: 10,
                    ),
                    alignment: Alignment.topLeft,
                    height: 68,
                    child: Text(
                      "Yearly total: $sign${numberFormatter.format(yearlySumViewing)}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 200,
                    child: monthBarChart(
                      context,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const MonthList(),
                ],
        );
      },
    );
  }
}

BarChart monthBarChart(BuildContext context) {
  final ReportState state = context.read<ReportBloc>().state;

  return BarChart(
    barChartData(
      context,
      monthSumMap: selectedMonthMap(
        context,
        state.selectedButtonIndex,
      ),
    ),
  );
}

BarChartData barChartData(
  BuildContext context, {
  required Map<int, int> monthSumMap,
}) {
  final ReportState state = context.read<ReportBloc>().state;
  final bool isExpense = state.isViewingExpense;
  return BarChartData(
      titlesData: const FlTitlesData(
        leftTitles: AxisTitles(),
        rightTitles: AxisTitles(),
        topTitles: AxisTitles(),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: bottomTitles,
          ),
        ),
      ),
      barTouchData: touchData(),
      borderData: FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(width: 1),
        ),
      ),
      gridData: FlGridData(
        drawVerticalLine: false,
        drawHorizontalLine: true,
        horizontalInterval: 20,
        checkToShowHorizontalLine: (value) => value == 0,
        show: true,
      ),
      barGroups: [
        ...monthSumMap.entries.map((e) {
          return generateGroupData(
            monthIndex: e.key - 1,
            value: e.value.toDouble(),
            color: e.value < 0 || isExpense ? Colors.red : Colors.blue,
          );
        })
      ]);
}

BarChartGroupData generateGroupData({
  required int monthIndex,
  required double value,
  required Color color,
}) {
  return BarChartGroupData(
    x: monthIndex,
    groupVertically: true,
    barRods: [
      BarChartRodData(
        fromY: 0,
        toY: value,
        width: 10,
        borderRadius: BorderRadius.circular(
          2,
        ),
        color: color,
      ),
    ],
  );
}

SideTitleWidget bottomTitles(double value, TitleMeta meta) {
  const style = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w600,
  );
  String text;
  switch (value.toInt()) {
    case 0:
      text = 'JAN';
      break;
    case 1:
      text = 'FEB';
      break;
    case 2:
      text = 'MAR';
      break;
    case 3:
      text = 'APR';
      break;
    case 4:
      text = 'MAY';
      break;
    case 5:
      text = 'JUN';
      break;
    case 6:
      text = 'JUL';
      break;
    case 7:
      text = 'AUG';
      break;
    case 8:
      text = 'SEP';
      break;
    case 9:
      text = 'OCT';
      break;
    case 10:
      text = 'NOV';
      break;
    case 11:
      text = 'DEC';
      break;
    default:
      text = '';
  }
  return SideTitleWidget(
    axisSide: meta.axisSide,
    child: Text(text, style: style),
  );
}

BarTouchData touchData() {
  return BarTouchData(
    touchTooltipData: BarTouchTooltipData(
      tooltipBgColor: const Color.fromARGB(255, 218, 218, 218),
      tooltipRoundedRadius: 10,
      tooltipMargin: 5,
      tooltipPadding: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 8,
      ),
    ),
  );
}
