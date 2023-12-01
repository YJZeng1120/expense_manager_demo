import 'package:expense_manager_app/controller/record_form/record_form_bloc.dart';
import 'package:expense_manager_app/controller/record_form/record_form_event.dart';
import 'package:expense_manager_app/controller/record_form/record_form_state.dart';
import 'package:expense_manager_app/models/category.dart';
import 'package:expense_manager_app/models/enums/load_status_enum.dart';
import 'package:expense_manager_app/models/enums/record_type_enum.dart';
import 'package:expense_manager_app/pages/common/tap_out_dismiss_keyboard.dart';
import 'package:expense_manager_app/pages/record_form/widgets/custom_dialog.dart';
import 'package:expense_manager_app/pages/record_form/widgets/record_form_page_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/expense_view.dart';
import 'widgets/income_view.dart';

class RecordFormPage extends StatelessWidget {
  const RecordFormPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<RecordFormBloc, RecordFormState>(
          listenWhen: (p, c) => p.recordType != c.recordType,
          listener: (context, state) {
            final bool isExpense = state.recordType == RecordType.expense;
            final List<Category> filteredList = isExpense
                ? state.filteredExpenseCategoryList
                : state.filteredIncomeCategoryList;

            BlocProvider.of<RecordFormBloc>(context).add(
              RecordCategoryEvent(filteredList
                      .map((record) => record.id)
                      .contains(state.recordCategoryId)
                  ? state.recordCategoryId
                  : filteredList.first.id!),
            );
          },
        ),
        BlocListener<RecordFormBloc, RecordFormState>(
          listenWhen: (p, c) => p.status != c.status,
          listener: (context, state) {
            switch (state.status) {
              case LoadStatus.failed:
                failedDialog(context);
              case LoadStatus.succeed:
                Navigator.of(context).pop();
                break;
              default:
            }
          },
        ),
      ],
      child: BlocBuilder<RecordFormBloc, RecordFormState>(
        builder: (context, state) {
          return DefaultTabController(
            initialIndex:
                state.isEditing && state.recordType == RecordType.income
                    ? 1
                    : 0,
            length: 2,
            child: Builder(
              builder: (context) {
                final TabController tabController =
                    DefaultTabController.of(context);
                tabController.addListener(
                  () {
                    if (tabController.index == 1) {
                      BlocProvider.of<RecordFormBloc>(context)
                          .add(RecordTypeEvent(RecordType.income));
                    } else {
                      BlocProvider.of<RecordFormBloc>(context)
                          .add(RecordTypeEvent(RecordType.expense));
                    }
                  },
                );
                return Scaffold(
                  appBar: recordFormPageAppBar(context),
                  body: const TapOutDismissKeyboard(
                    child: Column(
                      children: [
                        Expanded(
                          child: TabBarView(
                            children: [
                              ExpenseView(),
                              IncomeView(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
