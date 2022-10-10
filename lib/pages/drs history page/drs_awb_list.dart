// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables, use_build_context_synchronously, unused_import, override_on_non_overriding_member, non_constant_identifier_names, unused_local_variable, unnecessary_brace_in_string_interps

import 'dart:convert';
// import 'dart:html';

import 'package:courierv9/pages/global.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';

import '../components/custom_button.dart';
import '../routs.dart';
import 'package:http/http.dart' as http;

// import 'package:geocoding/geocoding.dart';
import 'package:geocoder2/geocoder2.dart';




class DrsAwbHistory extends StatefulWidget {
    final Map<String, dynamic>? args;

  const DrsAwbHistory(this.args,{Key? key}) : super(key: key);

  @override
  State<DrsAwbHistory> createState() => _DrsAwbHistoryState();
}

class _DrsAwbHistoryState extends State<DrsAwbHistory> {
   List users =[];
    var isLoading = true;
   @override
    final _myBox = Hive.box('AppData');
   @override
  void initState() {
    super.initState();
   
   getAppData(widget.args);
  }
   Future<void> getAppData(arguments) async {

    var drs_unique_id = arguments['drs_unique_id'];

   var res =   await http.post(Uri.parse('${baseUrl}rest_api_native/RestController.php'),
    body: { 
      "view":"getAwbNumberForDrs",
      "drs_unique_id":drs_unique_id,
      "page":"1",
      "listType":"History"
      }
    );
    setState(() {
      isLoading = false;
    });
     if(res.statusCode == 200){
      var items = jsonDecode(res.body)['output'];
      setState(() {
        users = items;
      });
    }else{
      users = [];
    }
  }
      @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Padding(
          padding: const EdgeInsets.only(right: 45.0),
          child: Center(
            child: Text(
              "Drs Awb List History",
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
        ),
      ),
      body: isLoading== false ? Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 10, right: 10, top: 10),
            height: 90,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(blurRadius: 5, spreadRadius: .2, color: Colors.grey)
                ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 8.0,
                  ),
                  child: Text(
                    "View Direction Of All\nBellow Pickup Shipments\nin Google Map ",
                    style: TextStyle(fontSize: 13),
                  ),
                ),
                CustomButton(text: "Get Direction", onTap: () {})
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  return getCard(users[index]);
                }),
          )
        ],
      ) :Center(
                child: Lottie.asset("images/delivery-loader.json",width:150,height:150),
              )
    );
  }
  
  Widget getCard(item) {
    var m_id = _myBox.get('m_id');
    var slipNo = item['shipment_id'];
    var drs_date = item['drs_date'];
    var drs_id =item['drs_unique_id'];
    var receiver_address =item['receiver_address'];
    
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, MyRouts.drsDetallHistoryRout,
            arguments: {
              "drs_id":drs_id,
              "m_id":m_id,
              "shipment_id":slipNo,
              "listType":"List"
            }
           );
      },
      child: Container(
        margin: EdgeInsets.only(left: 10, right: 10, top: 10),
        height: 70,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(blurRadius: 5, spreadRadius: .2, color: Colors.grey)
            ]),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Text("AWB No:"),
                  SizedBox(height: 3,),
                  Row(
                    children: [
                      Container(
                          padding: const EdgeInsets.only(top:3,bottom:2,left:10,right:10),
                        decoration: BoxDecoration(borderRadius:BorderRadius.circular(8),color: Colors.orange),
                        margin: EdgeInsets.only(top: 5),
                        child: Text("In Transist",style: TextStyle(color: Colors.yellow,fontWeight: FontWeight.bold,),),),
                    ],
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
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0, right: 10),
                  child: Text("${slipNo}"),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Text("${drs_date}"),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}