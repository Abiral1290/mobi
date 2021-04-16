import 'package:get/get.dart';
import 'package:mobitrack_dv_flutter/model/outlet.dart';
import 'package:mobitrack_dv_flutter/utils/utilities.dart';

class OutletsController extends GetxController {
  List<Outlet> outletList;
  List<Outlet> searchList = [];

  OutletsController() {
    fetchOutlets();
  }

  fetchOutlets() {
    fetchOutletsApi().then((value) {
      if (value.success) {
        outletList = value.response;
        update();
      } else {
        Utilities.showInToast(value.message, toastType: ToastType.SUCCESS);
        outletList = [];
        update();
      }
    });
  }

  searchOutlets(String text) {
    if (outletList != null && outletList.isNotEmpty) {
      searchList = outletList
          .where((element) =>
              element.name.toLowerCase().contains(text.toLowerCase()))
          .toList();
      update();
    }
  }
}
