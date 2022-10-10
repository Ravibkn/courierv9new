// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'package:courierv9/pages/bottom_navigation_bar.dart';
import 'package:courierv9/pages/directions/directionPage.dart';
import 'package:courierv9/pages/drs%20history%20page/drs_awb_list.dart';
import 'package:courierv9/pages/drs%20history%20page/drs_history_detall.dart';
import 'package:courierv9/pages/drs_screens/drs_list.dart';
import 'package:courierv9/pages/drs_screens/drs_awb_list.dart';
import 'package:courierv9/pages/drs_screens/drs_detall.dart';
import 'package:courierv9/pages/drs_screens/photo_page.dart';
import 'package:courierv9/pages/drs_screens/sfsignature_page.dart';
import 'package:courierv9/pages/home_page.dart';
import 'package:courierv9/pages/local_auth.dart';
import 'package:courierv9/pages/login_signup_screen.dart';
import 'package:courierv9/pages/map_screen.dart';
import 'package:courierv9/pages/pick_and_drop.dart';
import 'package:courierv9/pages/pick_drop_history.dart';
import 'package:courierv9/pages/pickup%20history%20pages/pickup_awb_page.dart';
import 'package:courierv9/pages/pickup%20history%20pages/pickup_detall_history.dart';
import 'package:courierv9/pages/pickup%20list%20page/pickup_awb_list.dart';
import 'package:courierv9/pages/pickup%20list%20page/pickup_awb_pic.dart';
import 'package:courierv9/pages/pickup%20history%20pages/pickup_history.dart';
import 'package:courierv9/pages/pickup%20list%20page/pickup_detail.dart';
import 'package:courierv9/pages/pickup%20list%20page/pickup_list.dart';
import 'package:courierv9/pages/profile.dart';
import 'package:courierv9/pages/profile_edit.dart';
import 'package:courierv9/pages/routs.dart';
import 'package:courierv9/pages/scan_awb.dart';
import 'package:courierv9/pages/splash_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'pages/drs history page/drs_history.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  //initialize hive
  await Hive.initFlutter();
  //open the box
  final box = await Hive.openBox("AppData");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      title: "Login_Signup UI",
      initialRoute: MyRouts.splashScreenrout,
      routes: {
        MyRouts.loginRout: (context) => LoginSignUpPage(),
        MyRouts.bottomBarRout: (context) => NavBar(),
        MyRouts.drsHistory: (context) => DrsHistory(),
        MyRouts.drsListRout: (context) => DrsList(),
        MyRouts.pickandDropRout: (context) => PickAndDrop(),
        MyRouts.pickandDropHistoryRout: (context) => PickDropHistory(),
        MyRouts.pickupHistoryRout: (context) => PickupHistory(),
        MyRouts.pickupListRout: (context) => PickupList(),
        MyRouts.profileRout: (context) => Profile(),
        MyRouts.scanawbRout: (context) => ScanAwb(),
        MyRouts.drsAwbListRout: (context) => DrsAwbList(
            ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>),
        MyRouts.drsDetallRout: (context) => DrsDetall(
            ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>),
        MyRouts.updateDrsRout: (context) => SfSignnature(
            ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>),
        MyRouts.photoPageRout: (context) => PhotoPage(),
        MyRouts.drsHistoryAwbrout: (context) => DrsAwbHistory(
            ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>),
        MyRouts.drsDetallHistoryRout: (context) => DrsDetallHistory(
            ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>),
        MyRouts.homeScreenRout: (context) => HomePage(),
        MyRouts.pickupawbupdatedaterout: (context) => PickupAwbUpdate(),
        MyRouts.pickupAwbUpdateListRout: (context) => PickupAwbUpdateList(
            ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>),
        MyRouts.pickupDetailRout: (context) => PickupDetail(
            ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>),
        MyRouts.pickupawbhistoryrout: (context) => PickupAwbHistory(
             ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>
        ),
        MyRouts.pickupdetallHistoryrout: (context) => PickupDetallHistory(
             ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>
        ),
        MyRouts.splashScreenrout: (context) => Splash(),
        MyRouts.biomatricrout: (context) => LocalAuth(),
        MyRouts.directionpage: (context) => DirectionPage(
            ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>),
        MyRouts.mapScreenRout: (context) => MapScreen(),
        MyRouts.profileEditRout: (context) => ProfileEdit(),
      },
    );
  }
}
