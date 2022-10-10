// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class PickDropHistory extends StatefulWidget {
  const PickDropHistory({Key? key}) : super(key: key);

  @override
  State<PickDropHistory> createState() => _PickDropHistoryState();
}

class _PickDropHistoryState extends State<PickDropHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Center(
            child: const Padding(
          padding: EdgeInsets.only(right: 40.0),
          child: Text(
            "Pick N History",
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
