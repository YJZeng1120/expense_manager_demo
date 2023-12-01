import 'package:expense_manager_app/functions/record_type_converter.dart';
import 'package:expense_manager_app/models/enums/record_type_enum.dart';
import 'package:flutter/material.dart';

class Category {
  Category({
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.recordType,
    this.id,
  });

  final String title;
  final IconData icon;
  final Color iconColor;
  final RecordType recordType;
  int? id;

  Map<String, dynamic> toJson() {
    int colorValue = iconColor.value;
    return {
      "title": title,
      "icon": icon.codePoint,
      "iconColor": colorValue,
      "recordType": recordType.name, //
    };
  }

  factory Category.fromJson(Map<String, dynamic> map) {
    return Category(
      title: map["title"],
      icon: IconData(map["icon"], fontFamily: 'MaterialIcons'),
      iconColor: Color(map["iconColor"]),
      recordType: recordTypeConverter(map["recordType"]), //
      id: map["id"],
    );
  }
}

//expense
Category foodCategory = Category(
  title: "food",
  icon: Icons.restaurant,
  iconColor: const Color.fromARGB(255, 243, 125, 104),
  recordType: RecordType.expense,
);

Category learningCategory = Category(
  title: "learning",
  icon: Icons.menu_book,
  iconColor: const Color.fromARGB(255, 255, 194, 103),
  recordType: RecordType.expense,
);

Category shoppingCategory = Category(
  title: "shopping",
  icon: Icons.shopping_bag,
  iconColor: const Color.fromARGB(255, 249, 137, 209),
  recordType: RecordType.expense,
);

Category leisureCategory = Category(
  title: "leisure",
  icon: Icons.theaters,
  iconColor: const Color.fromARGB(255, 213, 156, 255),
  recordType: RecordType.expense,
);

Category travelCategory = Category(
  title: "travel",
  icon: Icons.airplanemode_active,
  iconColor: const Color.fromARGB(255, 100, 221, 191),
  recordType: RecordType.expense,
);

Category workCategory = Category(
  title: "work",
  icon: Icons.work,
  iconColor: const Color.fromARGB(255, 133, 179, 201),
  recordType: RecordType.expense,
);

//income
Category salaryCategory = Category(
  title: "salary",
  icon: Icons.monetization_on,
  iconColor: const Color.fromARGB(255, 201, 169, 133),
  recordType: RecordType.income,
);

Category bonusCategory = Category(
  title: "bonus",
  icon: Icons.savings,
  iconColor: const Color.fromARGB(255, 216, 190, 75),
  recordType: RecordType.income,
);

Category investmentCategory = Category(
  title: "investment",
  icon: Icons.candlestick_chart,
  iconColor: const Color.fromARGB(255, 221, 204, 46),
  recordType: RecordType.income,
);
