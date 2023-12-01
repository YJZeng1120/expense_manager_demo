import 'package:expense_manager_app/functions/record_type_converter.dart';
import 'package:expense_manager_app/models/enums/record_type_enum.dart';
import 'package:uuid/uuid.dart';

class RecordData {
  RecordData({
    this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.recordType,
    required this.note,
    required this.recordCategoryId,
  });

  final String? id;
  final String title;
  final int amount;
  final RecordType recordType;
  final DateTime date;
  final String note;
  final int recordCategoryId;

  factory RecordData.empty(DateTime date) {
    return RecordData(
      id: null,
      title: "",
      amount: 0,
      date: date,
      recordType: RecordType.expense,
      note: "",
      recordCategoryId: 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": const Uuid().v4(),
      "title": title,
      "amount": amount,
      "date": date.toString(),
      "recordType": recordType.name,
      "note": note,
      "categoryId": recordCategoryId,
    };
  }

  factory RecordData.fromJson(Map<String, dynamic> map) {
    return RecordData(
        id: map["id"],
        title: map["title"],
        amount: map["amount"],
        date: DateTime.parse(map["date"]),
        recordType: recordTypeConverter(map["recordType"]),
        note: map["note"],
        recordCategoryId: map["categoryId"]);
  }
}
