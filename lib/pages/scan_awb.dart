// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, non_constant_identifier_names, empty_catches, use_build_context_synchronously, avoid_print

import 'dart:convert';

import 'package:courierv9/pages/routs.dart';
import 'package:courierv9/pages/style_constent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'components/custom_button.dart';
import 'global.dart';

class ScanAwb extends StatefulWidget {
  const ScanAwb({Key? key}) : super(key: key);

  @override
  State<ScanAwb> createState() => _ScanAwbState();
}

class _ScanAwbState extends State<ScanAwb> {
  final _myBox = Hive.box('AppData');
  String _data = "0";
  _scan() async {
    await FlutterBarcodeScanner.scanBarcode(
            "#000000", "Cancel", true, ScanMode.BARCODE)
        .then((value) {
      setState(() {
        _data = value;
      });
      scanAWB(_data);
    });
  }

  Future<void> scanAWB(value) async {
    try {
      var isLoading = false;
      var qrCode = value;
      var m_id = _myBox.get('m_id');
      var res = await http.post(
          Uri.parse("${baseUrl}rest_api_native/RestController.php"),
          body: {
            "view": "scanAwb",
            "shipment_id": qrCode,
            "messanger_id": m_id
          });
      setState(() {
        isLoading = false;
      });
      if (res.statusCode == 200) {
        var resultData = jsonDecode(res.body)["output"];
        var delivered = resultData[0]['delivered'];
        if (delivered == 'B' ||
            delivered == 'PC' ||
            delivered == 'PP' ||
            delivered == 'PRS' ||
            delivered == 'T') {
          Navigator.pushNamed(context, MyRouts.pickupDetailRout,
              arguments: {"shipment_id": qrCode, "listType": "List"});
        } else if (delivered == 'IT') {
          Navigator.pushNamed(
            context,
            MyRouts.drsDetallRout,
            arguments: {
              "drs_id": "",
              "m_id": m_id,
              "shipment_id": qrCode,
              "listType": "List"
            },
          );
        } else {
          Navigator.pushNamed(
            context,
            MyRouts.drsDetallRout,
            arguments: {
              "drs_id": "",
              "m_id": m_id,
              "shipment_id": qrCode,
              "listType": "List"
            },
          );
        }
      }
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Center(
          child: Padding(
            padding: const EdgeInsets.only(right: 40.0),
            child: Text("Scan AWB", style: mTextStyleHeader),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
              text: "Scan Awb Barcode",
              onTap: () => _scan(),
            ),
            Text(_data),
          ],
        ),
      ),
    );
  }
}
