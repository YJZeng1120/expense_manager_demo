import 'package:expense_manager_app/models/enums/record_type_enum.dart';
import 'package:expense_manager_app/models/record.dart';

abstract class RecordFormEvent {
  const RecordFormEvent();
}

class InitialEvent extends RecordFormEvent {
  const InitialEvent(this.record);
  final RecordData record;
}

class FetchCategoryListEvent extends RecordFormEvent {
  const FetchCategoryListEvent();
}

class TitleEvent extends RecordFormEvent {
  TitleEvent(this.title);
  final String title;
}

class AmountEvent extends RecordFormEvent {
  AmountEvent(this.amount);
  final int amount;
}

class DateEvent extends RecordFormEvent {
  DateEvent(this.date);
  final DateTime date;
}

class RecordTypeEvent extends RecordFormEvent {
  RecordTypeEvent(this.recordType);
  final RecordType recordType;
}

class NoteEvent extends RecordFormEvent {
  NoteEvent(this.note);
  final String note;
}

class RecordCategoryEvent extends RecordFormEvent {
  RecordCategoryEvent(this.recordCategoryId);
  final int recordCategoryId;
}

class SaveEvent extends RecordFormEvent {
  const SaveEvent();
}

class DeleteEvent extends RecordFormEvent {
  const DeleteEvent();
}

class CalculatorEvent extends RecordFormEvent {
  const CalculatorEvent(
    this.userInput,
  );
  final String userInput;
}
