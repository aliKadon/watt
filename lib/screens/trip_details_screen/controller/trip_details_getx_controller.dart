import 'dart:convert';

import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:watt_assessment/presentations/resources/constants_manager.dart';

import '../../home_screen/controller/home_getx_controller.dart';

class TripDetailsGetXController extends GetxController {
  //controller
  final HomeGetXController _homeGetXController = Get.find<HomeGetXController>();

  List<LatLng> polylineCoordinates = [];
  var distance = '0';
  var duration = '0';
  late DateTime dateTime;
  var distanceInDouble = 0.0;

  Future<void> getPolyPoints(LatLng source, LatLng destination) async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        AppConstants.google_key_map,
        PointLatLng(_homeGetXController.selectedLatLngSource!.latitude,
            _homeGetXController.selectedLatLngSource!.longitude),
        PointLatLng(_homeGetXController.selectedLatLngDestination!.latitude,
            _homeGetXController.selectedLatLngDestination!.longitude));
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        );
      });
    }
    update();
  }

  Future<void> getDurationGoogleMap() async {
    var Url = Uri.parse(
        'https://maps.googleapis.com/maps/api/directions/json?origin=${_homeGetXController.selectedLatLngSource!.latitude},${_homeGetXController.selectedLatLngSource!.longitude}&destination=${_homeGetXController.selectedLatLngDestination!.latitude},${_homeGetXController.selectedLatLngDestination!.longitude}&key=${AppConstants.google_key_map}');
    final response = await http.get(Url);
    final data = jsonDecode(response.body);

    try {
      final data = jsonDecode(response.body);
      distance = data["routes"][0]["legs"][0]["distance"]["text"];
      duration = data["routes"][0]["legs"][0]["duration"]["text"];
      update();
    } catch (e) {
      print(e);
    }
  }

  Duration parseDurationString(String durationString) {
    List<String> parts = durationString.split(' ');

    int hours = 0;
    int minutes = 0;

    for (int i = 0; i < parts.length; i += 2) {
      int value = int.parse(parts[i]);
      String unit = parts[i + 1];

      if (unit.contains('hour')) {
        hours = value;
      } else if (unit.contains('min')) {
        minutes = value;
      }
    }

    return Duration(hours: hours, minutes: minutes);
  }
}
