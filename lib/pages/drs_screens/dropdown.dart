// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class DropDown extends StatefulWidget {
  const DropDown({Key? key}) : super(key: key);

  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  final items = [
    'Select Reasion',
    'Miss-Routed',
    'Customer Not Response',
    'Cash Not Ready',
    'Mobile Number Not Valid',
    'Customer Refused To Accept',
    'Reschedule'
  ];
  String? selectedItem = 'Select Reasion';
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(40),
      child: DropdownButton<String>(
        isExpanded: true,
        underline: DropdownButtonHideUnderline(child: Container()),
        borderRadius: BorderRadius.circular(15),
        value: selectedItem,
        items: items
            .map((item) => DropdownMenuItem(
                value: item,
                child: Text(
                  item,
                  style: TextStyle(fontSize: 15),
                )))
            .toList(),
        onChanged: (item) {
          setState(() {
            selectedItem = item;
          });
        },
      ),
    );
  }
}
