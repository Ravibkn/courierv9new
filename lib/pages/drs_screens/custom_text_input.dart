// ignore_for_file: prefer_const_constructors, unnecessary_new, sort_child_properties_last

import 'package:flutter/material.dart';

import '../components/custom_button.dart';

class OTPInput extends StatefulWidget {
  const OTPInput({Key? key}) : super(key: key);

  @override
  State<OTPInput> createState() => _OTPInputState();
}

class _OTPInputState extends State<OTPInput> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Container(
          margin: EdgeInsets.only(right: 25),
          width: 150,
          color: Colors.grey.shade300,
          child: TextFormField(
            decoration: new InputDecoration(
              hintText: 'Enter OTP',
              contentPadding: EdgeInsets.all(8),
              isDense: true,
              border: new OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.grey)),
            ),
          ),
        ),
        CustomButton(
          text: "Submit",
          onTap: () {},
        ),
      ]),
    );
  }
}
