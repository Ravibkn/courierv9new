// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Material(color:Color.fromRGBO(250, 145, 46, 0.973),
      child: Column(
        children: [SizedBox(height: 70,),
        Image.asset('images/logo.png'),
        SizedBox(height:50,),
        Padding(
          padding: const EdgeInsets.symmetric(vertical:10,horizontal:20),
          child: Column(
            children: [
              TextFormField(decoration: InputDecoration(hintText:'Enter User Name',labelText:'User Name',),),
              ElevatedButton(onPressed: (){}, child: Text('Submit'))
            ],
          ),
        )
      ]),
    );
  }
} 
