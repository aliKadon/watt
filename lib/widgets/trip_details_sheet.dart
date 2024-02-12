import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:watt_assessment/presentations/resources/constants_manager.dart';

import '../presentations/resources/color_manager.dart';
import '../presentations/resources/font_manager.dart';
import '../screens/home_screen/controller/home_getx_controller.dart';
import '../screens/trip_details_screen/controller/trip_details_getx_controller.dart';

class TripDetailsSheet extends StatefulWidget {
  Duration dropDate;

  TripDetailsSheet({required this.dropDate});

  @override
  State<TripDetailsSheet> createState() => _TripDetailsSheetState();
}

class _TripDetailsSheetState extends State<TripDetailsSheet> {

  var _distanceInDouble = 0.0;

  void parseStringToDouble(String tripDistance) {
    List<String> parts = tripDistance.split(' ');

    var distance1 = 0.0;
    distance1 = double.parse(parts[0]);
    _distanceInDouble = distance1;
  }

  @override
  void initState() {

    super.initState();
    parseStringToDouble(_tripDetailsPage.distance);
  }


  final HomeGetXController _homeGetXController = Get.find<HomeGetXController>();
  final TripDetailsGetXController _tripDetailsPage =
      Get.find<TripDetailsGetXController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TripDetailsGetXController>(
      builder: (controller) => Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(25.r)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10.h),
            Container(
              height: 10.h,
              width: 50.w,
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(25.r)),
            ),
            SizedBox(height: 10.h),
            SizedBox(
              width: double.infinity,
              child: Text(
                "Trip details",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                    fontSize: FontSize.s22),
              ),
            ),
            SizedBox(height: 25.h),
            Row(
              children: [
                const Spacer(),
                Container(
                  height: 40.h,
                  padding: EdgeInsets.only(left: 10.w, right: 10.w),
                  // width: 100.w,
                  decoration: BoxDecoration(
                      color: ColorManager.primary.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(15.r)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.map_outlined,color: Colors.white),
                      SizedBox(width: 5.h),
                      Text(
                        "${(controller.distance)}",
                        style: TextStyle(
                            fontSize: FontSize.s18,
                            fontWeight: FontWeight.w800,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 20.w),

                // Spacer(),
                Container(
                  height: 40.h,
                  padding: EdgeInsets.only(left: 10.w, right: 10.w),
                  decoration: BoxDecoration(
                      color: const Color(0xFF7B61FF).withOpacity(0.7),
                      borderRadius: BorderRadius.circular(15.r)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.access_time, color: Colors.white),
                      SizedBox(width: 5.h),
                      Text(
                        "${controller.duration} ",
                        style: TextStyle(
                            fontSize: FontSize.s18,
                            fontWeight: FontWeight.w800,
                            color: Colors.white),
                      ),
                      // Spacer(),
                    ],
                  ),
                ),
                const Spacer(),
                Container(
                  height: 40.h,
                  // width: 130.w,
                  padding: EdgeInsets.only(left: 10.w, right: 10.w),
                  decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(15.r)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.monetization_on_outlined,
                        color: Colors.white,
                      ),
                      SizedBox(width: 5.h),
                      SizedBox(
                        width: 80.w,
                        child: Text("${_distanceInDouble * 2} AED",
                            style: TextStyle(
                                fontSize: FontSize.s18,
                                fontWeight: FontWeight.w800,
                                color: Colors.white)),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
              ],
            ),
            SizedBox(
              height: 25.h,
            ),
            Row(
              children: [
                SvgPicture.asset(
                  color: ColorManager.primary,
                  height: 60.h,
                  '${AppConstants.vectorsPath}home.svg',
                ),
                Text("Start Point",
                    style: TextStyle(
                        color: ColorManager.primary,
                        fontSize: FontSize.s20,
                        fontWeight: FontWeight.w900)),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 29.w),
                DottedLine(
                  direction: Axis.vertical,
                  lineLength: 100.h,
                  lineThickness: 3.0,
                  dashLength: 5.0,
                  dashColor: Colors.grey,
                  dashRadius: 5.0,
                  dashGapLength: 3.0,
                  dashGapColor: Colors.transparent,
                  dashGapGradient: [Colors.white, Colors.white],
                  dashGapRadius: 0.0,
                ),
                SizedBox(width: 20.w),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 250.w,
                      child: Text(_homeGetXController.locationTextSource,
                          style: TextStyle(
                              color: ColorManager.black,
                              fontSize: FontSize.s12,
                              fontWeight: FontWeight.w700)),
                    ),
                    SizedBox(height: 10.w),
                    Text(
                      "Pick up date :${DateFormat('hh:mm a').format(DateTime.parse((_tripDetailsPage.dateTime).toString()))}",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: FontSize.s14,
                          color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(width: 40.w),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 20.w),
                Row(
                  children: [
                    SvgPicture.asset(
                      // color: Colors.red,
                      height: 60.h,
                      // width:20.w,
                      '${AppConstants.vectorsPath}dis.svg',
                    ),
                    Text("End Point",
                        style: TextStyle(
                            color: const Color(0xFF7B61FF),
                            fontSize: FontSize.s20,
                            fontWeight: FontWeight.w900)),
                  ],
                ),
                // SizedBox(width: 20.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(width: 55.w),
                        SizedBox(
                          width: 250.w,
                          child: Text(
                              _homeGetXController.locationTextDestination,
                              style: TextStyle(
                                  color: ColorManager.black,
                                  fontSize: FontSize.s12,
                                  fontWeight: FontWeight.w700)),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.w),
                    Padding(
                      padding: EdgeInsets.only(left: 55.w),
                      child: Text(
                        "Drop down date :${DateFormat('hh:mm a').format(DateTime.parse((_tripDetailsPage.dateTime.add(widget.dropDate)).toString()))}",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: FontSize.s14,
                            color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
