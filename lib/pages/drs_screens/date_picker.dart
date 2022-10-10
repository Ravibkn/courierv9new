// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import '../components/custom_button.dart';

class DatePickker extends StatefulWidget {
  const DatePickker({Key? key}) : super(key: key);

  @override
  State<DatePickker> createState() => _DatePickkerState();
}

class _DatePickkerState extends State<DatePickker> {
  DateTime date = DateTime(2022, 12, 24);
  @override
  Widget build(BuildContext context) {
    return
        // ElevatedButton(
        //   style: ButtonStyle(
        //       backgroundColor: MaterialStateProperty.all(Colors.cyan),
        //       minimumSize: MaterialStateProperty.all(
        //         Size(100, 40),
        //       ),
        //       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        //           RoundedRectangleBorder(
        //               borderRadius: BorderRadius.circular(20),
        //               side: BorderSide(color: Colors.grey.shade300)))),
        //   onPressed: () async {
        //     DateTime? newDate = await showDatePicker(
        //         context: context,
        //         initialDate: date,
        //         firstDate: DateTime(1900),
        //         lastDate: DateTime(2100));
        //     if (newDate == null) return;
        //     setState(() {
        //       date = newDate;
        //     });
        //   },
        //   child: Row(
        //     mainAxisSize: MainAxisSize.min,
        //     children: [
        //       Icon(
        //         Icons.calendar_month_outlined,
        //         size: 24.0,
        //       ),
        //       SizedBox(
        //         width: 5,
        //       ),
        //       Text('${date.year}/${date.month}/${date.day}'),
        //     ],
        //   ),
        // );
        CustomButton(
      text: '${date.year}/${date.month}/${date.day}',
      onTap: () async {
        DateTime? newDate = await showDatePicker(
            context: context,
            initialDate: date,
            firstDate: DateTime(1900),
            lastDate: DateTime(2100));
        if (newDate == null) return;
        setState(() {
          date = newDate;
        });
      },
    );
  }
}
