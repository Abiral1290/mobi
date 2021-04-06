import 'package:get/get.dart';

import 'preference_controller.dart';

class AuthController extends GetxController {
  bool isLoggedIn = false;

  AuthController() {
    getLoggedInData();
  }

  getLoggedInData() {
    Get.find<PreferenceController>().getLogInValue().then((value) {
      if (value != null) {
        isLoggedIn = value;
        update();
      }
    });
  }

  setLoggedInData(bool loggedIn) async {
    Get.find<PreferenceController>().setLoggedIn(loggedIn).then((value) {
      if (value) {
        isLoggedIn = loggedIn;
        update();
      }
    });
  }
}
