import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobitrack_dv_flutter/controller_bindings.dart';
import 'package:mobitrack_dv_flutter/view/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'MobiTrack DV',
      initialBinding: ControllerBindings(),
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      home: SplashScreen(),
      // home: GetBuilder<AuthController>(
      //   builder: (authController) {
      //     return Get.find<AuthController>().isLoggedIn
      //         ? HomePage()
      //         : LoginPage();
      //   },
      // ),
    );
  }
}
