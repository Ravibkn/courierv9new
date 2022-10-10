// ignore_for_file: sort_child_properties_last, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_init_to_null, non_constant_identifier_names, avoid_print, unnecessary_brace_in_string_interps, use_build_context_synchronously

import 'dart:convert';
import 'package:courierv9/pages/global.dart';
import 'package:courierv9/pages/style_constent.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';
import '../components/custom_button.dart';
import 'package:flutter/material.dart';

import '../palette.dart';
import '../routs.dart';
import 'package:http/http.dart' as http;

enum Auth { deliver, undeliver, reshdule, nulls, otp, boyrisk }

class DrsDetall extends StatefulWidget {
  final Map<String, dynamic>? args;
  const DrsDetall(this.args, {Key? key}) : super(key: key);

  @override
  State<DrsDetall> createState() => _DrsDetallState();
}

class _DrsDetallState extends State<DrsDetall> {
  bool _hasCallSupport = false;
  Future<void>? _launched;
  Auth _auth = Auth.nulls;
  TextEditingController otpController = TextEditingController(text: '');
  final _delivaryFormKey = GlobalKey<FormState>();
  final _undelivaryFormKey = GlobalKey<FormState>();
  final _reshduleFormKey = GlobalKey<FormState>();
  final _otpFormKey = GlobalKey<FormState>();
  final _boyFormKey = GlobalKey<FormState>();

  var isLoading = true;
  var shipmentData = null;
  var status_action = null;
  var reasion = null;
  var delay_date = null;
  var input_otp_number = null;
  var verifiedBy = null;
  var otpVerified = null;

  String? selectedItemUn = 'Select Reasion';
  String? selectedItemRe = 'Select Reasion';
  DateTime date = DateTime(2022, 9, 30);

  final itemsUn = [
    'Select Reasion',
    'Miss-Routed',
    'Customer Not Response',
    'Cash Not Ready',
    'Mobile Number Not Valid',
    'Customer Refused To Accept',
    'Reschedule'
  ];
  final itemsRe = [
    'Select Reasion',
    'On Customer Request',
    'Shipment Not Ready',
    'Shipment Not Hand Over By Seller',
    'The Seller Not allow To Chack Shipment',
  ];

  @override
  void initState() {
    super.initState();
    canLaunchUrl(Uri(scheme: "tel", path: "123")).then((bool result) {
      setState(() {
        _hasCallSupport = result;
      });
    });
    //print(widget.args);
    getAppData(widget.args);
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  Future<void> getAppData(arguments) async {
    try {
      var booking_id = arguments['shipment_id'];
      var res = await http.post(
          Uri.parse('${baseUrl}rest_api_native/RestController.php'),
          body: {
            "view": "booking_detail",
            "booking_id": booking_id,
          });
      // print(res.body);
      if (res.statusCode == 200) {
        var result_data = jsonDecode(res.body)['output'];
        setState(() {
          isLoading = false;
          shipmentData = result_data;
        });
        print(shipmentData);
      } else {}
    } catch (err) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("${err}")));
    }
  }

  Future<void> updateAction() async {
    try {
      setState(() {
        isLoading = true;
      });
      if (status_action == 'DL') {
        delay_date = '';
        reasion = selectedItemUn;
      }
      if (status_action == 'R') {
        delay_date = date.toString();
        reasion = selectedItemRe;
      }

      var res = await http.post(
          Uri.parse('${baseUrl}rest_api_native/RestController.php'),
          body: {
            "view": 'get_status',
            "status": status_action,
            "slipno": shipmentData['slip_no'],
            "coment_status": reasion,
            "delay_date": delay_date
          });
      if (res.statusCode == 200) {
        var result_data = jsonDecode(res.body)['output'];
        if (result_data == 'Shipment Update') {
          setState(() {
            isLoading = false;
          });
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Update Successful!")));
          Navigator.pushNamed(context, MyRouts.drsListRout);
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Oops Data Not Update!")));
        }
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Somting Went Wrong!")));
      }
    } catch (err) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("${err}")));
    }
  }

  Future<void> submitOTP() async {
    try {
      var input_otp = otpController.text;
      if (verifiedBy == 'OTP') {
        if (_otpFormKey.currentState!.validate()) {
          if (input_otp == shipmentData['otp']) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("OTP Matched")));
            Navigator.pushNamed(context, MyRouts.updateDrsRout, arguments: {
              'slip_no': shipmentData['slip_no'],
              'drs_unique_id': shipmentData['drs_unique_id'],
              'VerifiedBy': verifiedBy
            });
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Please Enter Currect OTP Number")));
          }
        }
      } else {
        Navigator.pushNamed(context, MyRouts.updateDrsRout, arguments: {
          'slip_no': shipmentData['slip_no'],
          'drs_unique_id': shipmentData['drs_unique_id'],
          'VerifiedBy': verifiedBy
        });
      }
    } catch (err) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("${err}")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(left: 55.0),
            child: const Text(
              "Drs Detall",
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
          ),
          backgroundColor: Colors.cyan,
        ),
        body: isLoading == false
            ? ListView(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, left: 10, right: 10),
                        child: Container(
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
                                  "Delivery",
                                  style: mTextStyle2,
                                )),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 18.0, top: 5, right: 18),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "AWB No",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                        Text(
                                          "${shipmentData['slip_no']}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Name",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        Text(
                                          "${shipmentData['reciever_name']}",
                                          style: TextStyle(fontSize: 15),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Email",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        Text(
                                          "${shipmentData['reciever_email']}",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Mobile No",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 50.0),
                                          child: InkWell(
                                              onTap: _hasCallSupport
                                                  ? () => setState(() {
                                                        _launched = _makePhoneCall(
                                                            "${shipmentData['reciever_name']}");
                                                      })
                                                  : null,
                                              child: Icon(Icons.call)),
                                        ),
                                        Text(
                                          "${shipmentData['reciever_phone']}",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Address",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        Text(
                                            "${shipmentData['reciever_address']}",textDirection: TextDirection.ltr, 
                                            style: TextStyle(
                                              fontSize: 15,
                                            ),
                                            maxLines: 3),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          height: 190,
                          width: 400,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey.shade300, width: 2),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(17)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, left: 10, right: 10),
                        child: Container(
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
                                  "Collection",
                                  style: mTextStyle2,
                                )),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 18.0, top: 5, right: 18),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Name",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                        Text(
                                          "${shipmentData['sender_name']}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Email",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        Text(
                                          "${shipmentData['sender_email']}",
                                          style: TextStyle(fontSize: 15),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Mobile",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        Text(
                                          "${shipmentData['sender_phone']}",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Address",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        Text(
                                          "${shipmentData['sender_address']}",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          height: 160,
                          width: 400,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey.shade300, width: 2),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(17)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, left: 10, right: 10),
                        child: Container(
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
                                  "Payment Info",
                                  style: mTextStyle2,
                                )),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 18.0, top: 5, right: 18),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Booking-Type",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                        Text(
                                          "${shipmentData['booking_mode']}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Cod Amount",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        Text(
                                          "${shipmentData['total_cod_amt']}",
                                          style: TextStyle(fontSize: 15),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Service Charge",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        Text(
                                          "${shipmentData['total_amt']}",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Total Amount",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        Text(
                                          "${shipmentData['total_amt']}",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          height: 160,
                          width: 400,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey.shade300, width: 2),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(17)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, left: 10, right: 10),
                        child: Container(
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
                                  "Other Details ${status_action}",
                                  style: mTextStyle2,
                                )),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 18.0, top: 5, right: 18),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "AWB No",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                        Text(
                                          "${shipmentData['slip_no']}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Booking Date/",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        Text(
                                          "${shipmentData['entrydate']}",
                                          style: TextStyle(fontSize: 15),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Pick-Up Time",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        Text(
                                          "${shipmentData['pickup_time']}",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Parcel Description Weight",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        Text(
                                          "${shipmentData['weight']} (KG)",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Shipment Type",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        Text(
                                          "${shipmentData['nrd']}",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                      ],
                                    ),
                                    // Divider(
                                    //   indent: 0,
                                    //   endIndent: 0,
                                    //   thickness: 2,
                                    // ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          height: 190,
                          width: 400,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey.shade300, width: 2),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(17)),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 50,
                        width: 400,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border:
                              Border.all(color: Colors.grey.shade300, width: 2),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Radio(
                                      value: Auth.deliver,
                                      activeColor: Colors.cyan,
                                      groupValue: _auth,
                                      onChanged: (Auth? val) {
                                        setState(() {
                                          _auth = val!;
                                          status_action = 'D';
                                          selectedItemUn = 'Select Reasion';
                                          selectedItemRe = 'Select Reasion';
                                          verifiedBy = 'OTP';
                                        });
                                      }),
                                  Expanded(
                                    child: Text(
                                      'Deliver',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  Radio(
                                      value: Auth.undeliver,
                                      activeColor: Colors.cyan,
                                      groupValue: _auth,
                                      onChanged: (Auth? val) {
                                        setState(() {
                                          _auth = val!;
                                          status_action = 'R';
                                          selectedItemUn = 'Select Reasion';
                                          selectedItemRe = 'Select Reasion';
                                        });
                                      }),
                                  Expanded(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 2.0),
                                      child: Text(
                                        'Undeliver',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  Radio(
                                      value: Auth.reshdule,
                                      activeColor: Colors.cyan,
                                      groupValue: _auth,
                                      onChanged: (Auth? val) {
                                        setState(() {
                                          _auth = val!;
                                          status_action = 'DL';
                                          selectedItemUn = 'Select Reasion';
                                          selectedItemRe = 'Select Reasion';
                                        });
                                      }),
                                  Expanded(
                                    child: Text(
                                      'Reshedule',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      if (status_action == 'D')
                        Form(
                          key: _delivaryFormKey,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10.0, left: 10, right: 10),
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
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
                                                          verifiedBy = 'OTP';
                                                        });
                                                      }),
                                                  Expanded(
                                                    child: Text(
                                                      'Verified By OTP',
                                                      style: TextStyle(
                                                          fontSize: 12),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                              Expanded(
                                                child: Row(
                                                  children: [
                                                    Radio(
                                                        value: Auth.boyrisk,
                                                        activeColor:
                                                            Colors.cyan,
                                                        groupValue: _auth,
                                                        onChanged: (Auth? val) {
                                                          setState(() {
                                                            _auth = val!;
                                                            verifiedBy =
                                                                'Driver';
                                                          });
                                                        }),
                                                    Expanded(
                                                      child: Text(
                                                        'On Driver Boy Risk',
                                                        style: TextStyle(
                                                            fontSize: 12),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          if (verifiedBy == 'OTP')
                                            Form(
                                                key: _otpFormKey,
                                                child: Material(
                                                  child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right: 25),
                                                          width: 150,
                                                          child: TextFormField(
                                                            controller:
                                                                otpController,
                                                            obscureText: false,
                                                            decoration:
                                                                InputDecoration(
                                                                    prefixIcon:
                                                                        Icon(
                                                                      Icons
                                                                          .email_outlined,
                                                                      color: Palette
                                                                          .iconColor,
                                                                    ),
                                                                    enabledBorder:
                                                                        OutlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                              color: Palette.textColor1),
                                                                      borderRadius:
                                                                          BorderRadius.all(
                                                                              Radius.circular(35)),
                                                                    ),
                                                                    focusedBorder:
                                                                        OutlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                              color: Palette.textColor1),
                                                                      borderRadius:
                                                                          BorderRadius.all(
                                                                              Radius.circular(35)),
                                                                    ),
                                                                    contentPadding:
                                                                        EdgeInsets.all(
                                                                            10),
                                                                    hintText:
                                                                        'Enter OTP',
                                                                    hintStyle: TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                        color: Palette
                                                                            .textColor1)),
                                                            validator: (value) {
                                                              if (value!
                                                                  .isEmpty) {
                                                                return "OTP Cannot Be Empty";
                                                              }
                                                              return null;
                                                            },
                                                          ),
                                                        ),
                                                        CustomButton(
                                                          text: "Submit",
                                                          onTap: () {
                                                            submitOTP();
                                                          },
                                                        ),
                                                      ]),
                                                )),
                                          if (verifiedBy == 'Driver')
                                            Form(
                                              key: _boyFormKey,
                                              child: CustomButton(
                                                  text: "Update Drs",
                                                  onTap: () {
                                                    submitOTP();
                                                    // Navigator.pushNamed(context,
                                                    //     MyRouts.updateDrsRout);
                                                  }),
                                            ),
                                        ],
                                      )
                                    ],
                                  ),
                                  height: 160,
                                  width: 400,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey.shade300,
                                          width: 2),
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(17)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      if (status_action == 'R')
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, left: 10, right: 10),
                          child: Container(
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
                                    "Un-Deliver",
                                    style: mTextStyle2,
                                  )),
                                ),
                                Form(
                                  key: _undelivaryFormKey,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Container(
                                          width: 390,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 16.0),
                                            child: Material(
                                              borderRadius:
                                                  BorderRadius.circular(40),
                                              child: DropdownButton<String>(
                                                isExpanded: true,
                                                underline:
                                                    DropdownButtonHideUnderline(
                                                        child: Container()),
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                value: selectedItemUn,
                                                items: itemsUn
                                                    .map((item) =>
                                                        DropdownMenuItem(
                                                            value: item,
                                                            child: Text(
                                                              item,
                                                              style: TextStyle(
                                                                  fontSize: 15),
                                                            )))
                                                    .toList(),
                                                onChanged: (item) {
                                                  setState(() {
                                                    selectedItemUn = item;
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                color: Colors.grey.shade300,
                                                width: 2),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            CustomButton(
                                              text: "Update Drs",
                                              onTap: () {
                                                updateAction();
                                              },
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            height: 170,
                            width: 400,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.grey.shade300, width: 2),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(17)),
                          ),
                        ),
                      if (status_action == 'DL')
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, left: 10, right: 10),
                          child: Container(
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
                                    "Re-Schedule",
                                    style: mTextStyle2,
                                  )),
                                ),
                                Form(
                                  key: _reshduleFormKey,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Container(
                                          width: 390,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Material(
                                              borderRadius:
                                                  BorderRadius.circular(40),
                                              child: DropdownButton<String>(
                                                isExpanded: true,
                                                underline:
                                                    DropdownButtonHideUnderline(
                                                        child: Container()),
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                value: selectedItemRe,
                                                items: itemsRe
                                                    .map((item) =>
                                                        DropdownMenuItem(
                                                            value: item,
                                                            child: Text(
                                                              item,
                                                              style: TextStyle(
                                                                  fontSize: 15),
                                                            )))
                                                    .toList(),
                                                onChanged: (item) {
                                                  setState(() {
                                                    selectedItemRe = item;
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                color: Colors.grey.shade300,
                                                width: 2),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            CustomButton(
                                              text:
                                                  '${date.year}/${date.month}/${date.day}',
                                              onTap: () async {
                                                DateTime? newDate =
                                                    await showDatePicker(
                                                        context: context,
                                                        initialDate: date,
                                                        firstDate:
                                                            DateTime(1900),
                                                        lastDate:
                                                            DateTime(2100));
                                                if (newDate == null) return;
                                                setState(() {
                                                  date = newDate;
                                                });
                                              },
                                            ),
                                            CustomButton(
                                              text: "Update Drs",
                                              onTap: () {
                                                updateAction();
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            height: 170,
                            width: 400,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.grey.shade300, width: 2),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(17)),
                          ),
                        ),
                    ],
                  ),
                ],
              )
            : Center(
                child: Lottie.asset("images/delivery-loader.json",
                    width: 150, height: 150),
              ));
  }
}
