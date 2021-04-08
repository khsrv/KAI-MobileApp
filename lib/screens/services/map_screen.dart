import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kai_mobile_app/bloc/service_menu_bloc.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';


class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(55.797056, 49.114957),
    zoom: 12,
  );

  Set<Marker> _markers = {
    Marker(
        markerId: MarkerId('Kai1'),
        position: LatLng(55.797048, 49.114148),
    ),
    Marker(
      markerId: MarkerId('Kai2'),
      position: LatLng(55.822680, 49.136085),
    ),
    Marker(
      markerId: MarkerId('Kai3'),
      position: LatLng(55.792372, 49.137514),
    ),
    Marker(
      markerId: MarkerId('Kai4'),
      position: LatLng(55.793131, 49.137397),
    ),
    Marker(
      markerId: MarkerId('Kai5'),
      position: LatLng(55.797139, 49.124183),
    ),
    Marker(
      markerId: MarkerId('Kai6'),
      position: LatLng(55.854229, 49.098060),
    ),
    Marker(
      markerId: MarkerId('Kai7'),
      position: LatLng(55.796941, 49.133849),
    ),
    Marker(
      markerId: MarkerId('Kai8'),
      position: LatLng(55.820845, 49.135951),
    ),
    Marker(
      markerId: MarkerId('KaiOlimp'),
      position: LatLng(55.820243, 49.139490),
    ),

  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            
          ),
          onPressed: () {
            serviceMenu..backToMenu();
          },
        ),
        title: Text(
          "Карта",
       
        ),
        centerTitle: true,
       
      ),
      body: GoogleMap(
        markers: _markers,
        mapType: MapType.normal,
        
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
