import 'package:expense_manager_app/controller/record_form/record_form_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../controller/record_form/record_form_bloc.dart';

Future _customDialog(
  BuildContext context,
  List<Widget>? actions, {
  required String title,
  required String contentText,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Center(
          child: Text(
            title,
          ),
        ),
        titleTextStyle: TextStyle(
          fontSize: 20,
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.bold,
        ),
        titlePadding: const EdgeInsets.only(
          top: 30,
          bottom: 10,
        ),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              contentText,
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: actions,
        actionsAlignment: MainAxisAlignment.center,
      );
    },
  );
}

Future deleteDialog(BuildContext context) {
  return _customDialog(
    context,
    [
      TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text("Cancel"),
      ),
      const SizedBox(
        width: 8,
      ),
      ElevatedButton(
        onPressed: () {
          BlocProvider.of<RecordFormBloc>(context).add(
            const DeleteEvent(),
          );
          Navigator.of(context).popUntil((route) => route.isFirst);
        },
        child: const Text("Delete"),
      ),
    ],
    title: "Delete",
    contentText: "Confirm to delete this record?",
  );
}

Future failedDialog(BuildContext context) {
  return _customDialog(
    context,
    [
      ElevatedButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text("OK"),
      ),
    ],
    title: "Error",
    contentText: "Failed to save.\nplease check your enter.",
  );
}
