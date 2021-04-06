import 'package:get/get.dart';
import 'package:mobitrack_dv_flutter/controller/auth_controller.dart';
import 'package:mobitrack_dv_flutter/controller/location_controller.dart';
import 'package:mobitrack_dv_flutter/controller/preference_controller.dart';

class ControllerBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<PreferenceController>(PreferenceController(), permanent: true);
    Get.put<AuthController>(AuthController(), permanent: true);
    Get.lazyPut<LocationController>(() => LocationController());
  }
}
