// ignore_for_file: use_build_context_synchronously, avoid_print, unnecessary_brace_in_string_interps, non_constant_identifier_names, sort_child_properties_last, prefer_const_constructors, sized_box_for_whitespace

import 'dart:convert';
import 'dart:io';
import 'package:courierv9/pages/components/custom_button.dart';
import 'package:courierv9/pages/global.dart';
import 'package:courierv9/pages/profile.dart';
import 'package:courierv9/pages/routs.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({Key? key}) : super(key: key);

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
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

  @override
  void initState() {
    super.initState();
    passwordControlar = TextEditingController();
  }

  TextEditingController passwordControlar = TextEditingController();

  Future<void> moveTo(BuildContext context) async {
    try {
      var password = passwordControlar.text;
      var m_id = _myBox.get('m_id');
      if (_finalkey.currentState!.validate()) {
        final response = await http.post(
            Uri.parse('${baseUrl}rest_api_native/RestController.php'),
            body: {
              "view": "updatePassword",
              "password": password,
              "id": m_id,
              "confirm_password": confirmPassword,
            });
        if (response.statusCode == 200) {
          Navigator.pushNamed(context, MyRouts.loginRout);
          var resultData = jsonDecode(response.body)['output'];
          print(response.body);
          if (resultData[0]['error'] == 'No Record found!') {}
        }
      }
    } catch (err) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("${err}")));
    }
  }

  final _finalkey = GlobalKey<FormState>();
  String password = "";
  String confirmPassword = "";
  final _myBox = Hive.box('AppData');

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double horizontalPadding = size.width * 0.1;
    double verticalPadding = size.width * 0.25;

    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Form(
            key: _finalkey,
            child: Column(
              children: [
                CustomPaint(
                  child: Stack(
                    children: [
                      Container(
                        width: 400,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 120),
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 65,
                            child: CircleAvatar(
                              backgroundImage:
                                  AssetImage("images/background.jpg"),
                              radius: 60,
                            ),
                          ),
                        ),
                      ),
                      // Container(
                      //   width: 400,
                      //   child: Padding(
                      //     padding: EdgeInsets.only(top: 120),
                      //     child: CircleAvatar(
                      //       child: CircleAvatar(
                      //         child: image != null
                      //             ? Image.file(image!)
                      //             : Text(
                      //                 "R",
                      //                 style: mTextStyleHeader,
                      //               ),
                      //         backgroundColor: Colors.cyan,
                      //         radius: 55,
                      //       ),
                      //       backgroundColor: Colors.white,
                      //       radius: 60,
                      //     ),
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.only(left: 210, top: 190),
                        child: InkWell(
                          onTap: () {
                            _showChooseDialog(context);
                            print("object");
                          },
                          child: CircleAvatar(
                            radius: 23,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor:
                                  Color.fromARGB(255, 76, 187, 202),
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  painter: HeaderCurvedContainer(),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 30, left: 30),
                  child: TextFormField(
                    controller: passwordControlar,
                    onChanged: (value) {
                      password = value;
                      print(password);
                    },
                    decoration: InputDecoration(
                      labelText: "Password",
                      fillColor: Colors.grey.shade100,
                      filled: true,
                      contentPadding:
                          const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      hintStyle: const TextStyle(
                          fontSize: 15.0, color: Colors.black54),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0)),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Input Some Text";
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 30, left: 30),
                  child: TextFormField(
                    onChanged: (value) {
                      confirmPassword = value;
                      print(value);
                    },
                    decoration: InputDecoration(
                      labelText: "Confirm Password",
                      fillColor: Colors.grey.shade100,
                      filled: true,
                      contentPadding:
                          const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      hintStyle: const TextStyle(
                          fontSize: 15.0, color: Colors.black54),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0)),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "InPut Some Text";
                      } else if (value != password) {
                        return "Password Not Match";
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                    text: "Update",
                    onTap: () {
                      moveTo(context);
                    })
              ],
            ),
          )
        ],
      ),
    );
  }
}
