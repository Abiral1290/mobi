import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobitrack_dv_flutter/controller/auth_controller.dart';
import 'package:mobitrack_dv_flutter/view/credentials/first_widget.dart';
import 'package:mobitrack_dv_flutter/view/dashboard.dart';
import 'package:mobitrack_dv_flutter/view/home.dart';
import 'package:mobitrack_dv_flutter/view/credentials/login.dart';
import 'package:mobitrack_dv_flutter/view/view_distributor.dart';

class CheckAuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (authController) {
        return Get.find<AuthController>().isLoggedIn ? DashBoards() : LoginPage();
      },
    );
  }
}
