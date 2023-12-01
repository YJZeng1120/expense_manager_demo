import 'package:expense_manager_app/models/category.dart';
import 'package:expense_manager_app/models/enums/load_status_enum.dart';
import 'package:fl_chart/fl_chart.dart';

class ReportState {
  final Map<int, int> sumExpenseByCategoryMap;
  final Map<int, int> sumIncomeByCategoryMap;
  final Map<int, int> sumExpenseByMonthMap;
  final Map<int, int> sumIncomeByMonthMap;
  final List<Category> categoryList;
  final List<PieChartSectionData> filterExpenseList;
  final List<PieChartSectionData> filterIncomeList;
  final bool isViewingExpense;
  final int selectedButtonIndex;
  final int sumExpenseByYear;
  final int sumIncomeByYear;
  final int sumExpenseByMonth;
  final int sumIncomeByMonth;
  final DateTime viewingDate;
  final LoadStatus status;
  final LoadStatus categoryStatus;

  ReportState({
    this.sumExpenseByCategoryMap = const <int, int>{},
    this.sumIncomeByCategoryMap = const <int, int>{},
    this.sumExpenseByMonthMap = const <int, int>{},
    this.sumIncomeByMonthMap = const <int, int>{},
    this.categoryList = const <Category>[],
    this.filterExpenseList = const <PieChartSectionData>[],
    this.filterIncomeList = const <PieChartSectionData>[],
    this.isViewingExpense = true,
    this.selectedButtonIndex = 0,
    this.sumExpenseByYear = 0,
    this.sumIncomeByYear = 0,
    this.sumExpenseByMonth = 0,
    this.sumIncomeByMonth = 0,
    DateTime? viewingDate,
    this.status = LoadStatus.initial,
    this.categoryStatus = LoadStatus.initial,
  }) : viewingDate = viewingDate ?? DateTime.now();

  ReportState copyWith({
    Map<int, int>? sumExpenseByCategoryMap,
    Map<int, int>? sumIncomeByCategoryMap,
    Map<int, int>? sumExpenseByMonthMap,
    Map<int, int>? sumIncomeByMonthMap,
    List<Category>? categoryList,
    List<PieChartSectionData>? filterExpenseList,
    List<PieChartSectionData>? filterIncomeList,
    bool? isViewingExpense,
    int? selectedButtonIndex,
    int? sumExpenseByYear,
    int? sumIncomeByYear,
    int? sumExpenseByMonth,
    int? sumIncomeByMonth,
    DateTime? viewingDate,
    LoadStatus? status,
    LoadStatus? categoryStatus,
  }) {
    return ReportState(
      sumExpenseByCategoryMap:
          sumExpenseByCategoryMap ?? this.sumExpenseByCategoryMap,
      sumIncomeByCategoryMap:
          sumIncomeByCategoryMap ?? this.sumIncomeByCategoryMap,
      sumExpenseByMonthMap: sumExpenseByMonthMap ?? this.sumExpenseByMonthMap,
      sumIncomeByMonthMap: sumIncomeByMonthMap ?? this.sumIncomeByMonthMap,
      categoryList: categoryList ?? this.categoryList,
      filterExpenseList: filterExpenseList ?? this.filterExpenseList,
      filterIncomeList: filterIncomeList ?? this.filterIncomeList,
      isViewingExpense: isViewingExpense ?? this.isViewingExpense,
      selectedButtonIndex: selectedButtonIndex ?? this.selectedButtonIndex,
      sumExpenseByYear: sumExpenseByYear ?? this.sumExpenseByYear,
      sumIncomeByYear: sumIncomeByYear ?? this.sumIncomeByYear,
      sumExpenseByMonth: sumExpenseByMonth ?? this.sumExpenseByMonth,
      sumIncomeByMonth: sumIncomeByMonth ?? this.sumIncomeByMonth,
      viewingDate: viewingDate ?? this.viewingDate,
      status: status ?? this.status,
      categoryStatus: categoryStatus ?? this.categoryStatus,
    );
  }
}
