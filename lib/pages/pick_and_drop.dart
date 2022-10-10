// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class PickAndDrop extends StatefulWidget {
  const PickAndDrop({Key? key}) : super(key: key);

  @override
  State<PickAndDrop> createState() => _PickAndDropState();
}

class _PickAndDropState extends State<PickAndDrop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Center(
            child: const Padding(
          padding: EdgeInsets.only(right: 40.0),
          child: Text(
            "Pick & Drop",
            style: TextStyle(
              shadows: <Shadow>[
                Shadow(
                  offset: Offset(2.0, 2.0),
                  blurRadius: 3.0,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
                Shadow(
                  offset: Offset(2.0, 2.0),
                  blurRadius: 8.0,
                  color: Color.fromARGB(124, 94, 94, 107),
                ),
              ],
              color: Colors.white,
            ),
          ),
        )),
      ),
    );
  }
}
