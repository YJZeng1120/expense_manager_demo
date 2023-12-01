import 'package:expense_manager_app/controller/record_form/record_form_bloc.dart';
import 'package:expense_manager_app/controller/record_form/record_form_event.dart';
import 'package:expense_manager_app/controller/record_form/record_form_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';

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

void datePicker(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return BlocBuilder<RecordFormBloc, RecordFormState>(
        builder: (context, state) {
          return AlertDialog(
            content: SizedBox(
              height: 340,
              width: 300,
              child: TableCalendar(
                rowHeight: 43,
                headerStyle: const HeaderStyle(
                  titleCentered: true,
                  formatButtonVisible: false,
                  headerPadding: EdgeInsets.symmetric(
                    vertical: 9,
                  ),
                ),
                availableGestures: AvailableGestures.all,
                focusedDay: state.date,
                firstDay: firstDate,
                lastDay: lastDate,
                selectedDayPredicate: (day) => isSameDay(
                  day,
                  state.date,
                ),
                onDaySelected: (selectedDay, focusedDay) {
                  BlocProvider.of<RecordFormBloc>(context)
                      .add(DateEvent(selectedDay));
                },
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("OK"),
              )
            ],
          );
        },
      );
    },
  );
}
