// ignore_for_file: prefer_const_constructors, prefer_collection_literals

// import 'package:curvdnavbar/homepage.dart';
// import 'package:curvdnavbar/map.dart';
// import 'package:curvdnavbar/profile.dart';
// import 'package:curvdnavbar/search.dart';
// import 'package:curvdnavbar/setting.dart';
// import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'package:courierv9/pages/profile.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'components/mydrawer.dart';
import 'drs_screens/drs_list.dart';
import 'home_page.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);
  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  final navigationkey = GlobalKey<CurvedNavigationBarState>();
  int index = 1;
  final screens = [
    // const Page1(),
    // const Page2(),
    const DrsList(),
    const HomePage(),
    const Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    final items = [
      // Icon(Icons.search, size: 30),
      // Icon(Icons.settings, size: 30),
      Image.asset(
        "images/drslist2.png",
        scale: 7,
      ),
      Icon(Icons.home, size: 30),
      Icon(Icons.person, size: 30),
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Center(
          child: Padding(
              padding: const EdgeInsets.only(right: 48.0),
              child: Image.asset(
                "images/logo.png",
                scale: 3,
                color: Colors.white,
              )),
        ),
      ),
      drawer: MySidebar(),
      extendBody: true,
      backgroundColor: Color.fromARGB(237, 223, 180, 213),
      body: screens[index],
      bottomNavigationBar: Theme(
        data: Theme.of(context)
            .copyWith(iconTheme: IconThemeData(color: Colors.white)),
        child: CurvedNavigationBar(
          backgroundColor: Colors.transparent,
          color: Colors.cyan,
          height: 60,
          animationCurve: Curves.linear,
          animationDuration: Duration(milliseconds: 600),
          items: items,
          index: index,
          onTap: (index) => setState(() => this.index = index),
        ),
      ),
    );
  }
}
