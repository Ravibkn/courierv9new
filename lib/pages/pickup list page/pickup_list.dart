// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, unnecessary_brace_in_string_interps, prefer_is_empty

import 'dart:convert';

import 'package:courierv9/pages/global.dart';
import 'package:courierv9/pages/routs.dart';
import 'package:courierv9/pages/style_constent.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';

class PickupList extends StatefulWidget {
  const PickupList({Key? key}) : super(key: key);

  @override
  State<PickupList> createState() => _PickupListState();
}

class _PickupListState extends State<PickupList> {
  final _myBox = Hive.box('AppData');
  List users = [];

  @override
  void initState() {
    super.initState();
    getAppData();
  }

  Future<void> getAppData() async {
    try {
      var user_id = _myBox.get('m_id');
      var res = await http.post(
          Uri.parse('${baseUrl}rest_api_native/RestController.php'),
          body: {"view": "pickup_list", "user_id": user_id, "page": "1"});
      if (res.statusCode == 200) {
        var items = json.decode(res.body)['output'];
        if (items[0]['error'] == 'No Record found!') {
          users = [];
        } else {
          setState(() {
            users = items;
          });
        }
      } else {
        users = [];
      }
    } catch (err) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("${err}")));
    }
    // apiList= jsonDecode(res.body)['output'].map((item)=>PickupListData.fromJson(item)).toList().cast<PickupListData>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Center(
            child: Padding(
          padding: const EdgeInsets.only(right: 40.0),
          child: Text(
            "Pickup List",
            style: mTextStyleHeader,
          ),
        )),
      ),
      body: users.length > 0
          ? getList()
          : Center(
              child:
                  Lottie.asset("images/delavery.json", width: 150, height: 150),
            ),
    );
  }

  Widget getList() {
    return ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return getCard(users[index]);
        });
  }

  Widget getCard(item) {
    var drs_unique_id = item['drs_unique_id'];
    var drs_date = item['drs_date'];
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, MyRouts.pickupAwbUpdateListRout,
            arguments: {'pickup_id': drs_unique_id});
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
      ),
    );
  }
}
