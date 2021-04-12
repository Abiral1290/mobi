import 'package:get/get.dart';
import 'package:mobitrack_dv_flutter/model/outlet.dart';

class OutletsController extends GetxController {
  List<Outlet> outletList;
  List<Outlet> searchList = [];

  OutletsController() {
    getOutlets();
  }

  getOutlets() {
    fetchOutletsApi().then((value) {
      if (value.response != null) {
        outletList = value.response;
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
