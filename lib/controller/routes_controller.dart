import 'package:get/get.dart';
import 'package:mobitrack_dv_flutter/controller/database_controller.dart';
import 'package:mobitrack_dv_flutter/model/routes.dart';
import 'package:mobitrack_dv_flutter/utils/constants.dart';
import 'package:mobitrack_dv_flutter/utils/utilities.dart';

import '../model/address.dart';

class Routecontroller extends GetxController {
  List<Routes>? routeList = [];
  Routes? routes ;
  List<Routes>? searchedroutelist = [];
  String? selectedroute;
  int? selectedid =0 ;
  DatabaseHelper? databaseHelper = DatabaseHelper.instance;
  List<Routes>? routess= [];


  Routecontroller() {
    fetchroute();
  }
  setSelectedProvince(String route ){
   // selectedroute = route;
    var list = routeList!.where((element) => element.routename == route);
    selectedroute = list.first.routename.toString();
    selectedid = list.first.id;
    update();
    //selectedid = route_id;
  }
  //
  fetchroute() {
    fetchRouteApi().then((value) {
      if (value.success!) {
        routeList = value.response;
        print(routeList!.length);
       // setSelectedProvince(routeList.first.id.toString());
        update();
      } else {
        Utilities.showInToast(value.message!, toastType: ToastType.ERROR);
        routeList = [];
        update();
      }
    });
  }
  // intifunction() async{
  //   var conn = await Utilities.isInternetWorking();
  //   if(conn) {
  //     var resp = await fetchRoutes();
  //     Constants.selectedroute= resp.response;
  //   }
  // }
  // fetchroute() {
  //   fetchDayWiseRouteApi().then((value) {
  //     if (value.success) {
  //       routeList = value.response;
  //       setSelectedProvince(routeList.first.id.toString());
  //       update();
  //     } else {
  //       Utilities.showInToast(value.message, toastType: ToastType.ERROR);
  //       routeList = [];
  //       update();
  //     }
  //   });
  // }

  storeRouteOffline(Routes route) async {
    //sales.id = DateTime.now().millisecondsSinceEpoch;
    databaseHelper!.insertroutes(route).then((value) {
      if (value) {
        routess!.add(route);
       // localSalesList.add(sales);
        print(route);
        update();
        Utilities.showInToast("Sales Route locally",
            toastType: ToastType.SUCCESS);
        Get.back();
      } else {
        Utilities.showInToast("Error storing sales locally",
            toastType: ToastType.ERROR);
      }
    });
  }
  //  getAllData() async  {
  //   var noteMapList = await DatabaseHelper.instance.getroute();
  //   //   note = Get.find<OutletsController>().outletLists.where((element) => element.id == item).first.name.toString();
  //
  //     route = noteMapList;
  //    update();
  // }
  searchDistributor(String text) {
    if (routeList!.isNotEmpty) {
      searchedroutelist = routeList!
          .where((element) =>
          element.routename!.toLowerCase().contains(text.toLowerCase()))
          .toList();
      update();
    }
  }
}
