import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:watt_assessment/app/utils/helpers.dart';
import 'package:watt_assessment/presentations/resources/color_manager.dart';
import 'package:watt_assessment/presentations/resources/font_manager.dart';
import 'package:watt_assessment/screens/home_screen/home_page.dart';
import 'package:watt_assessment/screens/login_screen/controller/login_getx_controller.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with Helpers {

  //controller
  final LoginGetXController _loginGetXController = Get.put(LoginGetXController());
  var passwordVisible = true;
  // late final GlobalKey<FormState> formKey = GlobalKey();
  // final TextEditingController _emailEditingController = TextEditingController();
  // final TextEditingController _passwordEditingController =
  //     TextEditingController();

  // @override
  // void dispose() {
  //   super.dispose();
  //   _emailEditingController.dispose();
  //   _passwordEditingController.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: GetBuilder<LoginGetXController>(
          builder: (controller) => Form(
            key: controller.formKey,
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    ClipPath(
                        clipper: NewClipper(),
                        child: Container(
                          color: ColorManager.primary,
                          height: 800.h,
                          width: MediaQuery.of(context).size.width * 1,
                        )),
                    PositionedDirectional(
                      top: 250.h,
                      child: Container(
                        width: 300.w,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Log in",
                              style: TextStyle(
                                  color: ColorManager.primary,
                                  fontSize: FontSize.s20,
                                  fontWeight: FontWeight.w900),
                            ),
                            SizedBox(height: 25.h),
                            TextFormField(
                              onSaved: (value) {
                                controller.emailText = value!;
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty)
                                  return "Please enter the email";
                                return null;
                              },
                              decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.email),
                                  prefixIconColor: ColorManager.primary,
                                  border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20.0)),
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20.0)),
                                    borderSide:
                                        BorderSide(color: ColorManager.primary),
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20.0)),
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  hintText: "Email or user name",
                                  hintStyle: const TextStyle(color: Colors.grey)),
                            ),
                            SizedBox(height: 20.h),
                            TextFormField(
                              onSaved: (value) {
                                controller.passwordText = value!;
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty)
                                  return "Please enter the password";
                                return null;
                              },
                              obscureText: passwordVisible,
                              decoration: InputDecoration(
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        passwordVisible = !passwordVisible;
                                      });
                                    },
                                    child: passwordVisible == true
                                        ? const Icon(
                                            Icons.visibility_off,
                                          )
                                        : const Icon(
                                            Icons.visibility,
                                          ),
                                  ),
                                  prefixIcon: const Icon(Icons.lock),
                                  prefixIconColor: ColorManager.primary,
                                  border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20.0)),
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20.0)),
                                    borderSide:
                                        BorderSide(color: ColorManager.primary),
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20.0)),
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  hintText: "Password",
                                  hintStyle: TextStyle(color: Colors.grey)),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: TextButton(
                                  onPressed: () {},
                                  child: const Text(
                                    "Forget password?",
                                    style: TextStyle(color: Colors.blue),
                                  )),
                            ),
                            Center(
                              child: SizedBox(
                                height: 50.h,
                                width: 250.w,
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                        shape: MaterialStatePropertyAll(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        25.r)))),
                                    onPressed: () {
                                      controller.login(context: context);
                                      // if (!formKey.currentState!.validate())
                                      //   return;
                                      // formKey.currentState!.save();
                                      // if (_emailEditingController.text !=
                                      //         "admin" ||
                                      //     _passwordEditingController.text !=
                                      //         "P@ssw0rd") {
                                      //   showSnackBar(context,
                                      //       message:
                                      //           "Invalid email or password!",error: true);
                                      // } else {
                                      //   Navigator.of(context).pushReplacement(
                                      //     MaterialPageRoute(
                                      //       builder: (context) => MyHomePage(),
                                      //     ),
                                      //   );
                                      // }
                                    },
                                    child:
                                        const Text("Log in with your account")),
                              ),
                            ),
                            SizedBox(height: 30.h),
                            Text(
                              "Log in with",
                              style: TextStyle(
                                  color: ColorManager.primary,
                                  fontWeight: FontWeight.w700,
                                  fontSize: FontSize.s16),
                            ),
                            SizedBox(height: 20.h),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(15.r)),
                              width: 170.w,
                              height: 50.h,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.facebook_outlined,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 10.h),
                                  Text(
                                    "Facebook",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w900,
                                        fontSize: FontSize.s18),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 80.h),
                            Center(
                              child: Container(
                                padding: EdgeInsets.all(10.w),
                                height: 50.h,
                                width: 250.w,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25.r),
                                    border: Border.all(
                                        color: ColorManager.primary, width: 3.w)),
                                child: Text("New user ? Create account",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: ColorManager.primary,
                                        fontWeight: FontWeight.w900,
                                        fontSize: FontSize.s14)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NewClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height / 4.25);
    var firstControlPoint = Offset(size.width / 4, size.height / 3);
    var firstEndPoint = Offset(size.width / 2, size.height / 3 - 60);
    var secondControlPoint =
        Offset(size.width - (size.width / 4), size.height / 4 - 65);
    var secondEndPoint = Offset(size.width, size.height / 3 - 40);

    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, size.height / 3);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => false;
}
