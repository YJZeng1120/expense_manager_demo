import 'package:expense_manager_app/models/category.dart';
import 'package:expense_manager_app/models/enums/load_status_enum.dart';
import 'package:expense_manager_app/models/enums/record_type_enum.dart';

class RecordFormState {
  final String? id;
  final String title;
  final int amount;
  final DateTime date;
  final RecordType recordType;
  final String note;
  final int recordCategoryId;
  final List<Category> filteredExpenseCategoryList;
  final List<Category> filteredIncomeCategoryList;
  final LoadStatus status;
  final bool isEditing;
  final String userInput;

  RecordFormState({
    this.id,
    this.title = "",
    this.amount = 0,
    DateTime? date, // 移除預設值
    this.recordType = RecordType.expense,
    this.note = "",
    this.recordCategoryId = 1,
    this.filteredExpenseCategoryList = const <Category>[],
    this.filteredIncomeCategoryList = const <Category>[],
    this.status = LoadStatus.initial,
    this.isEditing = false,
    this.userInput = "0",
  }) : date = date ?? DateTime.now(); // 在這裡給予date一個初始值為DateTime.now();

  RecordFormState copyWith({
    String? id,
    String? title,
    int? amount,
    DateTime? date,
    RecordType? recordType,
    String? note,
    int? recordCategoryId,
    List<Category>? filteredExpenseCategoryList,
    List<Category>? filteredIncomeCategoryList,
    LoadStatus? status,
    bool? isEditing,
    String? userInput,
  }) {
    return RecordFormState(
      id: id ?? this.id,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      recordType: recordType ?? this.recordType,
      note: note ?? this.note,
      recordCategoryId: recordCategoryId ?? this.recordCategoryId,
      filteredExpenseCategoryList:
          filteredExpenseCategoryList ?? this.filteredExpenseCategoryList,
      filteredIncomeCategoryList:
          filteredIncomeCategoryList ?? this.filteredIncomeCategoryList,
      status: status ?? this.status,
      isEditing: isEditing ?? this.isEditing,
      userInput: userInput ?? this.userInput,
    );
  }
}
