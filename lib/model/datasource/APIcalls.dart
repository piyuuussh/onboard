import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

Future<List<LatLng>> getDirections(LatLng source, LatLng destination) async {
  const String apiKey = 'AIzaSyB02xjC6S94LIBMhPh81VVVT21kmS7A5Fo';
  final String url = 'https://maps.googleapis.com/maps/api/directions/json?'
      'origin=${source.latitude},${source.longitude}&'
      'destination=${destination.latitude},${destination.longitude}&'
      'key=$apiKey';

  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    if (data['routes'] != null && data['routes'].length > 0) {
      final List<LatLng> polylineCoordinates = [];
      data['routes'][0]['legs'].forEach((leg) {
        leg['steps'].forEach((step) {
          polylineCoordinates
              .addAll(decodePolyline(step['polyline']['points']));
        });
      });
      return polylineCoordinates;
    }
  }
  return [];
}

// Helper function to decode polyline to list of LatLng
List<LatLng> decodePolyline(String encoded) {
  List<LatLng> polyline = [];
  int index = 0, len = encoded.length;
  int lat = 0, lng = 0;

  while (index < len) {
    int b, shift = 0, result = 0;
    do {
      b = encoded.codeUnitAt(index++) - 63;
      result |= (b & 0x1f) << shift;
      shift += 5;
    } while (b >= 0x20);
    int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
    lat += dlat;

    shift = 0;
    result = 0;
    do {
      b = encoded.codeUnitAt(index++) - 63;
      result |= (b & 0x1f) << shift;
      shift += 5;
    } while (b >= 0x20);
    int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
    lng += dlng;

    polyline.add(LatLng(lat / 1E5, lng / 1E5));
  }
  return polyline;
}
