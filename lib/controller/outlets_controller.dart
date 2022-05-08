// import 'package:get/get.dart';
// import 'package:mobitrack_dv_flutter/controller/database_controller.dart';
// import 'package:mobitrack_dv_flutter/controller/location_controller.dart';
// import 'package:mobitrack_dv_flutter/model/outlet.dart';
// import 'package:mobitrack_dv_flutter/utils/constants.dart';
// import 'package:mobitrack_dv_flutter/utils/utilities.dart';
//
// import '../model/distributor_route.dart';
//
// class OutletsController extends GetxController {
//   List<Outlet> outletList = [] ;
//   List<Outlet> searchList = [];
//   List<Outlet> serachroutelist = [];
//
//   String selectedoutlet = "";
//
//
//   searchroute(String text) {
//     if (outletList.isNotEmpty) {
//       serachroutelist = outletList
//           .where((element) =>
//           element.route.toLowerCase().contains(text.toLowerCase())).toList();
//       update();
//     }
//   }
//   searchOutlets(String text) {
//     if (outletList != null && outletList.isNotEmpty) {
//       searchList = outletList
//           .where((element) =>
//           element.name.toLowerCase().contains(text.toLowerCase()))
//           .toList();
//       update();
//     }
//   }
//   OutletsController() {
//     // if (Constants.selectedDistributor != null)
//     fetchOutlets();
//   }
//
//   addOutlet(Outlet o) {
//     outletList.add(o);
//     update();
//   }
//
//   setSelectedoutlet(String outlet) {
//     selectedoutlet = outlet;
//     update();
//   }
//
//   // searchRoute(String Text){
//   //   if(outletList.isNotEmpty){
//   //     se
//   //   }
//   // }
//
//   // getOutletList() {
//   //
//   //   selectedoutlet(outletList.first);
//   // }
//   //
//   // Future<bool> syncData() async {
//   //   var offlineList = outletList.where((element) => !element.synced).toList();
//   //   for (var i = 0; i < offlineList.length; i++) {
//   //     var item = offlineList[i];
//   //     var res = await registerOutlet(item);
//   //     if (res.success) {
//   //       await DatabaseHelper.instance.updateOutlet(item);
//   //       outletList
//   //           .where((element) => element.outid == item.outid)
//   //           .toList()
//   //           .first
//   //           .synced = true;
//   //       update();
//   //     }
//   //   }
//   //   update();
//   //   return true;
//   // }
// //final out;
//   Future<List<Outlet>> getoutlet(String query) async{
//     query = Constants.selectedOutlets.route.toString();
//    //return query;
//    // var conn = await Utilities.isInternetWorking();
//    //  if(conn){
//    //    await fetchOutletsApi().then((value)  async{
//    //      List<Outlet> outletList = value.response;
//    //
//    //
//    //      List.of(outletList).where((element) {
//    //        if(element.route.toString() == Constants.selectedOutlets.route){
//    //          final out = element.name.toLowerCase();
//    //          final quey = query.toLowerCase();
//    //          // Constants.selectedOutlets =  element.name.toLowerCase() ;
//    //          print(out);
//    //          return out.contains(query.toLowerCase());
//    //
//    //        }else{
//    //          final out = element.name.toLowerCase();
//    //          final quey = query.toLowerCase();
//    //          // Constants.selectedOutlets =  element.name.toLowerCase() ;
//    //          return out.contains(quey);
//    //        }
//    //
//    //      }).toString();
//    //      return outletList;
//    //    });
//    //  }
//   }
//   fetchOutlets() async {
//     var conn = await Utilities.isInternetWorking();
//     if (conn) {
//       await fetchOutletsApi().then((value) async {
//         if (value.success) {
//           await DatabaseHelper.instance.deleteSyncedOutlet();
//
//           outletList = value.response;
//
//           outletList.forEach((o) {
//             DatabaseHelper.instance.insertOutlet(o);
//           });
//           update();
//         } else {
//           Utilities.showInToast(value.message, toastType: ToastType.ERROR);
//           outletList = [];
//           update();
//         }
//       });
//     }
//
//
//
//
//
//   }
// }
//
import 'dart:convert';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobitrack_dv_flutter/controller/database_controller.dart';
import 'package:mobitrack_dv_flutter/controller/location_controller.dart';
import 'package:mobitrack_dv_flutter/model/alloutlet.dart';
import 'package:mobitrack_dv_flutter/model/outlet.dart';
import 'package:mobitrack_dv_flutter/model/outlet_post.dart';
import 'package:mobitrack_dv_flutter/utils/constants.dart';
import 'package:mobitrack_dv_flutter/utils/utilities.dart';

import '../model/alloutlet.dart';
import '../model/distributor_route.dart';

class OutletsController extends GetxController {
  List<Outlet> outletList = [];
  List<OutletPost> allOutlet = [];
  List<Outlet> searchList = [];
  List<LatLng> latlng =[];
  Outlet let;
  Outlet get marker =>let;
  var selectedDrowpdown = 'Outlet Closed Image';
  List item = ["Outlet Closed Image","Stock Availabe Image","margin Issue","Owner not in shop","Credit limit Issue"];

  OutletsController() {
    // if (Constants.selectedDistributor != null)
    fetchOutlets();
    fetchOutletss();
    //fetchAllOutlets();
  }

  addoutletInList(String outletid) {
    for (var outet in outletList) {
      if (outletid == outet.id.toString()) {
        outet.selected = true;
        break;
      }
    }
    update();
  }

  // addProductInList(String productId) {
  //   for (var product in productList) {
  //     if (productId == product.id.toString()) {
  //       product.selected = true;
  //       break;
  //     }
  //   }
  //   update();
  // }
  addOutlet(OutletPost o) {
    allOutlet.add(o);
    update();
  }
   setitem(String items){
    //selectedDrowpdown = item.first;

    selectedDrowpdown= items;
    items =Constants.item;
    update();
   }

  // fetchAllOutlets() async {
  //   var conn = await Utilities.isInternetWorking();
  //   if (conn) {
  //     await fetchAllOutletsApi().then((value) async {
  //       if (value.success) {
  //     //    await DatabaseHelper.instance.deleteSyncedOutlet();
  //
  //         allOutlet = value.response;
  //         setitem(item.first);
  //
  //         update();
  //       } else {
  //         Utilities.showInToast(value.message, toastType: ToastType.ERROR);
  //         allOutlet = [];
  //         update();
  //       }
  //     });
  //   }

    // outletList = await DatabaseHelper.instance.getAllOutletData();

    // outletList = list
    //     .where((element) =>
    // element.route ==
    //     Constants.selectedRoute.toString())
    //     .toList();
  //   update();
  //   print(AllOutlet);
  //   //Get.find<LocationController>().setNearestOutletName();
  // }
  // Future<bool> syncData() async {
  //   var offlineList = outletList.where((element) => !element.synced).toList();
  //   for (var i = 0; i < offlineList.length; i++) {
  //     var item = offlineList[i];
  //     var res = await registerOutlet(item);
  //     if (res.success) {
  //       await DatabaseHelper.instance.updateOutlet(item);
  //       outletList
  //           .where((element) => element.outid == item.outid)
  //           .toList()
  //           .first
  //           .synced = true;
  //       update();
  //     }
  //   }
  //   update();
  //   return true;
  // }

  fetchOutlets() async {
    var conn = await Utilities.isInternetWorking();
    if (conn) {
      await fetchOutletsApi().then((value) async {
        if (value.success) {
          await DatabaseHelper.instance.deleteSyncedOutlet();

          outletList = value.response;
          //  let = outletList.forEach((element) {element.latitude.toString();});
          outletList.forEach((o) {
           // DatabaseHelper.instance.insertOutlet(o);
          });
          update();
        } else {
          Utilities.showInToast(value.message, toastType: ToastType.ERROR);
          outletList = [];
          update();
        }
      });
    }
  }
  fetchOutletss() async {
    var conn = await Utilities.isInternetWorking();
    if (conn) {
      await fetchOutletsApis().then((value) async {
        if (value.success) {
          await DatabaseHelper.instance.deleteSyncedOutlet();

          allOutlet = value.response;
          //  let = outletList.forEach((element) {element.latitude.toString();});
          allOutlet.forEach((o) {
            DatabaseHelper.instance.insertOutlet(o);
          });
          update();
        } else {
          Utilities.showInToast(value.message, toastType: ToastType.ERROR);
          outletList = [];
          update();
        }
      });
    }
    // outletList = await DatabaseHelper.instance.getAllOutletData();
    var list = await DatabaseHelper.instance.getAllOutletData();
    // outletList = list
    //     .where((element) =>
    // element.route ==
    //     Constants.selectedRoute.toString())
    //     .toList();
    update();
    print(outletList);
    //Get.find<LocationController>().setNearestOutletName();
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

// import 'package:get/get.dart';
// import 'package:mobitrack_dv_flutter/controller/database_controller.dart';
// import 'package:mobitrack_dv_flutter/controller/location_controller.dart';
// import 'package:mobitrack_dv_flutter/model/outlet.dart';
// import 'package:mobitrack_dv_flutter/utils/constants.dart';
// import 'package:mobitrack_dv_flutter/utils/utilities.dart';
//
// class OutletsController extends GetxController {
//   List<Outlet> outletList = [];
//   List<Outlet> searchList = [];
//
//   OutletsController() {
//     // if (Constants.selectedDistributor != null)
//     fetchOutlets();
//   }
//
//   addOutlet(Outlet o) {
//     outletList.add(o);
//     update();
//   }
//
//   Future<bool> syncData() async {
//     var offlineList = outletList.where((element) => !element.synced).toList();
//     for (var i = 0; i < offlineList.length; i++) {
//       var item = offlineList[i];
//       var res = await registerOutlet(item);
//       if (res.success) {
//         await DatabaseHelper.instance.updateOutlet(item);
//         outletList
//             .where((element) => element.id == item.id)
//             .toList()
//             .first
//             .synced = true;
//         update();
//       }
//     }
//     update();
//     return true;
//   }
//
//   fetchOutlets() async {
//     var conn = await Utilities.isInternetWorking();
//     if (conn) {
//       await fetchOutletsApis().then((value) async {
//         if (value.success) {
//           await DatabaseHelper.instance.deleteSyncedOutlet();
//
//           outletList = value.response;
//
//           outletList.forEach((o) {
//             DatabaseHelper.instance.insertOutlet(o);
//           });
//           update();
//         } else {
//           Utilities.showInToast(value.message, toastType: ToastType.ERROR);
//           outletList = [];
//           update();
//         }
//       });
//     }
//
//     // outletList = await DatabaseHelper.instance.getAllOutletData();
//     var list = await DatabaseHelper.instance.getAllOutletData();
//     outletList = list
//         .where((element) =>
//     element.distributorId ==
//         Constants.selectedDistributor.id.toString())
//         .toList();
//     update();
//     print(outletList);
//     Get.find<LocationController>().setNearestOutletName();
//   }
//
//   searchOutlets(String text) {
//     if (outletList != null && outletList.isNotEmpty) {
//       searchList = outletList
//           .where((element) =>
//           element.name.toLowerCase().contains(text.toLowerCase()))
//           .toList();
//       update();
//     }
//   }
// }
