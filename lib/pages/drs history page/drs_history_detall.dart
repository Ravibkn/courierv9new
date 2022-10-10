// ignore_for_file: sort_child_properties_last, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, avoid_init_to_null

import 'dart:convert';
import 'package:courierv9/pages/drs_screens/verifay.dart';
import 'package:courierv9/pages/global.dart';
import 'package:courierv9/pages/style_constent.dart';
import 'package:geocoder2/geocoder2.dart';
import 'package:lottie/lottie.dart';
import '../components/custom_button.dart';
import 'package:flutter/material.dart';

import '../components/custom_container.dart';
import '../routs.dart';

import 'package:http/http.dart' as http;



class DrsDetallHistory  extends StatefulWidget {
  final Map<String, dynamic>? args;
  const DrsDetallHistory(this.args, {Key? key}) : super(key: key);

  @override
  State<DrsDetallHistory> createState() => _DrsDetallHistoryState();
}

class _DrsDetallHistoryState extends State<DrsDetallHistory> {
 

  var isLoading = true;
  var shipmentData = null;
  



  @override
  void initState() {
    super.initState();
    //print(widget.args);
    getAppData(widget.args);
  }

  Future<void> getAppData(arguments) async {
    try {
      var booking_id = arguments['shipment_id'];
      var res = await http.post(
          Uri.parse(baseUrl + 'rest_api_native/RestController.php'),
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

        if(shipmentData['receiver_image']==null || shipmentData['receiver_image']==''){
          shipmentData['receiver_image']='not_avl.jpg';
        }
        if(shipmentData['signature_img']==null || shipmentData['signature_img']==''){
          shipmentData['signature_img']='not_avl.jpg';
        }
      } else {}
    } catch (err) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("${err}")));
    }
  }

  Future<void> gotoDirectionPage(receiver_address) async {

    var receiver_address='kote gate,bikaner';
    final fetchGeocoder = await Geocoder2.getDataFromAddress(
        address: receiver_address.toString(),
        googleMapApiKey: "AIzaSyAkQS7iq1NgOM_r1c60jdzk8ekxGPvRcm4"
      );
    var first = fetchGeocoder.city;

    var latitude = fetchGeocoder.latitude;
    var longitude = fetchGeocoder.longitude;
   
   
   Navigator.pushNamed(context, MyRouts.directionpage,
            arguments: {
              "latitude":latitude,
              "longitude":longitude,
              "length":2
            }
           );

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(left: 55.0),
            child: const Text(
              "Drs Detall History",
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
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 155),
                                      child: Text(
                                        "Delivery",
                                        style: mTextStyle2,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty.all(Colors.red),
                                          minimumSize: MaterialStateProperty.all(Size(20,20))
                                          ,shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius:BorderRadius.circular(20))))
                                        ,onPressed: (){
                                          gotoDirectionPage(shipmentData['receiver_address']);
                                      }, child: Icon(Icons.directions)),
                                    )
                                  ],
                                ),
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
                                          child: Icon(Icons.call),
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
                                          "${shipmentData['reciever_address']}",
                                          style: TextStyle(fontSize: 15),
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
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("Map", style: mTextStyle2),
                              CustomButton(text: "Get Diraction", onTap: () {})
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  height: 350,
                  width: 400,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300, width: 2),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(17)),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
               CustomContenar(text: "Signature",image:"${shipmentData['signature_img']}",path:"${baseUrl}assets/images/images/signature_img",
              ),
               CustomContenar(
                text: "Photo",image:"${shipmentData['receiver_image']}",path:"${baseUrl}assets/images/images/receiver_img"),
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
