import 'package:expense_manager_app/models/enums/record_type_enum.dart';

RecordType recordTypeConverter(String dbRecordType) {
  switch (dbRecordType) {
    case "expense":
      return RecordType.expense;
    case "income":
      return RecordType.income;
    default:
      return RecordType.expense;
  }
}
