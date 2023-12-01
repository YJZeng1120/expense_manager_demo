import 'package:expense_manager_app/controller/record_form/record_form_bloc.dart';
import 'package:expense_manager_app/controller/record_form/record_form_event.dart';
import 'package:expense_manager_app/controller/record_form/record_form_state.dart';
import 'package:expense_manager_app/models/category.dart';
import 'package:expense_manager_app/pages/record_form/widgets/calculator_keyboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void calculatorBottomSheet(BuildContext context) {
  showModalBottomSheet(
    // 調整BottomSheet動畫速度
    transitionAnimationController: AnimationController(
      vsync: Navigator.of(context),
      duration: const Duration(milliseconds: 100),
    ),
    barrierColor: Colors.transparent,
    context: context,
    builder: (context) {
      return buildButtons(context);
    },
  );
}

ListTile _recordListTile({
  required String title,
  required Icon leadingIcon,
  required Widget trailing,
}) {
  return ListTile(
    leading: leadingIcon,
    title: Text(
      title,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ),
    trailing: trailing,
  );
}

ListTile amountListTile(BuildContext context) {
  return _recordListTile(
    title: 'Amount',
    leadingIcon: const Icon(Icons.monetization_on),
    trailing: GestureDetector(
      onTap: () {
        return calculatorBottomSheet(context);
      },
      child: SizedBox(
        width: 190,
        child: buildResult(),
      ),
    ),
  );
}

ListTile titleListTile(BuildContext context) {
  final RecordFormState state = context.read<RecordFormBloc>().state;
  return _recordListTile(
    title: "Title",
    leadingIcon: const Icon(Icons.edit_document),
    trailing: SizedBox(
      width: 120,
      child: TextFormField(
        initialValue: state.isEditing ? state.title : null,
        onChanged: (value) => BlocProvider.of<RecordFormBloc>(context).add(
          TitleEvent(
            value,
          ),
        ),
        textAlign: TextAlign.right,
        decoration: InputDecoration(
          hintText: "Enter Title",
          hintStyle: TextStyle(
            color: Colors.black.withOpacity(
              0.3,
            ),
          ),
          border: InputBorder.none,
        ),
      ),
    ),
  );
}

Widget noteItem(BuildContext context) {
  final RecordFormState state = context.read<RecordFormBloc>().state;
  return Container(
    padding: const EdgeInsets.symmetric(
      horizontal: 16,
    ),
    width: double.infinity,
    height: 160,
    decoration: BoxDecoration(
      border: Border.all(
        width: 1,
        color: Colors.black.withOpacity(
          0.3,
        ),
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    child: TextFormField(
      initialValue: state.isEditing ? state.note : null,
      scrollPadding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
      onChanged: (value) =>
          BlocProvider.of<RecordFormBloc>(context).add(NoteEvent(value)),
      maxLength: 50,
      maxLines: 4,
      decoration: InputDecoration(
        hintText: "Add some notes...",
        hintStyle: TextStyle(
          color: Colors.black.withOpacity(
            0.3,
          ),
        ),
        border: InputBorder.none,
      ),
    ),
  );
}

ListTile categoryListTile(
  BuildContext context, {
  required bool isExpense,
}) {
  final RecordFormState state = context.read<RecordFormBloc>().state;
  final List<Category> filteredCategoryList = isExpense
      ? state.filteredExpenseCategoryList
      : state.filteredIncomeCategoryList;

  return _recordListTile(
    title: 'Category',
    leadingIcon: const Icon(Icons.category),
    trailing: Container(
      alignment: Alignment.centerRight,
      width: 130,
      child: DropdownButton(
        hint: const Text("Select"),
        value: filteredCategoryList
                .map((category) => category.id)
                .contains(state.recordCategoryId)
            ? state.recordCategoryId
            : filteredCategoryList.first.id,
        items: filteredCategoryList
            .map(
              (category) => DropdownMenuItem(
                value: category.id,
                child: Text(
                  category.title.toUpperCase(),
                ),
              ),
            )
            .toList(),
        onChanged: (value) {
          if (value == null) {
            return;
          }
          BlocProvider.of<RecordFormBloc>(context)
              .add(RecordCategoryEvent(value));
        },
      ),
    ),
  );
}
