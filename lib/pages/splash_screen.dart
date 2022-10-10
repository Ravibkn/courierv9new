// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, avoid_print

import 'package:courierv9/pages/bottom_navigation_bar.dart';
import 'package:courierv9/pages/home_page.dart';
import 'package:courierv9/pages/login_signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final _myBox = Hive.box('AppData');
  @override
  void initState() {
    super.initState();
    _navigatetologin();
    // var m_id =  _myBox.get('m_id');
  }

  _navigatetologin() async {
    await Future.delayed(Duration(milliseconds: 10000), () {});
   // print(_myBox.get('m_id'));
    if (_myBox.get('m_id') != null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => NavBar()));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginSignUpPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.cyan,
          body: Column(
            children: [
              SizedBox(
                height: 100,
              ),
              Container(
                  color: Colors.transparent,
                  child: Image.asset(
                    "images/logo.png",
                  )),
              Center(
                child: Lottie.asset("images/splash_screen.json"),
              )
            ],
          )),
    );
  }
}
