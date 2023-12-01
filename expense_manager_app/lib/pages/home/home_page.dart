import 'package:expense_manager_app/controller/home/home_bloc.dart';
import 'package:expense_manager_app/models/enums/load_status_enum.dart';
import 'package:expense_manager_app/pages/home/widgets/calc_record.dart';
import 'package:expense_manager_app/pages/home/widgets/home_calendar.dart';
import 'package:expense_manager_app/pages/home/widgets/home_page_appbar.dart';
import 'package:expense_manager_app/pages/home/widgets/open_add_record.dart';
import 'package:expense_manager_app/pages/home/widgets/record_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: homePageAppBar(
            context,
            openAddRecord: () => openAddRecord(context),
          ),
          body: state.status == LoadStatus.inProgress
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        const HomeCalendar(),
                        GestureDetector(
                          onTap: () {
                            BlocProvider.of<HomeBloc>(context)
                              ..add(
                                SelectedDayEvent(DateTime.now()),
                              )
                              ..add(
                                const FilterRecordListEvent(),
                              );
                          },
                          child: Container(
                            width: 110,
                            height: 50,
                            color: Colors.transparent,
                          ),
                        )
                      ],
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            const ClacRecord(),
                            const SizedBox(
                              height: 20,
                            ),
                            Expanded(
                              child: RecordList(
                                records: state.filterRecordList,
                                categoryList: state.categoryList,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
