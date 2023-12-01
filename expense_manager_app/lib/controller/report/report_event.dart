abstract class ReportEvent {
  const ReportEvent();
}

class LoadCategoryStatsEvent extends ReportEvent {
  const LoadCategoryStatsEvent();
}

class LoadTrendStatsEvent extends ReportEvent {
  const LoadTrendStatsEvent();
}

class IsViewingExpenseEvent extends ReportEvent {
  const IsViewingExpenseEvent();
}

class SelectedButtonEvent extends ReportEvent {
  const SelectedButtonEvent(this.selectedButtonIndex);
  final int selectedButtonIndex;
}

class SelectDayEvent extends ReportEvent {
  const SelectDayEvent(this.viewingDate);
  final DateTime viewingDate;
}
