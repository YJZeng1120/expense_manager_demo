import 'package:expense_manager_app/functions/record_utils.dart';
import 'package:expense_manager_app/models/category.dart';
import 'package:expense_manager_app/models/enums/load_status_enum.dart';
import 'package:expense_manager_app/models/enums/record_type_enum.dart';
import 'package:expense_manager_app/models/record.dart';
import 'package:expense_manager_app/services/api_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/enums/date_change_type_enum.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ApiRepository _apiRepository;
  HomeBloc(this._apiRepository) : super(HomeState()) {
    _onEvent();
  }

  void _onEvent() {
    on<FetchRecordEvent>((event, emit) async {
      emit(
        state.copyWith(
          status: LoadStatus.inProgress,
        ),
      );

      final recordList = await _apiRepository.loadRecords();
      final categoryList = await _apiRepository.loadCategories();

      emit(
        state.copyWith(
          recordList: recordList,
          categoryList: categoryList,
          status: LoadStatus.succeed,
        ),
      );

      add(const FilterRecordListEvent());
    });

    on<SelectedDayEvent>((event, emit) {
      emit(state.copyWith(selectedDay: event.selectedDay));
    });

    on<FilterRecordListEvent>((event, emit) {
      late List<RecordData> filterList;

      filterList = state.recordList.where((element) {
        return isSameDate(
          element.date,
          state.selectedDay,
          dateChangeType: DateChangeType.day,
        );
      }).toList();

      emit(state.copyWith(
        filterRecordList: filterList,
      ));

      add(const CountRecordEvent());
    });

    on<CountRecordEvent>(
      (event, emit) {
        final DateTime selectedDay = state.selectedDay;
        final List<RecordData> recordList = state.recordList;

        final int expenseDaySum = calculateTotalAmount(
          selectDay: selectedDay,
          recordList: recordList,
          dateChangeType: DateChangeType.day,
          recordType: RecordType.expense,
        );

        final int expenseMonthSum = calculateTotalAmount(
          selectDay: selectedDay,
          recordList: recordList,
          dateChangeType: DateChangeType.month,
          recordType: RecordType.expense,
        );

        final int incomeMonthSum = calculateTotalAmount(
          selectDay: selectedDay,
          recordList: recordList,
          dateChangeType: DateChangeType.month,
          recordType: RecordType.income,
        );

        emit(state.copyWith(
          countDayExpense: expenseDaySum,
          countMonthExpense: expenseMonthSum,
          countMonthIncome: incomeMonthSum,
        ));
      },
    );

    on<IsMonthCalendarEvent>((event, emit) {
      late bool isFlipped = state.isMonthCalendar;
      isFlipped = !isFlipped;
      emit(state.copyWith(isMonthCalendar: isFlipped));
    });
  }
}
