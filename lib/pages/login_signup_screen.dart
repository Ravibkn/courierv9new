// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables, avoid_print, override_on_non_overriding_member, non_constant_identifier_names, use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'package:courierv9/pages/global.dart';
import 'package:courierv9/pages/palette.dart';
import 'package:courierv9/pages/routs.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:hive_flutter/hive_flutter.dart';

class LoginSignUpPage extends StatefulWidget {
  const LoginSignUpPage({Key? key}) : super(key: key);

  @override
  State<LoginSignUpPage> createState() => _LoginSignUpPageState();
}

class _LoginSignUpPageState extends State<LoginSignUpPage> {
  late Future<_LoginSignUpPageState> futureAlbum;

  final _formkey = GlobalKey<FormState>();

  Future<void> movetoHome() async {
    try {
      
      var email = emailController.text;
      var password = passwordController.text;

      if (_formkey.currentState!.validate()) {
        final response = await http.post(
            Uri.parse('${baseUrl}rest_api_native/RestController.php'),
            body: {"view": "login", "email": email, "password": password});
        if (response.statusCode == 200) {
          var result_data = jsonDecode(response.body)['output'];
          if (result_data[0]['error'] == 'No Record found!') {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Please Enter Right Detail!")));
          } else {
            _myBox.put('m_id', result_data[0]['id']);
            _myBox.put('m_email', result_data[0]['email']);
            _myBox.put('m_name', result_data[0]['messenger_name']);
            _myBox.put('m_phone', result_data[0]['mobile']);
            _myBox.put('m_vehicle_number', result_data[0]['vehicle_number']);
            _myBox.put('m_image', result_data[0]['messanger_image']);
            _myBox.put('m_code', result_data[0]['messenger_code']);
            _myBox.put('m_branch', result_data[0]['branch']);
            _myBox.put('m_city', result_data[0]['city']);
            _myBox.put('m_city_name', result_data[0]['city_name']);
            _myBox.put('m_location_id', result_data[0]['location_id']);
            _myBox.put('m_online_offline_status',
                result_data[0]['online_offline_status']);
            _myBox.put('weightType', result_data[0]['weightType']);
            _myBox.put('weightUnit', result_data[0]['unit']);
            _myBox.put('rateType', result_data[0]['rateType']);

            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("Login Successful!")));
            Navigator.pushNamed(context, MyRouts.bottomBarRout);
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Please Enter Right Detail!")));
        }
      }
    } catch (err) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("${err}")));
    }
  }

  TextEditingController emailController =TextEditingController(text: 'pankaj@msg.com');

  TextEditingController passwordController =TextEditingController(text: "password");


  @override
  bool isMale = true;
  bool isSignupScreen = true;
  bool isRememberMe = false;
  String email = "";
  String password = "";
  final _myBox = Hive.box('AppData');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * .4,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/background.jpg"),
                  fit: BoxFit.fill,
                ),
              ),
              child: Container(
                padding: EdgeInsets.only(top: 70, left: 20),
                color: Colors.cyan.withOpacity(.75),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: "Welcome",
                        style: TextStyle(
                          fontSize: 25,
                          letterSpacing: 2,
                          color: Colors.yellow.shade700,
                        ),
                        children: [
                          TextSpan(
                            text: " Back",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.yellow.shade700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Signin to Continue",
                      style: TextStyle(
                        letterSpacing: 1,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          buildButtonHalfContainer(true),
          AnimatedPositioned(
            duration: Duration(milliseconds: 400),
            curve: Curves.linear,
            top: isSignupScreen
                ? MediaQuery.of(context).size.height * .30
                : MediaQuery.of(context).size.height * .40,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 400),
              curve: Curves.linear,
              padding: EdgeInsets.all(20),
              height: isSignupScreen
                  ? MediaQuery.of(context).size.height * .40
                  : MediaQuery.of(context).size.height * .40,
              width: MediaQuery.of(context).size.width - 40,
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 15,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isSignupScreen = true;
                  });
                },
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isSignupScreen = true;
                              });
                            },
                            child: Column(
                              children: [
                                Text(
                                  "LOGIN",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Palette.activeColor),
                                ),
                                if (isSignupScreen)
                                  Container(
                                    margin: EdgeInsets.only(top: 3),
                                    height: 2,
                                    width: 55,
                                    color: Colors.orange,
                                  )
                              ],
                            ),
                          ),
                        ],
                      ),
                      if (isSignupScreen) buildSignimMethad(),
                      // if (!isSignupScreen)
                      if (!isSignupScreen) buildSignimMethad()
                    ],
                  ),
                ),
              ),
            ),
          ),
          buildButtonHalfContainer(false),
        ],
      ),
    );
  }

  Container buildSignimMethad() {
    return Container(
      margin: EdgeInsets.only(top: 30),
      child: Form(
        key: _formkey,
        child: Column(
          children: [
            TextFormField(
              controller: emailController,
              obscureText: false,
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    color: Palette.iconColor,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Palette.textColor1),
                    borderRadius: BorderRadius.all(Radius.circular(35)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Palette.textColor1),
                    borderRadius: BorderRadius.all(Radius.circular(35)),
                  ),
                  contentPadding: EdgeInsets.all(10),
                  hintText: 'Email',
                  hintStyle:
                      TextStyle(fontSize: 14, color: Palette.textColor1)),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Username Cannot Be Empty";
                }
                return null;
              },
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.lock_outline,
                    color: Palette.iconColor,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Palette.textColor1),
                    borderRadius: BorderRadius.all(Radius.circular(35)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Palette.textColor1),
                    borderRadius: BorderRadius.all(Radius.circular(35)),
                  ),
                  contentPadding: EdgeInsets.all(10),
                  hintText: 'Password',
                  hintStyle:
                      TextStyle(fontSize: 14, color: Palette.textColor1)),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Username Cannot Be Empty";
                }
                return null;
              },
            ),
            //buildTextField(Icons.email_outlined, "Email", false, true),
            //buildTextField(Icons.lock_outline, "Password", true, false),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Row(
                //   children: [
                //     Checkbox(
                //         value: isRememberMe,
                //         activeColor: Palette.textColor2,
                //         onChanged: (value) {
                //           setState(() {});
                //           isRememberMe = !isRememberMe;
                //         }),
                //     Text(
                //       "Remember Me",
                //       style: TextStyle(fontSize: 12, color: Palette.textColor1),
                //     )
                //   ],
                // ),
                // TextButton(
                //     onPressed: () {},
                //     child: Text(
                //       "Forgot Password",
                //       style: TextStyle(fontSize: 12, color: Palette.textColor1),
                //     ))
              ],
            )
          ],
        ),
      ),
    );
  }

  Container buildSignupMethad(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: Column(
        children: [
          // buildTextField(Icons.person, "User Name", false, false),
          buildTextField(Icons.email_outlined, "Email", false, true),
          buildTextField(Icons.lock_outline, "Password", true, false),
          Padding(
            padding: const EdgeInsets.only(top: 5, left: 10),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isMale = true;
                    });
                  },
                  child: Row(
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        margin: EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                          color:
                              isMale ? Palette.textColor2 : Colors.transparent,
                          border: Border.all(
                              width: 1,
                              color: isMale
                                  ? Colors.transparent
                                  : Palette.textColor1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Icon(
                          Icons.person,
                          color: isMale ? Colors.white : Palette.iconColor,
                        ),
                      ),
                      Text(
                        "Male",
                        style: TextStyle(color: Palette.textColor1),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isMale = false;
                    });
                  },
                  child: Row(
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        margin: EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                          color:
                              isMale ? Colors.transparent : Palette.textColor2,
                          border: Border.all(
                              width: 1,
                              color: isMale
                                  ? Palette.textColor1
                                  : Colors.transparent),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Icon(
                          Icons.person,
                          color: isMale ? Palette.iconColor : Colors.white,
                        ),
                      ),
                      Text(
                        "Female",
                        style: TextStyle(color: Palette.textColor1),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            width: 200,
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * .030),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text: "By Prassing 'Submit' you agree to our ",
                  style: TextStyle(color: Palette.textColor2),
                  children: [
                    TextSpan(
                      text: "term & conditions",
                      style: TextStyle(color: Colors.orange),
                    )
                  ]),
            ),
          )
        ],
      ),
    );
  }

  TextButton buildTextbutton(
    IconData icon,
    String title,
    Color backgroundcolor,
  ) {
    return TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(
          side: BorderSide(width: 1, color: Colors.grey),
          minimumSize: Size(155, 40),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: backgroundcolor),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.white,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget buildButtonHalfContainer(bool showShadow) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 400),
      curve: Curves.linear,
      top: MediaQuery.of(context).size.height * .63,
      right: 0,
      left: 0,
      child: Center(
        child: Container(
          height: 90,
          width: 90,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              if (showShadow)
                BoxShadow(
                  color: Colors.black.withOpacity(.3),
                  spreadRadius: 1.5,
                  blurRadius: 10,
                  offset: Offset(0, 1),
                ),
            ],
          ),
          child: !showShadow
              ? InkWell(
                  onTap: () {
                    movetoHome();
                    // Navigator.pushNamed(context, MyRouts.bottomBarRout);
                    // print("Joshi");
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.orange.shade200,
                            Colors.orange.shade400,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(.3),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: Offset(0, 1),
                          ),
                        ]),
                    child: Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                  ),
                )
              : Center(),
        ),
      ),
    );
  }

  Padding buildTextField(
      IconData icon, String hintText, bool isPassword, bool isEmail) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextField(
        obscureText: isPassword,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
        decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
              color: Palette.iconColor,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Palette.textColor1),
              borderRadius: BorderRadius.all(Radius.circular(35)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Palette.textColor1),
              borderRadius: BorderRadius.all(Radius.circular(35)),
            ),
            contentPadding: EdgeInsets.all(10),
            hintText: hintText,
            hintStyle: TextStyle(fontSize: 14, color: Palette.textColor1)),
      ),
    );
  }
}
