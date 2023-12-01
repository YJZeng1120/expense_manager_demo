part of 'home_bloc.dart';

abstract class HomeEvent {
  const HomeEvent();
}

class SelectedDayEvent extends HomeEvent {
  const SelectedDayEvent(this.selectedDay);
  final DateTime selectedDay;
}

class FilterRecordListEvent extends HomeEvent {
  const FilterRecordListEvent();
}

class FetchRecordEvent extends HomeEvent {
  const FetchRecordEvent();
}

class CountRecordEvent extends HomeEvent {
  const CountRecordEvent();
}

class IsMonthCalendarEvent extends HomeEvent {
  const IsMonthCalendarEvent();
}
