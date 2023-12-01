import 'package:flutter/material.dart';

AppBar reportPageAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Theme.of(context).colorScheme.primary,
    title: const Text(
      "Report",
    ),
    bottom: TabBar(
      unselectedLabelColor:
          Theme.of(context).colorScheme.onPrimary.withOpacity(0.6),
      labelColor: Theme.of(context).colorScheme.onPrimary,
      labelStyle: const TextStyle(
        fontSize: 16,
      ),
      indicatorColor: Colors.greenAccent.shade400,
      indicatorWeight: 2,
      indicatorSize: TabBarIndicatorSize.tab,
      tabs: const [
        Tab(
          text: "Category",
        ),
        Tab(
          text: "Trend",
        )
      ],
    ),
  );
}
