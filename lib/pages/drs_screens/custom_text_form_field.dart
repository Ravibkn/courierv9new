// ignore_for_file: public_member_api_docs, sort_constructors_first, body_might_complete_normally_nullable
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  const CustomTextFormField({
    Key? key,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hintText,
        fillColor: Colors.grey.shade300,
        filled: true,
        contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        hintStyle: const TextStyle(fontSize: 15.0, color: Colors.black54),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
      validator: (val) {},
    );
  }
}
