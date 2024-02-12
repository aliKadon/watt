import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:watt_assessment/presentations/resources/font_manager.dart';

import '../presentations/resources/color_manager.dart';
import '../screens/home_screen/controller/home_getx_controller.dart';
import '../screens/trip_details_screen/trip_details_page.dart';

class ChooseLocationSheet extends StatefulWidget {
  @override
  State<ChooseLocationSheet> createState() => _ChooseLocationSheetState();
}

class _ChooseLocationSheetState extends State<ChooseLocationSheet> {
  final HomeGetXController _homeGetXController = Get.find<HomeGetXController>();

  Timer? _timer;
  late final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _homeGetXController.sourceEditingController.text =
        _homeGetXController.locationTextSource;
    _homeGetXController.destinationEditingController.text =
        _homeGetXController.locationTextDestination;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeGetXController>(
      builder: (controller) => Form(
        key: _formKey,
        child: Container(
          width: 400.w,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.r),
                  topRight: Radius.circular(25.r))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 10.h,
                width: 50.w,
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(25.r)),
              ),
              SizedBox(height: 20.h),
              SizedBox(
                width: double.infinity,
                child: Text(
                  "Choose your destination",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                      fontSize: FontSize.s22),
                ),
              ),
              SizedBox(height: 20.h),
              Row(
                children: [
                  SizedBox(width: 15.h),
                  Align(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 270.w,
                            child: TextFormField(
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    value == "Start location") {
                                  return "Select start point";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      controller.selectedLatLngSource = LatLng(
                                          controller.position!.latitude,
                                          controller.position!.longitude);
                                      controller
                                          .getAddressFromLatLong(LatLng(
                                              controller.position!.latitude,
                                              controller.position!.longitude))
                                          .then((value) {
                                        controller.sourceEditingController
                                            .text = value;
                                        controller.locationTextSource = value;
                                      });
                                    },
                                    icon: Icon(
                                      Icons.my_location,
                                      color: ColorManager.primary,
                                    )),
                              ),
                              controller: controller.sourceEditingController,
                              onChanged: (value) {
                                if (_timer?.isActive ?? false) {
                                  _timer!.cancel();
                                }
                                _timer =
                                    Timer(Duration(milliseconds: 1000), () {
                                  if (value.isEmpty ||
                                      value == "End location") {
                                  } else {
                                    controller.autoCompleteSearch(value);
                                  }
                                });
                              },
                              onSaved: (newValue) {
                                controller.locationTextSource = newValue!;
                              },
                            ),
                          ),
                        ],
                      )),
                  Spacer(),
                  IconButton(
                      onPressed: () {
                        controller.isSource = true;
                        controller.isDestination = false;
                        controller.update();
                      },
                      icon: Icon(Icons.location_searching_rounded)),
                  Spacer(),
                ],
              ),
              SizedBox(height: 15.h),
              Row(
                children: [
                  SizedBox(width: 15.h),
                  Align(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 270.w,
                            child: TextFormField(
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    value == "End location") {
                                  return "Select end point";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      controller.selectedLatLngDestination =
                                          LatLng(controller.position!.latitude,
                                              controller.position!.longitude);
                                      controller
                                          .getAddressFromLatLong(LatLng(
                                              controller.position!.latitude,
                                              controller.position!.longitude))
                                          .then((value) {
                                        controller.destinationEditingController
                                            .text = value;
                                        controller.locationTextDestination =
                                            value;
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.my_location,
                                      color: Color(0xFF7B61FF),
                                    )),
                              ),
                              controller:
                                  controller.destinationEditingController,
                              onSaved: (newValue) {
                                controller.locationTextDestination = newValue!;
                              },
                            ),
                          ),
                        ],
                      )),
                  Spacer(),
                  IconButton(
                      onPressed: () {
                        controller.isSource = false;
                        controller.isDestination = true;
                        controller.update();
                      },
                      icon: const Icon(Icons.location_on_outlined,
                          color: Colors.red)),
                  Spacer(),
                ],
              ),
              SizedBox(height: 15.h),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 200.w,
                  child: ElevatedButton(
                    onPressed: () {
                      if (!_formKey.currentState!.validate()) return;
                      _formKey.currentState!.save();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => TripDetailsPage(),
                        ),
                      );
                    },
                    child: const Text("Submit"),
                  ),
                ),
              ),
              SizedBox(height: 15.h),
            ],
          ),
        ),
      ),
    );
  }
}
