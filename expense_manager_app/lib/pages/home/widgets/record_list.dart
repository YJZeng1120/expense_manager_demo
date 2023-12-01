import 'package:expense_manager_app/functions/record_utils.dart';
import 'package:expense_manager_app/models/category.dart';
import 'package:expense_manager_app/models/enums/record_type_enum.dart';
import 'package:expense_manager_app/models/record.dart';
import 'package:expense_manager_app/pages/home/widgets/record_item.dart';
import 'package:flutter/material.dart';

class RecordList extends StatelessWidget {
  const RecordList({
    super.key,
    required this.records,
    required this.categoryList,
  });
  final List<RecordData> records;
  final List<Category> categoryList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: records.length,
      itemBuilder: (context, index) {
        final int reverseIndex = records.length - 1 - index;
        final RecordData reverseRecord = records[reverseIndex];

        final int reverseCategoryIndex = reverseRecord.recordCategoryId - 1;
        final Category reverseCategory = categoryList[reverseCategoryIndex];

        return RecordItem(
          amountDisplay: Text(
            reverseRecord.recordType == RecordType.expense
                ? "\$-${numberFormatter.format(reverseRecord.amount)}"
                : "\$${numberFormatter.format(reverseRecord.amount)}",
            style: TextStyle(
              fontSize: 20,
              color: reverseRecord.recordType == RecordType.expense
                  ? Colors.red
                  : Colors.blue,
            ),
          ),
          record: reverseRecord,
          icon: reverseCategory.icon,
          iconColor: reverseCategory.iconColor,
        );
      },
    );
  }
}
