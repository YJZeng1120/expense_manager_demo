import 'package:expense_manager_app/pages/home/home_page.dart';
import 'package:expense_manager_app/pages/report/report_page.dart';
import 'package:flutter/material.dart';

import '../../news/news_page.dart';

Widget buildPage(int index) {
  List<Widget> page = [
    const HomePage(),
    const ReportPage(),
    const NewsPage(),
  ];

  return page[index];
}
