import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watt_assessment/app/utils/helpers.dart';

import '../../home_screen/home_page.dart';

class LoginGetXController extends GetxController with Helpers{

  late final GlobalKey<FormState> formKey = GlobalKey();

   String emailText = "";
   String passwordText = "";

  void login({required BuildContext context}) {
    if (!formKey.currentState!.validate())
      return;
    formKey.currentState!.save();
    if (emailText !=
        "admin" ||
        passwordText !=
            "P@ssw0rd") {
      showSnackBar(context,
          message:
          "Invalid email or password!",error: true);
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => MyHomePage(),
        ),
      );
    }
  }
}