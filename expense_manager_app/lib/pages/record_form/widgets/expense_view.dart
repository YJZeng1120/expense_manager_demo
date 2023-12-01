import 'package:expense_manager_app/controller/record_form/record_form_bloc.dart';
import 'package:expense_manager_app/controller/record_form/record_form_event.dart';
import 'package:expense_manager_app/controller/record_form/record_form_state.dart';
import 'package:expense_manager_app/functions/date_picker.dart';
import 'package:expense_manager_app/models/enums/record_type_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'record_list_tile.dart';

class ExpenseView extends StatelessWidget {
  const ExpenseView({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      calculatorBottomSheet(context);
    }); //初始時顯示amount鍵盤
    return BlocBuilder<RecordFormBloc, RecordFormState>(
      builder: (context, state) {
        String date = state.date.toString();
        return Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    datePicker(
                      context,
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 48,
                    child: Text(
                      date.substring(0, 10),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  children: ListTile.divideTiles(context: context, tiles: [
                    amountListTile(context),
                    titleListTile(context),
                    categoryListTile(
                      context,
                      isExpense: true,
                    ),
                    const ListTile(
                      title: Text(
                        'Notes',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ]).toList(),
                ),
                noteItem(context),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Cancel"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (state.amount == 0) {
                          final double doubleResult =
                              double.parse(state.userInput);
                          final int intResult = doubleResult.toInt();
                          BlocProvider.of<RecordFormBloc>(context)
                              .add(AmountEvent(intResult)); //儲存Calculator的值
                        }
                        BlocProvider.of<RecordFormBloc>(context)
                          ..add(RecordTypeEvent(RecordType.expense))
                          ..add(const SaveEvent());
                      },
                      child: const Text("Save"),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
