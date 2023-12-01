import 'package:flutter/material.dart';

Widget noRecordData(BuildContext context) {
  return SizedBox(
    height: MediaQuery.of(context).size.height * 0.5,
    child: const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.edit_note,
          size: 50,
          color: Colors.black54,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "No Record Data",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black54,
          ),
        )
      ],
    ),
  );
}
