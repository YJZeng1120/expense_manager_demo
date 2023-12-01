import 'package:expense_manager_app/controller/record_form/record_form_bloc.dart';
import 'package:expense_manager_app/controller/record_form/record_form_state.dart';
import 'package:expense_manager_app/pages/record_form/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

AppBar recordFormPageAppBar(BuildContext context) {
  final RecordFormState state = context.read<RecordFormBloc>().state;

  return AppBar(
    bottom: TabBar(
      unselectedLabelColor:
          Theme.of(context).colorScheme.onPrimary.withOpacity(0.6),
      labelColor: Theme.of(context).colorScheme.onPrimary,
      labelStyle: const TextStyle(
        fontSize: 16,
      ),
      indicatorColor: Colors.greenAccent.shade400,
      indicatorWeight: 2,
      indicatorSize: TabBarIndicatorSize.tab,
      tabs: const [
        Tab(
          text: "Expense",
        ),
        Tab(
          text: "Income",
        )
      ],
    ),
    backgroundColor: Theme.of(context).colorScheme.primary,
    foregroundColor: Theme.of(context).colorScheme.onPrimary,
    title: Text(
      state.isEditing ? "Edit Record" : "Add Record",
    ),
    actions: state.isEditing
        ? [
            IconButton(
              onPressed: () {
                deleteDialog(context);
              },
              icon: const Icon(
                Icons.delete,
              ),
            ),
          ]
        : [],
  );
}
