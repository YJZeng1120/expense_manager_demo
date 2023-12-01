import 'package:expense_manager_app/controller/home/home_bloc.dart';
import 'package:expense_manager_app/controller/record_form/record_form_bloc.dart';
import 'package:expense_manager_app/controller/record_form/record_form_event.dart';
import 'package:expense_manager_app/controller/record_form/record_form_state.dart';
import 'package:expense_manager_app/models/record.dart';
import 'package:expense_manager_app/pages/record_form/record_form_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecordItem extends StatelessWidget {
  const RecordItem({
    super.key,
    required this.record,
    required this.iconColor,
    required this.icon,
    required this.amountDisplay,
  });
  final RecordData record;
  final Color iconColor;
  final IconData icon;
  final Text amountDisplay;

  @override
  Widget build(BuildContext context) {
    List<Widget> titleList = record.note != ""
        ? [
            Text(
              record.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Text(
              record.note,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 16,
              ),
            ),
          ]
        : [
            Container(
              margin: const EdgeInsets.symmetric(
                vertical: 12,
              ),
              child: Text(
                record.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ];
    return BlocBuilder<RecordFormBloc, RecordFormState>(
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.symmetric(
            vertical: 4,
          ),
          child: ListTile(
            onTap: () {
              BlocProvider.of<RecordFormBloc>(context)
                  .add(InitialEvent(record));
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
            },
            contentPadding: const EdgeInsets.all(0),
            leading: CircleAvatar(
              radius: 30,
              backgroundColor: iconColor,
              child: Icon(
                icon,
                size: 30,
              ),
            ),
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: titleList,
            ),
            trailing: amountDisplay,
          ),
        );
      },
    );
  }
}
