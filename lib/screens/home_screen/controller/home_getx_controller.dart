import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';

import 'package:watt_assessment/presentations/resources/constants_manager.dart';


class HomeGetXController extends GetxController {
  LatLng? location;
  Position? position;
  late Placemark place;
  late LatLng? selectedLatLngDestination =
      LatLng(position!.latitude, position!.longitude);
 late LatLng? selectedLatLngSource =
      LatLng(position!.latitude, position!.longitude);
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  final TextEditingController sourceEditingController = TextEditingController();
  final TextEditingController destinationEditingController =
  TextEditingController();
  var isLoading = true;
  var isSource = true;
  var isDestination = false;
  List<AutocompletePrediction> listPredictions = [];
  GooglePlace googlePlace = GooglePlace(AppConstants.google_key_map);
  String locationTextSource = "Start location";
  String locationTextDestination = "End location";


  Future<Position> getLocation() async {
    try {
      position = await _geolocatorPlatform
          .getCurrentPosition()
          .then((value) => position = value);
      isLoading = false;
      update();
    } catch (e) {
      print("position error : $e");
    }
    return position!;
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  //get all information from latitude and longitude
  Future<String> getAddressFromLatLong(LatLng latLng) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
    place = placemarks[0];
    String locationText =
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    update();
    return locationText;
  }


  autoCompleteSearch(String search) async {
    var result = await googlePlace.autocomplete.get(search);
    if (result != null && result.predictions != null) {
      listPredictions = result.predictions!;
    }
    print("result : ${result?.status}");
    print("result predictions: ${result?.predictions}");
  }
}
