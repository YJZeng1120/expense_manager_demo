import 'package:expense_manager_app/controller/report/report_event.dart';
import 'package:expense_manager_app/controller/report/report_state.dart';
import 'package:expense_manager_app/functions/record_utils.dart';
import 'package:expense_manager_app/models/enums/load_status_enum.dart';
import 'package:expense_manager_app/models/enums/record_type_enum.dart';
import 'package:expense_manager_app/services/api_repository.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/enums/date_change_type_enum.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  final ApiRepository _apiRepository;
  ReportBloc(this._apiRepository) : super(ReportState()) {
    _onEvent();
  }

  void _onEvent() {
    on<LoadCategoryStatsEvent>((event, emit) async {
      emit(state.copyWith(categoryStatus: LoadStatus.inProgress));

      final recordList = await _apiRepository.loadRecords();
      final categoryList = await _apiRepository.loadCategories();

      final int sumExpenseByMonth = calculateTotalAmount(
        selectDay: state.viewingDate,
        recordList: recordList,
        dateChangeType: DateChangeType.month,
        recordType: RecordType.expense,
      );

      final int sumIncomeByMonth = calculateTotalAmount(
        selectDay: state.viewingDate,
        recordList: recordList,
        dateChangeType: DateChangeType.month,
        recordType: RecordType.income,
      );
      final List<PieChartSectionData> filterExpenseList =
          calculateCategoryStats(
        selectDay: state.viewingDate,
        recordList: recordList,
        categoryList: categoryList,
        dateChangeType: DateChangeType.month,
        recordType: RecordType.expense,
        sum: sumExpenseByMonth,
      );
      final List<PieChartSectionData> filterIncomeList = calculateCategoryStats(
        selectDay: state.viewingDate,
        recordList: recordList,
        categoryList: categoryList,
        dateChangeType: DateChangeType.month,
        recordType: RecordType.income,
        sum: sumIncomeByMonth,
      );

      final Map<int, int> sumExpenseByCategoryMap = calculateCategory(
        selectDay: state.viewingDate,
        recordList: recordList,
        categoryList: categoryList,
        dateChangeType: DateChangeType.month,
        recordType: RecordType.expense,
      );
      final Map<int, int> sumIncomeByCategoryMap = calculateCategory(
        selectDay: state.viewingDate,
        recordList: recordList,
        categoryList: categoryList,
        dateChangeType: DateChangeType.month,
        recordType: RecordType.income,
      );
      emit(state.copyWith(
        filterExpenseList: filterExpenseList,
        filterIncomeList: filterIncomeList,
        sumExpenseByCategoryMap: sumExpenseByCategoryMap,
        sumIncomeByCategoryMap: sumIncomeByCategoryMap,
        categoryList: categoryList,
        sumExpenseByMonth: sumExpenseByMonth,
        sumIncomeByMonth: sumIncomeByMonth,
        categoryStatus: LoadStatus.succeed,
      ));
    });

    on<LoadTrendStatsEvent>((event, emit) async {
      emit(state.copyWith(status: LoadStatus.inProgress));
      final recordList = await _apiRepository.loadRecords();

      final Map<int, int> sumExpenseByMonthMap = calculateMonthSum(
        selectDay: state.viewingDate,
        recordList: recordList,
        dateChangeType: DateChangeType.year,
        recordType: RecordType.expense,
      );
      final Map<int, int> sumIncomeByMonthMap = calculateMonthSum(
        selectDay: state.viewingDate,
        recordList: recordList,
        dateChangeType: DateChangeType.year,
        recordType: RecordType.income,
      );

      final int sumExpenseByYear = calculateTotalAmount(
        selectDay: state.viewingDate,
        recordList: recordList,
        dateChangeType: DateChangeType.year,
        recordType: RecordType.expense,
      );

      final int sumIncomeByYear = calculateTotalAmount(
        selectDay: state.viewingDate,
        recordList: recordList,
        dateChangeType: DateChangeType.year,
        recordType: RecordType.income,
      );

      emit(state.copyWith(
        sumExpenseByMonthMap: sumExpenseByMonthMap,
        sumIncomeByMonthMap: sumIncomeByMonthMap,
        sumExpenseByYear: sumExpenseByYear,
        sumIncomeByYear: sumIncomeByYear,
        status: LoadStatus.succeed,
      ));
    });

    on<IsViewingExpenseEvent>((event, emit) {
      emit(state.copyWith(status: LoadStatus.inProgress));
      bool isViewingExpense = true;

      if (state.selectedButtonIndex == 0) {
        //0是expense的按鈕編號
        isViewingExpense = true;
      } else {
        isViewingExpense = false;
      }

      emit(state.copyWith(
          isViewingExpense: isViewingExpense, status: LoadStatus.succeed));
    });

    on<SelectedButtonEvent>((event, emit) {
      emit(state.copyWith(selectedButtonIndex: event.selectedButtonIndex));
    });

    on<SelectDayEvent>((event, emit) {
      emit(state.copyWith(viewingDate: event.viewingDate));
    });
  }
}
