// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, file_names, unused_field, avoid_init_to_null, avoid_function_literals_in_foreach_calls, no_leading_underscores_for_local_identifiers

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../map_utils.dart';

class DirectionPage extends StatefulWidget {
   final Map<String, dynamic>? args;


  const DirectionPage(this.args,{Key? key}) : super(key: key);
  @override
  _DirectionPageState createState() => _DirectionPageState();
}

class _DirectionPageState extends State<DirectionPage> {
  late CameraPosition _initialPosition;
  final Completer<GoogleMapController> _controller = Completer();
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  var endPosition =null;
  @override
  void initState() {
   
    super.initState();
    _initialPosition = CameraPosition(
      target: LatLng(28.66661,73.88882),
      zoom: 14.4746,
    );
     loadData(widget.args);
  }
loadData(arguments) {
  var data ='${arguments['latitude']},${arguments['longitude']}';
 setState(() {
   endPosition = data;
 });
}
  _addPolyLine() {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id,
        color: Colors.black,
        points: polylineCoordinates,
        width: 1);
    polylines[id] = polyline;
    setState(() {});
  }

  _getPolyline() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        'AIzaSyAkQS7iq1NgOM_r1c60jdzk8ekxGPvRcm4',
        PointLatLng(28.66661,73.88882),
        PointLatLng(26.77789,74.77383),
        travelMode: TravelMode.driving);
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    _addPolyLine();
  }

  @override
  Widget build(BuildContext context) {
    
    Set<Marker> _markers = {
      Marker(
          markerId: MarkerId('start'),
          position: LatLng(28.66661,73.88882)),
      Marker(
          markerId: MarkerId('end'),
          position: LatLng(26.77789,74.77383))
    };

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: CircleAvatar(
            backgroundColor: Colors.white,
            child: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: GoogleMap(
        polylines: Set<Polyline>.of(polylines.values),
        initialCameraPosition: _initialPosition,
        markers: Set.from(_markers),
        onMapCreated: (GoogleMapController controller) {
          Future.delayed(Duration(milliseconds: 2000), () {
            controller.animateCamera(CameraUpdate.newLatLngBounds(
                MapUtils.boundsFromLatLngList(
                    _markers.map((loc) => loc.position).toList()),
                1));
            _getPolyline();
          });
        },
      ),
    );
  }
}