part of 'home_bloc.dart';

class HomeState {
  final List<RecordData> recordList;
  final List<Category> categoryList;
  final List<RecordData> filterRecordList;
  final LoadStatus status;
  final bool isMonthCalendar;
  final int? countDayExpense;
  final int? countMonthExpense;
  final int? countMonthIncome;
  final DateTime selectedDay;

  HomeState({
    this.recordList = const <RecordData>[], // 在這裡給予expenseList一個初始值為空的空列表
    this.categoryList = const <Category>[],
    this.filterRecordList = const <RecordData>[],
    this.status = LoadStatus.initial,
    this.isMonthCalendar = false,
    this.countDayExpense,
    this.countMonthExpense,
    this.countMonthIncome,
    DateTime? selectedDay,
  }) : selectedDay = selectedDay ?? DateTime.now();

  HomeState copyWith({
    List<RecordData>? recordList,
    List<Category>? categoryList,
    List<RecordData>? filterRecordList,
    LoadStatus? status,
    bool? isMonthCalendar,
    int? countDayExpense,
    int? countMonthExpense,
    int? countMonthIncome,
    DateTime? selectedDay,
  }) {
    return HomeState(
      recordList: recordList ?? this.recordList,
      categoryList: categoryList ?? this.categoryList,
      filterRecordList: filterRecordList ?? this.filterRecordList,
      status: status ?? this.status,
      isMonthCalendar: isMonthCalendar ?? this.isMonthCalendar,
      countDayExpense: countDayExpense ?? this.countDayExpense,
      countMonthExpense: countMonthExpense ?? this.countMonthExpense,
      countMonthIncome: countMonthIncome ?? this.countMonthIncome,
      selectedDay: selectedDay ?? this.selectedDay,
    );
  }
}
