import 'package:expense_manager_app/controller/bottom_tabs/bottom_tabs_bloc.dart';
import 'package:expense_manager_app/controller/home/home_bloc.dart';
import 'package:expense_manager_app/controller/news/news_bloc.dart';
import 'package:expense_manager_app/controller/news/news_event.dart';
import 'package:expense_manager_app/controller/record_form/record_form_bloc.dart';
import 'package:expense_manager_app/controller/record_form/record_form_event.dart';
import 'package:expense_manager_app/controller/record_form/record_form_state.dart';
import 'package:expense_manager_app/controller/report/report_bloc.dart';
import 'package:expense_manager_app/controller/report/report_event.dart';
import 'package:expense_manager_app/models/record.dart';
import 'package:expense_manager_app/pages/bottom_tabs/bottom_tabs_page.dart';
import 'package:expense_manager_app/services/api_news.dart';
import 'package:expense_manager_app/services/api_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialization(null);
  // 設定畫面方向
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(
    const MyApp(),
  );
}

Future initialization(BuildContext? context) async {
  await Future.delayed(const Duration(seconds: 1));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => HomeBloc(ApiRepository())
              ..add(
                const FetchRecordEvent(),
              ) // 初始化Provider完成後就直接先做一個Event
            ),
        BlocProvider(
          create: (_) => RecordFormBloc(
            ApiRepository(),
          )..add(
              const FetchCategoryListEvent(),
            ),
        ),
        BlocProvider(
          create: (_) => ReportBloc(
            ApiRepository(),
          )
            ..add(
              const LoadCategoryStatsEvent(),
            )
            ..add(
              const LoadTrendStatsEvent(),
            ),
        ),
        BlocProvider(
          create: (_) => BottomTabsBloc(),
        ),
        BlocProvider(
          create: (_) => NewsBloc(NewsApi())
            ..add(
              const FetchNewsListEvent(),
            ),
        ),
      ],
      child: BlocListener<RecordFormBloc, RecordFormState>(
        listenWhen: (p, c) =>
            p.filteredIncomeCategoryList != c.filteredIncomeCategoryList ||
            p.filteredExpenseCategoryList != c.filteredExpenseCategoryList,
        listener: (context, state) {
          BlocProvider.of<RecordFormBloc>(context).add(
            InitialEvent(
              RecordData.empty(DateTime.now()),
            ),
          );
        },
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Expense Manager',
          theme: ThemeData(
            splashFactory: NoSplash.splashFactory,
            appBarTheme: const AppBarTheme(
              centerTitle: true,
              titleTextStyle: TextStyle(
                fontSize: 22,
              ),
            ),
            colorScheme:
                ColorScheme.fromSeed(seedColor: Colors.blueGrey).copyWith(
              secondary: const Color.fromARGB(255, 231, 242, 243),
            ),
            useMaterial3: true,
          ),
          home: const BottomTabsPage(),
        ),
      ),
    );
  }
}
