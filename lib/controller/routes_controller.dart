import 'package:get/get.dart';
import 'package:mobitrack_dv_flutter/controller/database_controller.dart';
import 'package:mobitrack_dv_flutter/model/routes.dart';
import 'package:mobitrack_dv_flutter/utils/utilities.dart';

import '../model/address.dart';

class Routecontroller extends GetxController {
  List<Routees> routeList = [];
  List<Routees> searchedroutelist = [];
  String selectedroute = "";
  int selectedid ;

  Routecontroller() {
    fetchroute();
  }
  setSelectedProvince(String route,  ){
    selectedroute = route;
    //selectedid = route_id;

  }

  fetchroute() {
    fetchRouteApi().then((value) {
      if (value.success) {
        routeList = value.response;
        setSelectedProvince(routeList.first.id.toString());
        update();
      } else {
        Utilities.showInToast(value.message, toastType: ToastType.ERROR);
        routeList = [];
        update();
      }
    });
  }

  searchDistributor(String text) {
    if (routeList.isNotEmpty) {
      searchedroutelist = routeList
          .where((element) =>
          element.routename.toLowerCase().contains(text.toLowerCase()))
          .toList();
      update();
    }
  }
}