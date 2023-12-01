import 'package:expense_manager_app/controller/home/home_bloc.dart';
import 'package:expense_manager_app/functions/record_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../models/enums/date_change_type_enum.dart';

class HomeCalendar extends StatelessWidget {
  const HomeCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return homeTableCalendar(
          context,
          calendarFormat: state.isMonthCalendar
              ? CalendarFormat.month
              : CalendarFormat.week,
        );
      },
    );
  }
}

TableCalendar homeTableCalendar(BuildContext context,
    {required CalendarFormat calendarFormat}) {
  HomeState state = context.read<HomeBloc>().state;
  final now = DateTime.now();
  final firstDate = DateTime(
    now.year - 1,
    now.month,
    now.day,
  );
  final lastDate = DateTime(
    now.year + 1,
    now.month,
    now.day,
  );
  return TableCalendar(
    headerStyle: const HeaderStyle(
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
      titleCentered: true,
      headerPadding: EdgeInsets.symmetric(
        vertical: 18,
      ),
      formatButtonVisible: false,
      leftChevronVisible: false,
      rightChevronVisible: false,
    ),
    availableGestures: AvailableGestures.all,
    calendarStyle: const CalendarStyle(
      tablePadding: EdgeInsets.symmetric(
        horizontal: 10,
      ),
    ),
    calendarFormat: calendarFormat,
    firstDay: firstDate,
    lastDay: lastDate,
    focusedDay: state.selectedDay,
    selectedDayPredicate: (day) => isSameDay(day, state.selectedDay),
    onDaySelected: (selectedDay, focusedDay) {
      BlocProvider.of<HomeBloc>(context)
        ..add(SelectedDayEvent(selectedDay))
        ..add(const FilterRecordListEvent());
    },
    eventLoader: (day) {
      final List dayList;
      dayList = state.recordList.map((e) => e.date).toList();
      return dayList.any(
        (element) => isSameDate(
          element,
          day,
          dateChangeType: DateChangeType.day,
        ),
      )
          ? [dayList]
          : [];
    },
  );
}
