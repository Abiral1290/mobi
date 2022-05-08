import 'package:get/get.dart';
import 'package:mobitrack_dv_flutter/model/alloutlet.dart';

import '../utils/utilities.dart';

class AllOutletController extends GetxController {
  List<AllOutlet> alloutlet = [];

  AllOutletController() {
    getAlloutletList();
  }

  getAlloutletList() async {
    var conn = await Utilities.isInternetWorking();
    if (conn) {
      await fetchAllOutletsApi().then((value) async {
        print(value.response);
        if (value.success) {
          alloutlet = value.response;
          update();
          print(alloutlet.length);
          // Get.find<PreferenceController>()
          //     .saveAddress(jsonEncode(value.response));
        } else {
          Utilities.showInToast(value.message, toastType: ToastType.ERROR);
          alloutlet = [];
          update();
        }
      });
    }
  }
}