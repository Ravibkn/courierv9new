// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import '../components/custom_button.dart';
import '../routs.dart';
import 'package:flutter/material.dart';

import '../style_constent.dart';
import 'custom_text_input.dart';

enum Auth { otp, boyrisk }

class Verifay extends StatefulWidget {
  const Verifay({Key? key}) : super(key: key);

  @override
  State<Verifay> createState() => _VerifayState();
}

class _VerifayState extends State<Verifay> {
  Auth _auth = Auth.otp;
  final _otpFormKey = GlobalKey<FormState>();
  final _boyFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 10, right: 10),
      child: Container(
        // ignore: sort_child_properties_last
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
                "Verified By",
                style: mTextStyle2,
              )),
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Row(
                      children: [
                        Radio(
                            value: Auth.otp,
                            activeColor: Colors.cyan,
                            groupValue: _auth,
                            onChanged: (Auth? val) {
                              setState(() {
                                _auth = val!;
                              });
                            }),
                        Expanded(
                          child: Text(
                            'Verified By OTP',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
                    )),
                    Expanded(
                      child: Row(
                        children: [
                          Radio(
                              value: Auth.boyrisk,
                              activeColor: Colors.cyan,
                              groupValue: _auth,
                              onChanged: (Auth? val) {
                                setState(() {
                                  _auth = val!;
                                });
                              }),
                          Expanded(
                            child: Text(
                              'On Driver Boy Risk',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                if (_auth == Auth.otp)
                  Form(key: _otpFormKey, child: OTPInput()),
                if (_auth == Auth.boyrisk)
                  Form(
                    key: _boyFormKey,
                    child: CustomButton(
                        text: "Update Drs",
                        onTap: () {
                          Navigator.pushNamed(context, MyRouts.updateDrsRout);
                        }),
                  ),
              ],
            )
          ],
        ),
        height: 160,
        width: 400,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300, width: 2),
            color: Colors.white,
            borderRadius: BorderRadius.circular(17)),
      ),
    );
  }
}
