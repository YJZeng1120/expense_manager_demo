import 'package:expense_manager_app/controller/bottom_tabs/bottom_tabs_event.dart';
import 'package:expense_manager_app/controller/bottom_tabs/bottom_tabs_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomTabsBloc extends Bloc<BottomTabsEvent, BottomTabsState> {
  BottomTabsBloc() : super(BottomTabsState()) {
    _onEvent();
  }

  void _onEvent() {
    on<IndexEvent>((event, emit) {
      emit(state.copyWith(index: event.index));
    });
  }
}
