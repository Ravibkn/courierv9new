// ignore_for_file: sort_child_properties_last, non_constant_identifier_names, unnecessary_brace_in_string_interps, avoid_print, prefer_const_constructors, unused_field

import 'dart:convert';

import 'package:courierv9/pages/global.dart';
import 'package:courierv9/pages/routs.dart';
import 'package:courierv9/pages/style_constent.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';
import '../components/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PickupDetail extends StatefulWidget {
  final Map<String, dynamic>? args;
  const PickupDetail(this.args, {Key? key}) : super(key: key);

  @override
  State<PickupDetail> createState() => _PickupDetailState();
}

class _PickupDetailState extends State<PickupDetail> {
  bool isLoading = true;
  bool _hasCallSupport = false;
  Future<void>? _launched;
  var pickupDetailData = {};
  String? pickupRadioBtnVal = 'pickup';
  String? verifiedBy = 'OTP';
  String? dropdownValue = "Select Reasion";
  // DateTime now = DateTime.now();
  DateTime date = DateTime.now(); //DateTime(2022, 12, 24);

  @override
  void initState() {
    super.initState();
    canLaunchUrl(Uri(scheme: "tel", path: "123")).then((bool result) {
      setState(() {
        _hasCallSupport = result;
      });
    });
    // print(widget.args);
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
      // print(arguments);
      var res = await http.post(
          Uri.parse('${baseUrl}rest_api_native/RestController.php'),
          body: {
            "view": "booking_detail",
            "booking_id": arguments['shipment_id'],
          });
      // var data = jsonDecode(res.statusCode);
      if (res.statusCode == 200) {
        // print(res.body);
        var pickupData = jsonDecode(res.body)['output'];
        setState(() {
          isLoading = false;
          pickupDetailData = pickupData;
          // pickedupStatus = pickedupStatus;
        });
        print(pickupDetailData);
      }
    } catch (err) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("${err}")));
    }
  }

  Future<void> updateSatus(slipNo) async {
    print(slipNo);
    var bodyData = {};
    var StatusTitle = '';
    if (pickupRadioBtnVal == 'reschedule') {
      StatusTitle = 'Re-Schedule';
      bodyData = {
        'view': 'pickup_change_status',
        'slip_no': slipNo,
        'status': 'PRS',
        'reasion': dropdownValue,
        'r_date': '${date.day}/${date.month}/${date.year}'
      };
    } else {
      StatusTitle = 'Pickup';
      bodyData = {
        'view': 'pickup_change_status',
        'slip_no': slipNo,
        'status': 'T',
        'reasion': '',
        'r_date': ''
      };
    }
    print(bodyData);
    try {
      // print(arguments);
      var res = await http
          .post(Uri.parse('${baseUrl}rest_api_native/RestController.php'),
              body: bodyData)
          .then((Response) => {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Shipment Successfully ${StatusTitle}"))),
                Navigator.pushNamed(context, MyRouts.pickupdetallHistoryrout)
              });
      print(res);
    } catch (err) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("${err}")));
    }
  }

  DialogBtn(slipNo) async {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Confirm Update'),
        content: const Text('Do You Want To Update This!'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('NO'),
          ),
          TextButton(
            onPressed: () => {
              Navigator.pop(context, 'OK'),
              updateSatus(pickupDetailData['slip_no'])
            },
            child: const Text('YES'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // print(pickupDetailData);
    return Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(left: 0.0),
            child:
                Center(child: Text("Pickup Detail", style: mTextStyleHeader)),
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
                                    borderRadius: const BorderRadius.only(
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
                                        const Text(
                                          "AWB No",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                        Text(
                                          "${pickupDetailData['slip_no']}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Nane",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        Text(
                                          "${pickupDetailData['sender_name']}",
                                          style: const TextStyle(fontSize: 15),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Email",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        Text(
                                          "${pickupDetailData['sender_email']}",
                                          style: const TextStyle(fontSize: 15),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Mobile No",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 50.0),
                                          child: InkWell(
                                              onTap: _hasCallSupport
                                                  ? () => setState(() {
                                                        _launched = _makePhoneCall(
                                                            "${pickupDetailData['sender_phone']}");
                                                      })
                                                  : null,
                                              child: Icon(Icons.call)),
                                        ),
                                        Text(
                                          "${pickupDetailData['sender_phone']}",
                                          style: const TextStyle(fontSize: 15),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Address",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        Text(
                                          "${pickupDetailData['sender_address']}",
                                          style: const TextStyle(fontSize: 15),
                                        ),
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
                                    borderRadius: const BorderRadius.only(
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
                                        const Text(
                                          "Name",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                        Text(
                                          "${pickupDetailData['reciever_name']}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Email",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        Text(
                                          "${pickupDetailData['reciever_email']}",
                                          style: const TextStyle(fontSize: 15),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Mobile",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        Text(
                                          "${pickupDetailData['reciever_phone']}",
                                          style: const TextStyle(fontSize: 15),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Address",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        Text(
                                          "${pickupDetailData['reciever_address']}",
                                          style: const TextStyle(fontSize: 15),
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
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(
                                          15,
                                        ),
                                        topRight: Radius.circular(15))),
                                child: Center(
                                    child: Text(
                                  "Other Details",
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
                                        const Text(
                                          "Booking Date/Time",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        Text(
                                          "${pickupDetailData['entrydate']}",
                                          style: const TextStyle(fontSize: 15),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Parcel Description",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        Text(
                                          "${pickupDetailData['status_describtion']}",
                                          style: const TextStyle(fontSize: 15),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Weight",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        Text(
                                          "${pickupDetailData['weight']} (KG)",
                                          style: const TextStyle(fontSize: 15),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Shipment Type",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        Text(
                                          "${pickupDetailData['nrd']}",
                                          style: const TextStyle(fontSize: 15),
                                        ),
                                      ],
                                    ),
                                    const Divider(
                                      indent: 0,
                                      endIndent: 0,
                                      thickness: 2,
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(right: 65.0),
                                    child: Text(
                                      "Shipment-Status",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Text(
                                    (() {
                                      if (pickupDetailData['delivered'] ==
                                          'T') {
                                        return "Picked-up";
                                      }
                                      if (pickupDetailData['delivered'] ==
                                          'PP') {
                                        return "Proseed for pickup";
                                      }
                                      if (pickupDetailData['delivered'] ==
                                          'PRS') {
                                        return "Pickup-Rescheduled";
                                      }
                                      return "--";
                                    })(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ],
                          ),
                          height: 240,
                          width: 400,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey.shade300, width: 2),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(17)),
                        ),
                      ),
                      // shipment update
                      if (pickupDetailData['delivered'] == 'PP' ||
                          pickupDetailData['delivered'] == 'PRS') ...[
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
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(
                                            15,
                                          ),
                                          topRight: Radius.circular(15))),
                                  child: Center(
                                      child: Text(
                                    "Shipment Update",
                                    style: mTextStyle2,
                                  )),
                                ),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                          child: RadioListTile(
                                        title: const Text('Pickup'),
                                        activeColor: Colors.cyan,
                                        value: 'pickup',
                                        groupValue: pickupRadioBtnVal,
                                        onChanged: (value) {
                                          setState(() {
                                            pickupRadioBtnVal =
                                                value.toString();
                                          });
                                        },
                                      )),
                                      Expanded(
                                          child: RadioListTile(
                                        title: const Text('Reschedule'),
                                        activeColor: Colors.cyan,
                                        value: 'reschedule',
                                        groupValue: pickupRadioBtnVal,
                                        onChanged: (value) {
                                          setState(() {
                                            pickupRadioBtnVal =
                                                value.toString();
                                          });
                                        },
                                      ))
                                    ]),
                              ],
                            ),
                            // height: 100,
                            width: 400,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.grey.shade300, width: 2),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(17)),
                          ),
                        ),
                        // Verified by
                        if (pickupRadioBtnVal == 'pickup') ...[
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
                                        borderRadius: const BorderRadius.only(
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
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                            child: RadioListTile(
                                          title: const Text('Verified By OTP',
                                              style: TextStyle(fontSize: 12)),
                                          activeColor: Colors.cyan,
                                          contentPadding: EdgeInsets.zero,
                                          value: 'OTP',
                                          groupValue: verifiedBy,
                                          onChanged: (value) {
                                            setState(() {
                                              verifiedBy = value.toString();
                                            });
                                          },
                                        )),
                                        Expanded(
                                            child: RadioListTile(
                                          title: const Text(
                                              'On Driver Boy Risk',
                                              style: TextStyle(fontSize: 12)),
                                          contentPadding: EdgeInsets.zero,
                                          activeColor: Colors.cyan,
                                          value: 'driverRisk',
                                          groupValue: verifiedBy,
                                          onChanged: (value) {
                                            setState(() {
                                              verifiedBy = value.toString();
                                            });
                                          },
                                        ))
                                      ]),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        if (verifiedBy == 'OTP') ...[
                                          Container(
                                            margin: EdgeInsets.only(right: 25),
                                            width: 150,
                                            color: Colors.grey.shade300,
                                            child: TextFormField(
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: const InputDecoration(
                                                hintText: 'Enter OTP',
                                                contentPadding:
                                                    EdgeInsets.all(8),
                                                isDense: true,
                                                border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.grey)),
                                              ),
                                            ),
                                          )
                                        ],
                                        CustomButton(
                                            text: "Submit",
                                            onTap: () => {
                                                  DialogBtn(pickupDetailData[
                                                      'slip_no'])
                                                }),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              // height: 100,
                              width: 400,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.grey.shade300, width: 2),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(17)),
                            ),
                          ),
                        ],
                        // Re-Schedule
                        if (pickupRadioBtnVal == 'reschedule') ...[
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
                                        borderRadius: const BorderRadius.only(
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
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Column(
                                          children: [
                                            Container(
                                              width: 200,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 16.0),
                                                child: DropdownButton(
                                                  value: dropdownValue,
                                                  isExpanded: true,
                                                  underline:
                                                      DropdownButtonHideUnderline(
                                                          child: Container()),
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  items: <String>[
                                                    'Select Reasion',
                                                    'On Customer Request',
                                                  ].map<
                                                          DropdownMenuItem<
                                                              String>>(
                                                      (String value) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: value,
                                                      child: Text(value,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize:
                                                                      15)),
                                                    );
                                                  }).toList(),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      dropdownValue =
                                                          value as String?;
                                                    });
                                                  },
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
                                          ],
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Column(
                                            children: [
                                              OutlinedButton(
                                                  style:
                                                      OutlinedButton.styleFrom(
                                                    minimumSize:
                                                        const Size(120, 50),
                                                    maximumSize:
                                                        const Size(120, 50),
                                                    side: BorderSide(
                                                        width: 2.0,
                                                        color: Colors
                                                            .grey.shade300),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0)),
                                                  ),
                                                  onPressed: () async {
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
                                                  child: Text(
                                                      '${date.day}/${date.month}/${date.year}',
                                                      style: const TextStyle(
                                                          fontSize: 15))),
                                            ],
                                          ),
                                        )
                                      ]),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 5, bottom: 5),
                                        child: CustomButton(
                                          text: "Submit",
                                          onTap: () {
                                            DialogBtn(
                                                pickupDetailData['slip_no']);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              // height: 100,
                              width: 400,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.grey.shade300, width: 2),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(17)),
                            ),
                          ),
                        ],
                      ],
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text("Map", style: mTextStyle2),
                                      CustomButton(
                                          text: "Get Diraction",
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, MyRouts.mapScreenRout);
                                          })
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          height: 350,
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
                child: Lottie.asset("images/delavery.json",
                    width: 150, height: 150),
              ));
  }
}
