import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:watt_assessment/widgets/choose_location_sheet.dart';

import '../../app/utils/helpers.dart';
import 'controller/home_getx_controller.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with Helpers {
  //controller
  final HomeGetXController _homeGetXController = Get.put(HomeGetXController());

  @override
  void initState() {
    _homeGetXController
        .determinePosition()
        .then((value) => _homeGetXController.getLocation());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Choose location"),
      ),
      body: GetBuilder<HomeGetXController>(
        builder: (controller) => controller.isLoading == true
            ? SizedBox(
                height: MediaQuery.of(context).size.height * 1,
                child: Center(
                    child: showLoadingDialog(
                        context: context, title: "Loading map")),
              )
            : Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  SizedBox(
                    height: 720.h,
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: LatLng(
                            double.parse(
                                (controller.position!.latitude).toString()),
                            double.parse(
                                (controller.position!.longitude).toString())),
                        zoom: 13.5,
                      ),
                      markers: {
                        Marker(
                          markerId: const MarkerId("source"),
                          icon: BitmapDescriptor.defaultMarkerWithHue(
                              BitmapDescriptor.hueOrange),
                          infoWindow: const InfoWindow(title: "Home"),
                          position: LatLng(
                              double.parse(
                                  (controller.selectedLatLngSource!.latitude)
                                      .toString()),
                              double.parse(
                                  (controller.selectedLatLngSource!.longitude)
                                      .toString())),
                        ),
                        Marker(
                          markerId: const MarkerId("destination"),
                          icon: BitmapDescriptor.defaultMarkerWithHue(
                              BitmapDescriptor.hueViolet),
                          infoWindow: const InfoWindow(title: "Destination"),
                          position: LatLng(
                              double.parse((controller
                                      .selectedLatLngDestination!.latitude)
                                  .toString()),
                              double.parse((controller
                                      .selectedLatLngDestination!.longitude)
                                  .toString())),
                        ),
                      },
                      onTap: (latLng) async {
                        setState(() {
                          if (controller.isDestination == true) {
                            controller.selectedLatLngDestination = latLng;
                            controller
                                .getAddressFromLatLong(latLng)
                                .then((value) {
                              _homeGetXController
                                  .destinationEditingController.text = value;
                              controller.locationTextDestination = value;
                            });
                          } else {
                            controller.selectedLatLngSource = latLng;
                            controller
                                .getAddressFromLatLong(latLng)
                                .then((value) {
                              _homeGetXController
                                  .sourceEditingController.text = value;
                              controller.locationTextSource = value;
                            });
                          }
                        });
                      },
                    ),
                  ),
                  SlidingUpPanel(
                    maxHeight: 310.h,
                    minHeight: 80.h,
                    borderRadius: BorderRadius.circular(25.r),
                    panel: ChooseLocationSheet(),
                    ),
                ],
              ),
      ),
    );
  }
}
