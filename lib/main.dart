import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobitrack_dv_flutter/controller/auth_controller.dart';
import 'package:mobitrack_dv_flutter/controller_bindings.dart';
import 'package:mobitrack_dv_flutter/view/home.dart';
import 'package:mobitrack_dv_flutter/view/login.dart';

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
      home: GetBuilder<AuthController>(
        builder: (authController) {
          return Get.find<AuthController>().isLoggedIn
              ? HomePage()
              : LoginPage();
        },
      ),
    );
  }
}
