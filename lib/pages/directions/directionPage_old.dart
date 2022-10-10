// ignore_for_file: file_names, prefer_const_constructors, prefer_interpolation_to_compose_strings, avoid_print

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DirectionPage extends StatefulWidget {
      final Map<String, dynamic>? args;
  const DirectionPage(this.args,{Key? key}) : super(key: key);

  @override
  State<DirectionPage> createState() => _DirectionPageState();
}

class _DirectionPageState extends State<DirectionPage> {
  
  final Completer<GoogleMapController> _controller = Completer();
  
  final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(28.01664, 73.3110343),
    // target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  final List<Marker> _marker = [];
  final List<Marker> _list = [];
  final Set<Polyline> _polyline = {};


  @override
  void initState() {
    super.initState();
    _marker.addAll(_list);
    loadData(widget.args);
  }

  loadData(arguments) {
       // print(arguments.latitude.toString() + " " + arguments.longitude.toString());
       
    getDriverCurrentLocation().then((value) async {
     
     List<LatLng> latLen = [
    LatLng(value.latitude, value.longitude),
    LatLng(arguments['latitude'], arguments['longitude']),
  ];
      

      _marker.addAll([
        Marker(
          markerId: MarkerId('1'),
          position: LatLng(value.latitude, value.longitude),
          infoWindow: InfoWindow(title: 'My current location11111')
        ),
        Marker(
         markerId: MarkerId('2'),
          position: LatLng(arguments['latitude'], arguments['longitude']),
          infoWindow: InfoWindow(title: '2 asdasd')
        )]
      );
      
      _polyline.add(
          Polyline(
            polylineId: PolylineId('1'),
            points: latLen,
            color: Colors.red,
            width: 1
          )
      );

    

      CameraPosition cameraPosition = CameraPosition(
          zoom: 15, target: LatLng(value.latitude, value.longitude));
      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      setState(() {});
    });

    



  }

  Future<Position> getDriverCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {
      print('error' + error.toString());
    });

    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        // mapType: MapType.normal,
        // myLocationEnabled: true,
        polylines: _polyline,
        markers: Set<Marker>.of(_marker),
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          getDriverCurrentLocation().then((value) async {
            // print('my current location');
            // print(value.latitude.toString() + " " + value.longitude.toString());
            _marker.add(Marker(
                markerId: MarkerId('2'),
                position: LatLng(value.latitude, value.longitude),
                infoWindow: InfoWindow(title: 'My current location')));

            CameraPosition cameraPosition = CameraPosition(
                zoom: 14, target: LatLng(value.latitude, value.longitude));
            final GoogleMapController controller = await _controller.future;
            controller
                .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
            setState(() {});
          });
        },
        child: const Icon(Icons.local_activity),
      ),
    );
  }
}
