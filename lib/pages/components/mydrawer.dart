// ignore_for_file: prefer_const_constructors, override_on_non_overriding_member, unused_field

import 'package:courierv9/pages/routs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';


class MySidebar extends StatefulWidget {
  const MySidebar({Key? key}) : super(key: key);

  @override
  State<MySidebar> createState() => _MySidebarState();
}

class _MySidebarState extends State<MySidebar> {
  @override
    final _myBox = Hive.box('AppData');
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.cyan,
      child: Column(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Colors.cyan),
            accountName: Text(
              "Ravi Joshi",
            ),
            accountEmail: Text("abc@gmail.com"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.grey.shade300,
              child: Text("R"),
            ),
          ),
          Divider(
            indent: 0,
            endIndent: 0,
            thickness: 2,
          ),
          ListTile(
            visualDensity: VisualDensity(horizontal: 0, vertical: -4),
            leading: Icon(
              CupertinoIcons.home,
              color: Colors.white,
            ),
            title: Text(
              "Home",
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.pushNamed(context, MyRouts.bottomBarRout);
            },
            selectedColor: Colors.grey,
            trailing: Icon(
              CupertinoIcons.chevron_right_circle_fill,
              color: Colors.white,
            ),
          ),
          Divider(
            indent: 0,
            endIndent: 0,
            thickness: 2,
          ),
          ListTile(
            dense: true,
            visualDensity: VisualDensity(horizontal: 0, vertical: -4),
            leading: Image.asset(
              "images/pickup-car.png",
              scale: 25,
            ),
            title: Text(
              "Pickup List",
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.pushNamed(context, MyRouts.pickupListRout);
            },
            selectedColor: Colors.grey,
            trailing: Icon(
              CupertinoIcons.chevron_right_circle_fill,
              color: Colors.white,
            ),
          ),
          ListTile(
            visualDensity: VisualDensity(horizontal: 0, vertical: -4),
            leading: Image.asset(
              "images/verification-of-delivery-list-clipboard-symbol.png",
              scale: 25,
            ),
            title: Text(
              "Pickup History",
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.pushNamed(context, MyRouts.pickupHistoryRout);
            },
            selectedColor: Colors.grey,
            trailing: Icon(
              CupertinoIcons.chevron_right_circle_fill,
              color: Colors.white,
            ),
          ),
          Divider(
            indent: 0,
            endIndent: 0,
            thickness: 2,
          ),
          ListTile(
            visualDensity: VisualDensity(horizontal: 0, vertical: -4),
            leading: Image.asset(
              "images/drslist2.png",
              scale: 10,
            ),
            title: Text(
              "Drs List",
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.pushNamed(context, MyRouts.drsListRout);
            },
            selectedColor: Colors.grey,
            trailing: Icon(
              CupertinoIcons.chevron_right_circle_fill,
              color: Colors.white,
            ),
          ),
          ListTile(
            visualDensity: VisualDensity(horizontal: 0, vertical: -4),
            leading: Image.asset(
              "images/verification-of-delivery-list-clipboard-symbol.png",
              scale: 25,
            ),
            title: Text(
              "Drs History",
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.pushNamed(context, MyRouts.drsHistory);
            },
            selectedColor: Colors.grey,
            trailing: Icon(
              CupertinoIcons.chevron_right_circle_fill,
              color: Colors.white,
            ),
          ),
          Divider(
            indent: 0,
            endIndent: 0,
            thickness: 2,
          ),
          ListTile(
            visualDensity: VisualDensity(horizontal: 0, vertical: -4),
            leading: Image.asset(
              "images/user.png",
              scale: 25,
            ),
            title: Text(
              "Profile",
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.pushNamed(context, MyRouts.profileRout);
            },
            selectedColor: Colors.grey,
            trailing: Icon(
              CupertinoIcons.chevron_right_circle_fill,
              color: Colors.white,
            ),
          ),
          ListTile(
            visualDensity: VisualDensity(horizontal: 0, vertical: -4),
            leading: Image.asset(
              "images/mobscan.png",
              scale: 17,
            ),
            title: Text(
              "Scan Awb",
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.pushNamed(context, MyRouts.scanawbRout);
            },
            selectedColor: Colors.grey,
            trailing: Icon(
              CupertinoIcons.chevron_right_circle_fill,
              color: Colors.white,
            ),
          ),
          Divider(
            indent: 0,
            endIndent: 0,
            thickness: 2,
          ),
          Expanded(
              child: Align(
            alignment: Alignment.bottomCenter,
            child: ListTile(
              leading: Icon(
                Icons.logout,
                color: Colors.white,
              ),
              title: Text(
                "LogOut",
                style: TextStyle(color: Colors.white),
              ),
              trailing: Icon(
                CupertinoIcons.chevron_right_circle_fill,
                color: Colors.white,
              ),
              onTap: () {
                Hive.box("AppData").clear();
                Navigator.pushNamed(context, MyRouts.loginRout);
              },
            ),
          ))
        ],
      ),
    );
  }
}
