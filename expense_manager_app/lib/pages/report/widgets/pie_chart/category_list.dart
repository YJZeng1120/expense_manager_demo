import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../controller/report/report_bloc.dart';
import '../../../../controller/report/report_state.dart';
import '../../../../functions/record_utils.dart';
import '../../../../models/category.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportBloc, ReportState>(
      builder: (context, state) {
        bool isExpense = state.isViewingExpense;
        Map<int, int> mapType = isExpense
            ? state.sumExpenseByCategoryMap
            : state.sumIncomeByCategoryMap;
        return Column(
          children: [
            ...mapType.entries.map(
              (e) {
                Category selectedCategory = state.categoryList[e.key - 1];
                return Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 12,
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: selectedCategory.iconColor,
                        child: Icon(
                          selectedCategory.icon,
                          size: 20,
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Text(
                        selectedCategory.title.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        isExpense
                            ? "\$-${numberFormatter.format(e.value)}"
                            : "\$ ${numberFormatter.format(e.value)}",
                        style: TextStyle(
                          fontSize: 16,
                          color: isExpense ? Colors.red : Colors.blue,
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
