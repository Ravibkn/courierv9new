// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:courierv9/pages/style_constent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import '../components/custom_button.dart';
import '../components/custom_chackbox.dart';

class PickupAwbUpdate extends StatefulWidget {
  const PickupAwbUpdate({Key? key}) : super(key: key);

  @override
  State<PickupAwbUpdate> createState() => _PickupAwbUpdateState();
}

class _PickupAwbUpdateState extends State<PickupAwbUpdate> {
  String _data = "0";
  _scan() async {
    await FlutterBarcodeScanner.scanBarcode(
            "#000000", "Cancel", true, ScanMode.BARCODE)
        .then((value) => setState(() => _data = value));
  }

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    print(arguments);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Center(
          child: Padding(
            padding: const EdgeInsets.only(right: 40.0),
            child: Text("Pickup Update", style: mTextStyleHeader),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 230,
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
                      "Shipment List",
                      style: mTextStyle2,
                    )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      height: 70,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 5,
                                spreadRadius: .2,
                                color: Colors.grey)
                          ]),
                      child: Row(children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("AWB No:"),
                              Container(
                                width: 150,
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Center(
                                    child: Text(
                                  "Proseed For Pickup",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                )),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            indent: 5.0,
                            endIndent: 15,
                            thickness: 1,
                          ),
                        ),
                        Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 10.0, right: 10),
                                  child: Text("12000009",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: Text("2021-12-09"),
                                ),
                              ],
                            ),
                            VerticalDivider(
                              indent: 5.0,
                              endIndent: 15,
                              thickness: 1,
                            ),
                            CustomCheckBox(),
                          ],
                        )
                      ])),
                  SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    text: "pickup Conform",
                    onTap: () => _scan(),
                  ),
                  Text(_data),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
