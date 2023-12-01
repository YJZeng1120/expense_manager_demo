import 'package:expense_manager_app/controller/report/report_bloc.dart';
import 'package:expense_manager_app/controller/report/report_event.dart';
import 'package:expense_manager_app/controller/report/report_state.dart';
import 'package:expense_manager_app/models/enums/load_status_enum.dart';
import 'package:expense_manager_app/pages/report/widgets/report_page_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/bar_chart/bar_chart_view.dart';
import 'widgets/pie_chart/pie_chart_view.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ReportBloc, ReportState>(
      listenWhen: (p, c) => p.selectedButtonIndex != c.selectedButtonIndex,
      listener: (context, state) {
        BlocProvider.of<ReportBloc>(context).add(const IsViewingExpenseEvent());
      },
      child: BlocBuilder<ReportBloc, ReportState>(
        builder: (context, state) {
          return DefaultTabController(
            initialIndex: 0,
            length: 2,
            child: Builder(
              builder: (context) {
                final TabController tabController =
                    DefaultTabController.of(context);
                tabController.addListener(() {
                  if (tabController.index == 0) {
                    BlocProvider.of<ReportBloc>(context)
                        .add(const SelectedButtonEvent(0));
                  }
                });
                return Scaffold(
                  appBar: reportPageAppBar(context),
                  body: TabBarView(children: [
                    SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: state.categoryStatus != LoadStatus.succeed
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : const PieChartView(),
                    ),
                    SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: state.status != LoadStatus.succeed
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : const BarChartView(),
                    ),
                  ]),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
