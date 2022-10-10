// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class DropDownResedule extends StatefulWidget {
  const DropDownResedule({Key? key}) : super(key: key);

  @override
  State<DropDownResedule> createState() => _DropDownReseduleState();
}

class _DropDownReseduleState extends State<DropDownResedule> {
  final items = [
    'Select Reasion',
    'On Customer Request',
    'Shipment Not Ready',
    'Shipment Not Hand Over By Seller',
    'The Seller Not allow To Chack Shipment',
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
