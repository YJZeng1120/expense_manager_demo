import 'package:expense_manager_app/models/enums/date_change_type_enum.dart';

DateTime calculateNextDate({
  required bool isIncrement,
  required DateTime date,
  required DateChangeType dateChangeType,
}) {
  switch (dateChangeType) {
    case DateChangeType.month:
      return DateTime(
        date.year,
        isIncrement ? date.month + 1 : date.month - 1,
        date.day,
      );
    case DateChangeType.year:
      return DateTime(
        isIncrement ? date.year + 1 : date.year - 1,
        date.month,
        date.day,
      );
    default:
      throw ArgumentError("Invalid DateChangeType");
  }
}
