// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../style_constent.dart';

class CustomContenar extends StatefulWidget {
  final String text;
  final String image;
  final String path;

  const CustomContenar({
    Key? key,
    required this.text,
    required this.image,
    required this.path
  }) : super(key: key);

  @override
  State<CustomContenar> createState() => _CustomContenarState();
}

class _CustomContenarState extends State<CustomContenar> {

 
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          // ignore: sort_child_properties_last
          child: Column(
            children: [
              
              Container(
                width: 400,
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(
                          15,
                        ),
                        topRight: Radius.circular(15))),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        widget.text,
                        style: mTextStyle2,
                      )
                    ],
                  ),
                ),
              ),
              
              // Image.network("${widget.path}/${widget.image}"),
            ],
          ),
          height: 350,
          width: 400,
          decoration: BoxDecoration(image: DecorationImage(image: NetworkImage("${widget.path}/${widget.image}"),
          fit: BoxFit.fitHeight,
          ),
              border: Border.all(color: Colors.grey.shade300, width: 2),
              color: Colors.white,
              borderRadius: BorderRadius.circular(17)),
        ),);
  }
}
