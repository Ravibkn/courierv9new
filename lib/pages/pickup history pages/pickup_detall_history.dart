// ignore_for_file: avoid_print, unnecessary_brace_in_string_interps, unused_field

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:courierv9/pages/style_constent.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import '../global.dart';

class PickupDetallHistory extends StatefulWidget {
  final Map<String, dynamic>? args;
  const PickupDetallHistory(this.args, {Key? key}) : super(key: key);

  @override
  State<PickupDetallHistory> createState() => _PickupDetallHistoryState();
}

class _PickupDetallHistoryState extends State<PickupDetallHistory> {
  bool _hasCallSupport = false;
  Future<void>? _launched;
  var pickupDetailData = {};
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    canLaunchUrl(Uri(scheme: "tel", path: "123")).then((bool result) {
      setState(() {
        _hasCallSupport = result;
      });
    });
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
      var res = await http.post(
          Uri.parse('${baseUrl}rest_api_native/RestController.php'),
          body: {
            "view": "booking_detail",
            "booking_id": arguments['shipment_id'],
          });

      if (res.statusCode == 200) {
        var pickupData = jsonDecode(res.body)['output'];
        setState(() {
          isLoading = false;
          pickupDetailData = pickupData;
        });
        print(pickupDetailData);
      }
    } catch (err) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("${err}")));
    }
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments;
    print(arguments);
    return Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(left: 0.0),
            child: Center(
                child: Text("Pickup Detall History", style: mTextStyleHeader)),
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
                          // ignore: sort_child_properties_last
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
                                          padding:
                                              const EdgeInsets.only(left: 50.0),
                                          child: InkWell(
                                              onTap: _hasCallSupport
                                                  ? () => setState(() {
                                                        _launched = _makePhoneCall(
                                                            "${pickupDetailData['sender_phone']}");
                                                      })
                                                  : null,
                                              child: const Icon(Icons.call)),
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
                          // ignore: sort_child_properties_last
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
                          // ignore: sort_child_properties_last
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
                                        return "Pickup-Reschedul";
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
                          height: 200,
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
