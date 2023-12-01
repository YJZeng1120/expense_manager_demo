import 'package:expense_manager_app/controller/record_form/record_form_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../controller/record_form/record_form_bloc.dart';
import '../../../controller/record_form/record_form_state.dart';

Widget buildResult() {
  return BlocBuilder<RecordFormBloc, RecordFormState>(
    builder: (context, state) {
      bool hasError = state.userInput == 'Error: Invalid expression';
      return Text(
        hasError ? state.userInput : '\$ ${state.userInput}',
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.end,
        style: TextStyle(
          fontSize: hasError ? 16 : 22,
          height: 1,
          color: hasError ? Colors.red : Colors.black,
        ),
      );
    },
  );
}

Widget buildButtons(BuildContext context) {
  return Container(
    height: MediaQuery.of(context).size.height * 0.35,
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.primary,
    ),
    child: Column(
      children: [
        buildButtonRow(context, 'C', '<', '⨯', '÷'),
        buildButtonRow(context, '7', '8', '9', '+'),
        buildButtonRow(context, '4', '5', '6', '-'),
        buildButtonRow(context, '1', '2', '3', '='),
        buildButtonRow(context, '00', '0', '.', '>'),
      ],
    ),
  );
}

Widget buildButtonRow(
  BuildContext context,
  final String first,
  final String second,
  final String third,
  final String fourth,
) {
  final List row = [first, second, third, fourth];

  return BlocBuilder<RecordFormBloc, RecordFormState>(
    builder: (context, state) {
      return Expanded(
        child: Row(
            children: row
                .map(
                  (text) => ButtonWWidget(
                    text: text,
                    onClicked: text == '>'
                        ? () {
                            Navigator.pop(context);
                            final double doubleResult =
                                double.parse(state.userInput);
                            final int intResult = doubleResult.toInt();
                            BlocProvider.of<RecordFormBloc>(context)
                                .add(AmountEvent(intResult)); //儲存Calculator的值
                          }
                        : () => onClickedButton(context, text),
                  ),
                )
                .toList()),
      );
    },
  );
}

void onClickedButton(BuildContext context, String buttonText) {
  BlocProvider.of<RecordFormBloc>(context).add(CalculatorEvent(buttonText));
}

class ButtonWWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const ButtonWWidget({
    super.key,
    required this.text,
    required this.onClicked,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(
          2,
        ),
        height: double.infinity,
        child: ElevatedButton(
          onPressed: onClicked,
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                24,
              ),
            ),
          ),
          child: buttonViewing(
            text,
          ),
        ),
      ),
    );
  }
}

Widget buttonViewing(String text) {
  switch (text) {
    case '<':
      return const Icon(Icons.backspace_outlined);
    case '>':
      return const Icon(Icons.done);

    default:
      return Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: Utils.isOperator(text, hasEquals: true) ? 28 : 22,
        ),
      );
  }
}

class Utils {
  static bool isOperator(String buttonText, {bool hasEquals = false}) {
    final operators = ['+', '-', '÷', '⨯', '.']..addAll(hasEquals ? ['='] : []);

    return operators.contains(buttonText);
  }

  static bool isOperatorAtEnd(String userInput) {
    if (userInput.isNotEmpty) {
      return Utils.isOperator(userInput.substring(userInput.length - 1));
    } else {
      return false;
    }
  }
}
