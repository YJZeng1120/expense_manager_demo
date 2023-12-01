import 'package:expense_manager_app/models/category.dart';
import 'package:expense_manager_app/models/enums/record_type_enum.dart';
import 'package:expense_manager_app/models/record.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

import '../models/enums/date_change_type_enum.dart';
import '../pages/report/widgets/pie_chart/pie_chart_data.dart';

final NumberFormat numberFormatter = NumberFormat();

bool isSameDate(DateTime date1, DateTime date2,
    {required DateChangeType dateChangeType}) {
  switch (dateChangeType) {
    case DateChangeType.year:
      return date1.year == date2.year;
    case DateChangeType.month:
      return date1.year == date2.year && date1.month == date2.month;
    case DateChangeType.day:
      return date1.year == date2.year &&
          date1.month == date2.month &&
          date1.day == date2.day;
    default:
      return false;
  }
}

List<RecordData> filteredRecord({
  required DateTime selectDay,
  required List<RecordData> recordList,
  required DateChangeType dateChangeType,
  required RecordType recordType,
}) {
  return recordList.where((element) {
    return isSameDate(element.date, selectDay,
            dateChangeType: dateChangeType) &&
        element.recordType == recordType;
  }).toList();
}

int calculateTotalAmount({
  required DateTime selectDay,
  required List<RecordData> recordList,
  required DateChangeType dateChangeType,
  required RecordType recordType,
}) {
  List<RecordData> filterList = filteredRecord(
    selectDay: selectDay,
    recordList: recordList,
    dateChangeType: dateChangeType,
    recordType: recordType,
  );
  int sum = 0;

  for (var element in filterList) {
    sum += element.amount;
  }

  return sum;
}

Map<int, int> calculateCategory({
  required DateTime selectDay,
  required List<RecordData> recordList,
  required List<Category> categoryList,
  required DateChangeType dateChangeType,
  required RecordType recordType,
}) {
  late List<RecordData> filterList;
  filterList = filteredRecord(
    dateChangeType: dateChangeType,
    recordType: recordType,
    selectDay: selectDay,
    recordList: recordList,
  );

  final Map<int, int> categoryIdSumMap = {};

  for (var element in filterList) {
    int value = categoryIdSumMap[element.recordCategoryId] ?? 0;
    categoryIdSumMap[element.recordCategoryId] =
        value + element.amount; //可以修改map裡的vlaue
  }

  return categoryIdSumMap;
}

List<PieChartSectionData> calculateCategoryStats({
  required DateTime selectDay,
  required List<RecordData> recordList,
  required List<Category> categoryList,
  required DateChangeType dateChangeType,
  required RecordType recordType,
  required int sum,
}) {
  final Map<int, int> categoryIdSumMap = calculateCategory(
    selectDay: selectDay,
    recordList: recordList,
    categoryList: categoryList,
    dateChangeType: dateChangeType,
    recordType: recordType,
  );

  List<PieChartSectionData> categorySumList = categoryIdSumMap
      .map((key, data) {
        double result = data / sum * 100; //sum是每個月的全部總和
        Category selectCategory = categoryList[key - 1];
        final value = pieChartSectionData(
          color: selectCategory.iconColor,
          title: selectCategory.title.toUpperCase(),
          value: result.toStringAsFixed(2),
        );
        return MapEntry(key, value);
      })
      .values
      .toList();

  return categorySumList;
}

Map<int, int> calculateMonthSum({
  required DateTime selectDay,
  required List<RecordData> recordList,
  required DateChangeType dateChangeType,
  required RecordType recordType,
}) {
  late List<RecordData> filterList;
  filterList = filteredRecord(
      selectDay: selectDay,
      recordList: recordList,
      dateChangeType: dateChangeType,
      recordType: recordType);

  final Map<int, int> monthSumMap = {
    for (int month = 1; month <= 12; month++) month: 0 //Map的default value設為0
  };

  for (var element in filterList) {
    int value = monthSumMap[element.date.month] ?? 0;
    monthSumMap[element.date.month] = value + element.amount;
  }

  return monthSumMap;
}
