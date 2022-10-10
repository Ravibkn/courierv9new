// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:io';
import 'package:courierv9/pages/style_constent.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../components/custom_button.dart';


class PhotoPage extends StatefulWidget {
  const PhotoPage({Key? key}) : super(key: key);

  @override
  State<PhotoPage> createState() => _PhotoPageState();
}

class _PhotoPageState extends State<PhotoPage> {
  File? image;
  Future _openGallary(BuildContext context) async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return Navigator.of(context).pop();

    final imageTemporary = File(image.path);

    setState(() {
      this.image = imageTemporary;
    });
    Navigator.of(context).pop();
  }

  Future _openCamera(BuildContext context) async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) return Navigator.of(context).pop();

    final imageTemporary = File(image.path);

    setState(() {
      this.image = imageTemporary;
    });
    Navigator.of(context).pop();
  }

  Future<void> _showChooseDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Make a Choise"),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  GestureDetector(
                    child: Text("Gallary"),
                    onTap: () {
                      _openGallary(context);
                    },
                  ),
                  Padding(padding: EdgeInsets.all(8)),
                  GestureDetector(
                    child: Text("Camera"),
                    onTap: () {
                      _openCamera(context);
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  // Widget _desideImageView(BuildContext context) {
  //   if (imageFile == null) {
  //     return Text("No Image Selected");
  //   } else {
  //     return Image.file(
  //       imageFile!,
  //       width: 350,
  //       height: 250,
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.cyan,
          title: Center(
            child: Text(
              "Take Photo",
              style: mTextStyleHeader,
            ),
          )),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 400,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300, width: 2),
                color: Colors.white,
                borderRadius: BorderRadius.circular(17)),
            child: Column(
              children: [
                Container(
                  width: 400,
                  height: 35,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                            15,
                          ),
                          topRight: Radius.circular(15))),
                  child: Center(
                      child: Text(
                    "Photo Preview",
                    style: mTextStyle2,
                  )),
                ),
                Container(
                  color: Colors.white,
                  height: 300,
                  child: image != null
                      ? Image.file(image!)
                      : Text("No Image Selected"),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomButton(text: "Save", onTap: () async {}),
            CustomButton(text: "Reset", onTap: () async {})
          ],
        ),
        SizedBox(
          height: 10,
        ),
        CustomButton(
          text: "Take Photo",
          onTap: () {
            _showChooseDialog(context);
          },
        ),
        SizedBox(
          height: 10,
        ),
      ]),
    );
  }
}
