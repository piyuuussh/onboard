import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:onboard/model/datasource/APIcalls.dart';

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({super.key});

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

List<Marker> _markers = [
  Marker(
    markerId: MarkerId('1'),
    position: LatLng(19.12284, 72.99966),
    infoWindow: InfoWindow(title: 'Source'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
  ),
  Marker(
    markerId: MarkerId('2'),
    position: LatLng(19.1306, 73.003416),
    infoWindow: InfoWindow(title: 'Destination'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
  ),
];

GoogleMapController? mapController;
List<LatLng> _route = [];

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  LatLng sourceLocation = LatLng(19.12284, 72.99966);
  LatLng destinationLocation = LatLng(19.1306, 73.003416);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    _fetchRoute();
  }

  Future<void> _fetchRoute() async {
    final List<LatLng> route =
        await getDirections(sourceLocation, destinationLocation);
    setState(() {
      _route = route;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(target: sourceLocation, zoom: 14),
      mapType: MapType.normal,
      markers: Set<Marker>.of(_markers),
      onMapCreated: _onMapCreated,
      polylines: {
        Polyline(
          polylineId: PolylineId('route'),
          points: _route,
          color: Colors.blue,
          width: 5,
        ),
      },
    );
  }
}
