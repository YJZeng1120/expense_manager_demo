import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../controller/home/home_bloc.dart';
import '../../../controller/record_form/record_form_bloc.dart';
import '../../../controller/record_form/record_form_event.dart';
import '../../../models/enums/record_type_enum.dart';
import '../../../models/record.dart';
import '../../record_form/record_form_page.dart';

void openAddRecord(BuildContext context) {
  HomeState homeState = context.read<HomeBloc>().state;
  BlocProvider.of<RecordFormBloc>(context)
    ..add(RecordTypeEvent(RecordType.expense))
    ..add(
      InitialEvent(
        RecordData.empty(homeState.selectedDay), //按add record時也能抓到選擇的日期
      ),
    );
  

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const RecordFormPage(),
    ),
  ).then(
    (value) => context.read<HomeBloc>().add(
          const FetchRecordEvent(),
        ),
  );
}
