// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../routs.dart';

import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:courierv9/pages/global.dart';
import 'package:lottie/lottie.dart';

class DrsHistory extends StatefulWidget {
  const DrsHistory({Key? key}) : super(key: key);

  @override
  State<DrsHistory> createState() => _DrsHistoryState();
}

class _DrsHistoryState extends State<DrsHistory> {
   List users = [];
   var isLoading = true;
  @override
  void initState() {
    super.initState();
    getAppData();
  }

   Future<void> getAppData() async {
    var m_id = _myBox.get('m_id');
    var res = await http.post(
        Uri.parse(baseUrl + 'rest_api_native/RestController.php'),
        body: {"view": "delivered_list", "user_id": m_id, "page": "1"});
       setState(() {
       isLoading = false;
      });
    if (res.statusCode == 200) {
      var items = jsonDecode(res.body)['output'];
      // print(items);
       if(items[0]['error']=='No Record found!'){
         users = [];
       }else{
        setState(() {
        users = items;
      });
       }
      
    } else {
      users = [];
    }
  }
  @override
  final _myBox = Hive.box('AppData');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: const Center(
            child: Padding(
          padding: EdgeInsets.only(right: 40.0),
          child: Text(
            "Drs History",
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
        )),
      ),
      body: isLoading == false ? getList() : Center(
                child: Lottie.asset("images/delivery-loader.json",width:150,height:150),
              ),
    );
  }
   Widget getList() {
    if(users.length > 0){
    return ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return getCard(users[index]);
        });
    }else{
        return Center(child: const Text('No items'));
    }   
  }
   Widget getCard(item) {
    var drs_unique_id = item['drs_unique_id'];
    var drs_date = item['drs_date'];
    return InkWell(
        onTap: () {
          Navigator.pushNamed(context, MyRouts.drsHistoryAwbrout,
              arguments: {'drs_unique_id': drs_unique_id});
        },
        child: Card(
          color: Colors.grey.shade100,
          child: ListTile(
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("${item['pickup_delivered']}/${item['total_awb']}"),
            ),
            title: Text("${drs_unique_id}"),
            subtitle: Text("${drs_date}"),
          ),
        ));
  }
}
