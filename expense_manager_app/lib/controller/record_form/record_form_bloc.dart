import 'package:expense_manager_app/controller/record_form/record_form_event.dart';
import 'package:expense_manager_app/controller/record_form/record_form_state.dart';
import 'package:expense_manager_app/models/category.dart';
import 'package:expense_manager_app/models/enums/load_status_enum.dart';
import 'package:expense_manager_app/models/enums/record_type_enum.dart';
import 'package:expense_manager_app/pages/record_form/widgets/calculator_keyboard.dart';
import 'package:expense_manager_app/services/api_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_expressions/math_expressions.dart';

class RecordFormBloc extends Bloc<RecordFormEvent, RecordFormState> {
  final ApiRepository _apiRepository;
  RecordFormBloc(this._apiRepository) : super(RecordFormState()) {
    _onEvent();
  } //初始化

  void _onEvent() {
    on<InitialEvent>(
      (event, emit) {
        final bool isEditing = event.record.id != null;

        emit(
          state.copyWith(
              isEditing: isEditing,
              id: event.record.id,
              title: event.record.title,
              amount: event.record.amount,
              date: event.record.date,
              note: event.record.note,
              recordType: event.record.recordType,
              recordCategoryId: isEditing
                  ? event.record.recordCategoryId
                  : state.recordType == RecordType.expense
                      ? state.filteredExpenseCategoryList.first.id
                      : state.filteredIncomeCategoryList.first.id,
              userInput: isEditing ? event.record.amount.toString() : '0'),
        );
      },
    );

    on<TitleEvent>((event, emit) {
      emit(state.copyWith(title: event.title));
    });

    on<AmountEvent>((event, emit) {
      emit(state.copyWith(amount: event.amount));
    });

    on<DateEvent>((event, emit) {
      emit(state.copyWith(date: event.date));
    });

    on<RecordTypeEvent>((event, emit) {
      emit(state.copyWith(recordType: event.recordType));
    });

    on<NoteEvent>((event, emit) {
      emit(state.copyWith(note: event.note));
    });

    on<RecordCategoryEvent>((event, emit) {
      emit(state.copyWith(recordCategoryId: event.recordCategoryId));
    });

    on<FetchCategoryListEvent>(
      (event, emit) async {
        final categoryList = await _apiRepository.loadCategories();
        late List<Category> filteredExpenseList;
        late List<Category> filteredIncomeList;

        filteredExpenseList = categoryList
            .where((element) => element.recordType == RecordType.expense)
            .toList();

        filteredIncomeList = categoryList
            .where((element) => element.recordType == RecordType.income)
            .toList();

        emit(
          state.copyWith(
            filteredExpenseCategoryList: filteredExpenseList,
            filteredIncomeCategoryList: filteredIncomeList,
          ),
        );
      },
    );

    on<CalculatorEvent>((event, emit) {
      String append(String buttonText) {
        if (Utils.isOperator(buttonText) &&
            Utils.isOperatorAtEnd(state.userInput)) {
          final newUserInput =
              state.userInput.substring(0, state.userInput.length - 1);
          return newUserInput + buttonText;
        } else {
          return state.userInput == '0'
              ? Utils.isOperator(buttonText)
                  ? '0'
                  : buttonText
              : state.userInput + buttonText;
        }
      }

      String calculateResult() {
        final String expression =
            state.userInput.replaceAll('⨯', '*').replaceAll('÷', '/');
        try {
          final Expression exp = Parser().parse(expression);
          final ContextModel model = ContextModel();
          final String result = '${exp.evaluate(EvaluationType.REAL, model)}';

          final double doubleResult = double.parse(result);
          final int intResult = doubleResult.toInt();
          final String finalResult = intResult.toString();
          return finalResult;
        } catch (e) {
          return 'Error: Invalid expression';
        }
      }

      String delete() {
        if (state.userInput.length > 1) {
          final String deleteUserInput =
              state.userInput.substring(0, state.userInput.length - 1);
          return deleteUserInput;
        }
        return '0';
      }

      late String userInput = '';

      switch (event.userInput) {
        case 'C':
          userInput = '0';
        case '=':
          userInput = calculateResult();

        case '<':
          userInput = delete();

          break;

        default:
          userInput = append(event.userInput);
      }

      emit(state.copyWith(
        userInput: userInput,
      ));
    });

    on<SaveEvent>((event, emit) async {
      late bool result;
      emit(state.copyWith(status: LoadStatus.inProgress));

      if (state.isEditing) {
        result = await _apiRepository.updateRecord(
          state.id ?? "",
          state.title,
          state.amount,
          state.date,
          state.recordType,
          state.note,
          state.recordCategoryId,
        );
      } else {
        result = await _apiRepository.addRecord(
          state.title,
          state.amount,
          state.date,
          state.recordType,
          state.note,
          state.recordCategoryId,
        );
      }

      if (result) {
        emit(state.copyWith(status: LoadStatus.succeed));
      } else {
        emit(state.copyWith(status: LoadStatus.failed));
      }
    });

    on<DeleteEvent>((event, emit) async {
      final String deleteId = state.id ?? "";
      await _apiRepository.deleteRecord(deleteId);
    });
  }
}
