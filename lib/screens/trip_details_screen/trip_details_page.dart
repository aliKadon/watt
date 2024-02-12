import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:watt_assessment/app/utils/helpers.dart';
import 'package:watt_assessment/screens/trip_details_screen/controller/trip_details_getx_controller.dart';

import '../../widgets/trip_details_sheet.dart';
import '../home_screen/controller/home_getx_controller.dart';

class TripDetailsPage extends StatefulWidget {
  @override
  State<TripDetailsPage> createState() => _TripDetailsPageState();
}

class _TripDetailsPageState extends State<TripDetailsPage> with Helpers {
  //controller
  final HomeGetXController _homeGetXController = Get.find<HomeGetXController>();
  final TripDetailsGetXController _tripDetailsPage =
      Get.put(TripDetailsGetXController());

  GoogleMapController? mapController;
  late LatLng locationUpdated;
  var dropDate;

  // function to listen to updated positions
  Future<Position> listenToUpdateInPosition() async {
    locationUpdated = LatLng(_homeGetXController.position!.latitude,
        _homeGetXController.position!.longitude);
    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
    );
    StreamSubscription<Position> positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position? position1) {
      mapController!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(position1!.latitude, position1.longitude),
            zoom: 14.0,
          ),
        ),
      );
      setState(() {
        locationUpdated = LatLng(position1.latitude, position1.longitude);
      });
    });
    return _homeGetXController.position!;
  }

  @override
  void initState() {
    _tripDetailsPage.getPolyPoints(_homeGetXController.selectedLatLngSource!,
        _homeGetXController.selectedLatLngSource!);
    listenToUpdateInPosition();
    _tripDetailsPage.dateTime = DateTime.now();
    _tripDetailsPage.getDurationGoogleMap().then((value) => dropDate =
        _tripDetailsPage.parseDurationString(_tripDetailsPage.duration));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          _tripDetailsPage.polylineCoordinates = [];
          Navigator.of(context).pop();
          return false;
        },
        child: GetBuilder<TripDetailsGetXController>(
          builder: (controller) => Container(
            color: Colors.grey.withOpacity(0.1),
            height: double.infinity,
            child: Stack(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 1,
                  child: GetBuilder<HomeGetXController>(
                    builder: (controller1) => GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: LatLng(controller1.position!.latitude,
                            controller1.position!.longitude),
                        zoom: 13.5,
                      ),
                      markers: {
                        Marker(
                            markerId: const MarkerId("source"),
                            icon: BitmapDescriptor.defaultMarkerWithHue(
                                BitmapDescriptor.hueOrange),
                            position: LatLng(
                                controller1.selectedLatLngSource!.latitude,
                                controller1.selectedLatLngSource!.longitude),
                            infoWindow: const InfoWindow(title: "Home")),
                        Marker(
                          markerId: MarkerId("update"),
                          position: locationUpdated!,
                          // icon: bitmapDescriptorSource,
                        ),
                        Marker(
                          markerId: const MarkerId("destination"),
                          icon: BitmapDescriptor.defaultMarkerWithHue(
                              BitmapDescriptor.hueViolet),
                          infoWindow: InfoWindow(title: "Destination"),
                          position: LatLng(
                              double.parse((controller1
                                      .selectedLatLngDestination!.latitude)
                                  .toString()),
                              double.parse((controller1
                                      .selectedLatLngDestination!.longitude)
                                  .toString())),
                        ),
                      },
                      polylines: {
                        Polyline(
                          polylineId: const PolylineId("route"),
                          points: controller.polylineCoordinates,
                          color: const Color(0xFF7B61FF),
                          width: 3,
                        ),
                      },
                      onMapCreated: (GoogleMapController controller2) {
                        // _homeGetXController.googleController.complete(controller);
                        mapController = controller2;
                      },
                    ),
                  ),
                ),
                dropDate == null
                    ? Container()
                    : SlidingUpPanel(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(50.r)),
                        maxHeight: 550.h,
                        minHeight: 70.h,
                        panel: TripDetailsSheet(dropDate: dropDate),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
