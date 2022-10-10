// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:courierv9/pages/routs.dart';
import 'package:courierv9/pages/style_constent.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _myBox = Hive.box('AppData');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            // ignore: sized_box_for_whitespace, sort_child_properties_last
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / .2,
            ),
            painter: HeaderCurvedContainer(),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Text(
                    "Profile",
                    style: TextStyle(
                      fontSize: 25,
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
              Container(
                padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width / 3,
                height: MediaQuery.of(context).size.width / 2,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 5),
                    shape: BoxShape.circle,
                    color: Colors.white,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        'images/background.jpg',
                      ),
                    )),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 260, left: 100),
            child: CircleAvatar(
              backgroundColor: Colors.cyan.shade300.withOpacity(.70),
              child: IconButton(
                  onPressed: () {
                    print("object");
                    Navigator.pushNamed(context, MyRouts.profileEditRout);
                  },
                  icon: Icon(Icons.edit)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 250.0),
            child: ListView(
              children: [
                Card(
                  margin: EdgeInsets.only(
                    left: 35,
                    right: 35,
                  ),
                  shape: StadiumBorder(
                      side: BorderSide(color: Colors.grey.shade300, width: 1)),
                  color: Colors.grey.shade100,
                  child: ListTile(
                    leading: Text("Name :", style: mTextStyle1),
                    title: Text(_myBox.get("m_name"), style: mTextStyle1),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Card(
                  margin: EdgeInsets.only(
                    left: 35,
                    right: 35,
                  ),
                  shape: StadiumBorder(
                      side: BorderSide(color: Colors.grey.shade300, width: 1)),
                  color: Colors.grey.shade100,
                  child: ListTile(
                    leading: Text("Branch :", style: mTextStyle1),
                    title: Text(_myBox.get("m_branch"), style: mTextStyle1),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Card(
                  margin: EdgeInsets.only(
                    left: 35,
                    right: 35,
                  ),
                  shape: StadiumBorder(
                      side: BorderSide(color: Colors.grey.shade300, width: 1)),
                  color: Colors.grey.shade100,
                  child: ListTile(
                    leading: Text("City :", style: mTextStyle1),
                    title: Text(_myBox.get("m_city"), style: mTextStyle1),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Card(
                  margin: EdgeInsets.only(
                    left: 35,
                    right: 35,
                  ),
                  shape: StadiumBorder(
                      side: BorderSide(color: Colors.grey.shade300, width: 1)),
                  color: Colors.grey.shade100,
                  child: ListTile(
                    leading: Text("Mobile No :", style: mTextStyle1),
                    title: Text(_myBox.get("m_phone"), style: mTextStyle1),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Card(
                  margin: EdgeInsets.only(
                    left: 35,
                    right: 35,
                  ),
                  shape: StadiumBorder(
                      side: BorderSide(color: Colors.grey.shade300, width: 1)),
                  color: Colors.grey.shade100,
                  child: ListTile(
                    leading: Text("Email :", style: mTextStyle1),
                    title: Text(_myBox.get("m_email"), style: mTextStyle1),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Card(
                  margin: EdgeInsets.only(
                    left: 35,
                    right: 35,
                  ),
                  shape: StadiumBorder(
                      side: BorderSide(color: Colors.grey.shade300, width: 1)),
                  color: Colors.grey.shade100,
                  child: ListTile(
                    leading: Text("Vehicle No :", style: mTextStyle1),
                    title: Text(_myBox.get("m_vehicle_number"),
                        style: mTextStyle1),
                  ),
                ),
                Container(
                  height: 20,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class HeaderCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.cyan;
    Path path = Path()
      ..relativeLineTo(0, 150)
      ..quadraticBezierTo(size.width / 2, 225, size.width, 150)
      ..relativeLineTo(0, -150)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
