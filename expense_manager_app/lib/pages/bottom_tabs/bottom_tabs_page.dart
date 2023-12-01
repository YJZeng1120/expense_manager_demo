import 'package:expense_manager_app/pages/bottom_tabs/widgets/build_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controller/bottom_tabs/bottom_tabs_bloc.dart';
import '../../controller/bottom_tabs/bottom_tabs_event.dart';
import '../../controller/bottom_tabs/bottom_tabs_state.dart';
import '../../controller/report/report_bloc.dart';
import '../../controller/report/report_event.dart';

class BottomTabsPage extends StatelessWidget {
  const BottomTabsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomTabsBloc, BottomTabsState>(
      builder: (context, state) {
        return Scaffold(
          body: buildPage(
            state.index,
          ),
          bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: Theme.of(context).colorScheme.primary,
              currentIndex: state.index,
              onTap: (value) {
                context.read<BottomTabsBloc>().add(IndexEvent(value));
                if (value == 1) {
                  context.read<ReportBloc>()
                    ..add(const LoadCategoryStatsEvent())
                    ..add(const LoadTrendStatsEvent())
                    ..add(const SelectedButtonEvent(0))
                    ..add(const IsViewingExpenseEvent());
                }
              },
              items: const [
                BottomNavigationBarItem(
                  label: "Home",
                  icon: Icon(
                    Icons.account_balance,
                  ),
                ),
                BottomNavigationBarItem(
                  label: "Report",
                  icon: Icon(Icons.pie_chart),
                ),
                BottomNavigationBarItem(
                  label: "News",
                  icon: Icon(Icons.newspaper),
                ),
              ]),
        );
      },
    );
  }
}
