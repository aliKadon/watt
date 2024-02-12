import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watt_assessment/screens/login_screen/login_page.dart';

import '../presentations/resources/string_manager.dart';
import '../presentations/resources/theme_manager.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: AppString.appName,
          debugShowCheckedModeBanner: false,
          theme: getApplicationTheme(),
          home:  LoginPage(),
        );
      },
    );
  }
}