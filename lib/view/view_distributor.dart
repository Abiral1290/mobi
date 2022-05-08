// import 'dart:collection';
// import 'dart:convert';
// import 'dart:math';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_typeahead/flutter_typeahead.dart';
// import 'package:get/get.dart';
// import 'package:mobitrack_dv_flutter/controller/distributor_controller.dart';
// import 'package:mobitrack_dv_flutter/controller/distributor_route_controller.dart';
// import 'package:mobitrack_dv_flutter/controller/outlets_controller.dart';
// import 'package:mobitrack_dv_flutter/controller/preference_controller.dart';
// import 'package:mobitrack_dv_flutter/controller/routes_controller.dart';
// import 'package:mobitrack_dv_flutter/model/distributor.dart';
// import 'package:mobitrack_dv_flutter/model/distributor_route.dart';
// import 'package:mobitrack_dv_flutter/utils/constants.dart';
// import 'package:mobitrack_dv_flutter/utils/utilities.dart';
// import 'package:mobitrack_dv_flutter/view/home.dart';
// import 'package:mobitrack_dv_flutter/view/widgets/route.dart';
// import 'package:sliding_up_panel/sliding_up_panel.dart';
//
// import '../controller/database_controller.dart';
// import '../model/outlet.dart';
// import 'package:collection/collection.dart';
//
// class ViewDistributorPage extends StatelessWidget {
//   var _selectedIndex = 0 .obs;
//   var _selectedInde_1 = 0.obs;
//
//   var selectedDistributor = Distributor()
//       .obs; // if user tried to select next time then constants.selectedDistributor is not null so validate using this variable
//
//   var selectedroute = Outlet().obs;
//
//   var outlets = Get.lazyPut(() => OutletsController());
//   bool _lock =false;
//   DatabaseHelper _databaseHelper ;
//   List<Outlet> newlist= OutletsController().outletList;
//   List<Outlet> newlist_1= [];
//   DeepCollectionEquality deepCollectionEquality;
//   UnorderedIterableEquality _equality = UnorderedIterableEquality() ;
//
//
//
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//
//
//
//
//     Widget listroute(List<Outlet> routelist){
//
//
//        // routelist.forEach((element) { newlist_1.removeWhere((e) => element.route==e.route);
//        // newlist_1.add(element);
//        //
//        //
//        // });
//        //
//
//      return ListView.builder(
//        itemCount: routelist.length,
//          itemBuilder: (context, index) {
//      return Obx(
//          () =>
//              Padding(
//                padding: EdgeInsets.all(5),
//                child: Container(
//                  decoration: BoxDecoration(
//                      color: Color(( Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.3),
//                      border: Border.all(
//                          color: Color(( Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.5),
//                          width: 3
//                      ),
//                      borderRadius: BorderRadius.circular(20)
//                  ),
//                  height: Get.size.height * 0.1,
//                  width: Get.size.width ,
//
//                  child: ListTile(
//                          onTap: () async{
//
//
//                            Constants.outletLlist  =newlist_1 ;
//
//                            selectedroute.value = routelist[index];
//
//                                            Utilities.showInToast(
//                                                "Routes: ${newlist_1[index].route}");
//                                                Get.to(HomePage());
//                          },
//                            selected: index == _selectedInde_1.value,
//
//                          leading: Text(
//                           routelist[index].route
//                        ),
//                    ),
//                ),
//              ),
//
//      )  ;
//      });
//     }
//
//     Widget routelist(){
//       return Expanded(child: GetBuilder<OutletsController>(
//         init: OutletsController(),
//         builder: (outletcontroller){
//           return outletcontroller.searchList.isNotEmpty
//               ? listroute(outletcontroller.searchList) :
//           outletcontroller.outletList != null
//               ? outletcontroller.outletList.isEmpty
//                ? Center(child:CircularProgressIndicator()): listroute(outletcontroller.outletList )
//               : Center(child: Text("No Routes"),);
//         },
//
//       ));
//     }
//
//     // Widget routelist (){
//     //   return Expanded(
//     //     child: GetBuilder<Routescontrller>(
//     //       init:  Routescontrller(),
//     //       builder:  (routescontroller){
//     //         return routescontroller.searchroute.isEmpty ?
//     //             listroute(routescontroller.searchroute) : routescontroller.routelist != null ?
//     //
//     //
//     //       },
//     //     ),
//     //   );
//     // }
//
//
//
//
//
//     Widget listSegment(List<Distributor> distList) {
//       return ListView.builder(
//         itemCount: distList.length,
//         itemBuilder: (context, index) {
//           return Obx(
//             () =>
//                 Padding(
//                   padding: EdgeInsets.all(5),
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Color(( Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.3),
//                       border: Border.all(
//                         color: Color(( Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.5),
//                             width: 3
//                       ),
//                       borderRadius: BorderRadius.circular(20)
//                     ),
//                     height: Get.size.height * 0.1,
//                     width: Get.size.width ,
//
//                     child: ListTile(
//               onTap: () async {
//                     Constants.selectedDistributor = distList[index];
//                     selectedDistributor.value = distList[index];
//                     _selectedIndex.value = index;
//                     Get.find<OutletsController>().fetchOutlets();
//                     print(Constants.selectedDistributor);
//                     Get.find<PreferenceController>()
//                         .setDistributor(jsonEncode(Constants.selectedDistributor));
//                     Utilities.showInToast(
//                         "Distributor : ${selectedDistributor.value.name}");
//                     var distributor = Distributor(
//                         id:  Constants.selectedDistributor.id
//                     );
//              //   Get.find<DistributorController>().addDistributorlet(distributor);
//                     var conn = await Utilities.isInternetWorking();
//                     if(conn){
//                      registerdistributor(distributor);
//                      print(distributor );
//              //    _displayDialog(context);
//                       // if(response.success){
//                       //   distributor.synced = true;
//                       // }
//                     }
//              //    //Get.back();
//             // _displayDialog(context);
//                     //Constants.selectedDistributor.id
//                     print(Constants.selectedDistributor.id);
//               },
//               selected: index == _selectedIndex.value,
//                       title: Row(
//                         children: [
//                       Text(
//                         distList[index].name,
//                       ),
//
//                     ],
//               ),
//             ),
//                   ),
//                 ),
//           );
//         },
//       );
//     }
//
//     Widget distributorList() {
//       return Expanded(
//         child: GetBuilder<DistributorController>(
//           init: DistributorController(),
//           builder: (distributorController) {
//             return distributorController.searchedDistributorList.isNotEmpty
//                 ? listSegment(distributorController.searchedDistributorList)
//                 : distributorController.distributorList != null
//                     ? distributorController.distributorList.isEmpty
//                         ? Center(child: Text("No Distributors"))
//                         : listSegment(distributorController.distributorList)
//                     : Center(
//                         child: CircularProgressIndicator(),
//                       );
//           },
//         ),
//       );
//     }
//
//
//
//     Future<bool> willPopAction() async {
//       if (selectedDistributor.value.name != null && selectedroute.value.route != null) {
//         return true;
//       } else {
//         Utilities.showInToast("You have not selected a distributor",
//             toastType: ToastType.ERROR);
//         return false;
//       }
//     }
//
//
//
//     TextEditingController _distributedController ;
//     TextEditingController _routecontroller;
//
//     return WillPopScope(
//       onWillPop: willPopAction,
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text("Route"),
//           actions: [
//             // TextButton(
//             //   onPressed: () {
//             //     if (Constants.selectedDistributor != null &&
//             //         selectedDistributor.value.name != null) {
//             //       print(Constants.selectedDistributor);
//             //       Get.find<PreferenceController>().setDistributor(
//             //           jsonEncode(Constants.selectedDistributor));
//             //       Get.back();
//             //     } else {
//             //       Utilities.showInToast("Please select a distributor",
//             //           toastType: ToastType.ERROR);
//             //     }
//             //   },
//             //   child: Text(
//             //     "Save",
//             //     style: TextStyle(color: Colors.white),
//             //   ),
//             // )
//           ],
//         ),
//         body: Stack(
//           children: [
//             Container(
//               color: Color(( Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.15),
//               child: Padding(
//                 padding: const EdgeInsets.all(15.0),
//                 child:Center (
//                   child:  Column(
//                     children: [
//                       GestureDetector(
//                         child: TextField(
//                           controller: _distributedController,
//                           decoration: InputDecoration(
//                             border: OutlineInputBorder(
//                               borderSide: BorderSide(
//                                 color: Colors.red, //this has no effect
//                               ),
//                               borderRadius: BorderRadius.circular(10.0),
//                             ),
//                             hintText: "Search Distributor...",
//                           ),
//                           onChanged: (text) {
//                             Get.find<DistributorController>().searchDistributor(text);
//                             // Get.find<Distributor_Route_Controller>().addDistributorlet(distributorList());
//                           },
//                         ),
//                         onTap: (){
//                         },
//                       ),
//                       distributorList(),
//
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//
//             SlidingUpPanel(
//                // color: Color(( Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.05),
//              backdropColor:   Color(( Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1),
//               borderRadius: BorderRadius.vertical(
//                 top: Radius.circular(25)
//               ),
//               panel: Padding(
//                 padding: EdgeInsets.all(15),
//                 child: Center(
//                   child: Column(
//                     children: [
//                       GestureDetector(
//                         child: TextField(
//                           controller: _routecontroller,
//                           decoration: InputDecoration(
//                             border: OutlineInputBorder(
//                               borderSide: BorderSide(
//                                 color: Colors.red, //this has no effect
//                               ),
//                               borderRadius: BorderRadius.circular(10.0),
//                             ),
//                             hintText: "Search Route...",
//                           ),
//                           onChanged: (text) {
//                             Get.find<OutletsController>().searchroute(text);
//                             // Get.find<Distributor_Route_Controller>().addDistributorlet(distributorList());
//                           },
//                         ),
//                         onTap: (){
//                         },
//                       ),
//
//                       routelist()
//                     ],
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//
// }


import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:mobitrack_dv_flutter/controller/distributor_route_controller.dart';
import 'package:mobitrack_dv_flutter/view/dashboard.dart';
import 'package:mobitrack_dv_flutter/view/home.dart';
import 'package:mobitrack_dv_flutter/view/outlets/view_outlets.dart';
import 'package:mobitrack_dv_flutter/view/widgets/dashboardmain.dart';
import 'package:mobitrack_dv_flutter/view/widgets/route.dart';
import 'package:workmanager/workmanager.dart';

import '../controller/location_controller.dart';
import '../controller/outlets_controller.dart';
import '../controller/preference_controller.dart';
import '../controller/routes_controller.dart';
import '../main.dart';
import '../model/check_in_out.dart';
import '../model/routes.dart';
import '../utils/constants.dart';
import '../utils/utilities.dart';

class View_route extends StatefulWidget{

  @override
  State<View_route> createState() => _View_routeState();
}

class _View_routeState extends State<View_route> {
  //final Outlet outlet;
  var _selectedIndex = 0.obs;

  LocationPermission permission;

  var selectedRoute = Routees();

  var outlets = Get.lazyPut(() => OutletsController());

  bool serviceEnabled;

  String checkInId = "";

  Timer countdown;

  Duration myDuration = Duration(days: 5);

  //List<Routees> list = [];
  @override
  Widget build(BuildContext context) {

    workManagerInitialization() {
      // background register
      Workmanager().initialize(
        callbackDispatcher,
      );

      Workmanager().registerPeriodicTask(
        "1",
        fetchBackground,
        frequency: Duration(minutes: 15),
      );
    }
    void setcount(){
      final reduceSceond = 1;

        final second = myDuration.inSeconds - reduceSceond;
        if(second < 0 ){
          countdown.cancel();
        }else{
          myDuration = Duration(seconds: second);
        }

    }
    void start(){
      countdown = Timer.periodic(Duration(seconds: 1), (_)=> setcount());
    }
    press() async{
      var location = Get.find<LocationController>();
    //  workManagerInitialization();
      var conn = await Utilities.isInternetWorking();
      if (conn) {
        // Test if location services are enabled.
        // serviceEnabled =
        // await Geolocator.isLocationServiceEnabled();
        // if (!serviceEnabled) {
        //   return Utilities.showInToast(
        //       'Location services are disabled.',
        //       toastType: ToastType.ERROR);
        // }
        // check for permission
        // permission = await Geolocator.checkPermission();
        // if (permission == LocationPermission.denied ||
        //     permission ==
        //         LocationPermission.deniedForever) {
        //   Utilities.showInToast(
        //       "Location permission is denied, Please enable permission for future use",
        //       toastType: ToastType.ERROR);
        //   // request permission
        //   permission = await Geolocator.requestPermission();
        //   if (permission == LocationPermission.denied ||
        //       permission ==
        //           LocationPermission.deniedForever) {
            // Permissions are denied,
        //     return Utilities.showInToast(
        //         "Location permission is denied, Please enable permission for future use",
        //         toastType: ToastType.ERROR);
        //   }
        // }

        await Get.find<LocationController>()
            .getCurrentPosition();
        if (location.userPosition != null) {
          var resp = await checkInAPI(
              location.userPosition.latitude.toString(),
              location.userPosition.longitude.toString());
          if (resp.success) {
          //  location.startLocationService();
            Get.find<PreferenceController>()
                .setCheckInValue(true,
                checkInId: resp.response.toString());
            Constants.checkInOut = resp.response.toString();
            checkInId = resp.response.toString();
            print(location.userPosition.latitude.toString());
            print(location.userPosition.longitude.toString());
           Get.to(() => DashBoard());

          } else {
            Utilities.showInToast(resp.message,
                toastType: ToastType.ERROR);
          }
        } else {
          Utilities.showInToast(
              "Could not get your location",
              toastType: ToastType.ERROR);
        }
      } else {
        Utilities.showInToast(
            'Please connect to the internet to check in!',
            toastType: ToastType.ERROR);
      }
    }
    Widget listSegment(List<Routees> routeList) {
      return ListView.builder(
        itemCount: routeList.length,
        itemBuilder: (context, index) {
          return Obx(
                () => ListTile(
              onTap: () {
                //start();
                Constants.selectedRoute = routeList[index]  ;
                print(Constants.selectedRoute.id);
                print(routeList[index].id);
                selectedRoute = routeList[index];
                _selectedIndex.value = index;
                Get.find<OutletsController>().fetchOutlets();
                print(Constants.selectedDistributor);
                Constants.selectmyRoute = routeList[index].routename  ;
                setState(() {
                  press();
                });

                Get.find<PreferenceController>()
                    .setDistributor(jsonEncode(Constants.selectedDistributor));
                Utilities.showInToast(
                    "Route : ${selectedRoute.routename}");

                Get.to(() => DashBoard( )) ;
                //Get.off(HomePage());
              },
              selected: index == _selectedIndex.value,
              title:    Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                //   shape: BeveledRectangleBorder(
                //   borderRadius: BorderRadius.circular(5.0),
                // ),
                // shape: StadiumBorder(
                //     side: BorderSide(
                //       color: Colors.black,
                //       width: 1.5,
                //       borderRadius: BorderRadius.circular(10.0),
                //     ),),

                // outlet[index].selected ? Colors.grey
                elevation: 7.0,

                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment:  MainAxisAlignment.end,
                          children: [
                            // SizedBox(
                            //   width: Get.size.width * 0.3,
                            // ),
                            // CircleAvatar(
                            //     radius: (20),
                            //     backgroundColor:  outlet[index].synced
                            //         ? Colors.blueGrey
                            //         : Colors.grey,
                            //     child:  IconButton(onPressed:(){
                            //      // showQuantityBottomSheet(outlet[index].id.toString());
                            //        Get.bottomSheet(
                            //         Container(
                            //             child: Padding(
                            //               padding: const EdgeInsets.all(10.0),
                            //               child: Column(
                            //                 mainAxisSize: MainAxisSize.min,
                            //                 children: [
                            //
                            //                   Padding(
                            //                     padding: const EdgeInsets.all(10.0),
                            //                     child: GetBuilder<OutletsController>(
                            //                       builder: (builder) {
                            //                         return Get.find<OutletsController>().item.length == null
                            //                             ? SizedBox()
                            //                             : InputDecorator(
                            //                           decoration: decoration("Select Remark"),
                            //                           child: ButtonTheme(
                            //                             alignedDropdown: true,
                            //                             child: DropdownButton<String>(
                            //                               // iconEnabledCo
                            //                               // iconDisabledColor: Colors.red,
                            //                               isDense: true,
                            //                               isExpanded: true,
                            //                               hint: Text(
                            //                                   Get.find<OutletsController>().selectedDrowpdown),
                            //                               items:
                            //                               Get.find<OutletsController>().item.map((e) {
                            //                                 return DropdownMenuItem<String>(
                            //                                     value: e, child: Text(e));
                            //                               }).toList(),
                            //                               onChanged: (String district) {
                            //                                 // setState(() {
                            //                                 Get.find<OutletsController>().selectedDrowpdown = district;
                            //                                 //  Get.find<OutletsController>().setitem(district );
                            //                                 // });
                            //
                            //                                 // district = selectedDrowpdown;
                            //                                 print(Get.find<OutletsController>().selectedDrowpdown);
                            //                                 print(district);
                            //                                 //   print(Get.find<OutletsController>().setitem(district ));
                            //                                 //   district = Constants.item;
                            //                                 //      print(selectedDrowpdown);
                            //                                 //   district = Constants.selectedzone.zone;
                            //                                 // Get.find<AddressController>().getAreaList(district);
                            //                               },
                            //                             ),
                            //                           ),
                            //                         );
                            //                       },
                            //                     ),
                            //                   ),
                            //                   // ElevatedButton(
                            //                   //   onPressed: () async {
                            //                   //     if ( Get.find<OutletsController>().selectedDrowpdown != null  ) {
                            //                   //       // selectedProductList.add({
                            //                   //       //
                            //                   //       //   "remarks":  Get.find<OutletsController>().selectedDrowpdown,
                            //                   //       //
                            //                   //       // });
                            //                   //       //
                            //                   //       // if (selectedProductList.isEmpty) {
                            //                   //       //   Utilities.showInToast("Please add a product",
                            //                   //       //       toastType: ToastType.ERROR);
                            //                   //       //   return;
                            //                   //       // }
                            //                   //
                            //                   //       var sales = Sales(
                            //                   //         orders: '[{ "product_id" :"2", "batch_id": "3", "quantity" : "30", "discount": "10"}]',
                            //                   //         remark: jsonEncode(selectedProductList),
                            //                   //         soldAt:  DateTime.now().toString(),
                            //                   //         outletId: "12",
                            //                   //            outletLatitude : "444444",
                            //                   //        outletLongitude : "4343243423"
                            //                   //       );
                            //                   //       // sales.orders = "dd";
                            //                   //       // // sales.distributorId = "12";
                            //                   //       // sales.remark =jsonEncode(selectedProductList);
                            //                   //       // sales.soldAt = DateTime.now().toString();
                            //                   //       // sales.outletId = Get
                            //                   //       //     .find<OutletsController>()
                            //                   //       //     .outletList[index].id.toString();
                            //                   //       // sales.outletLatitude = "444444";
                            //                   //       // sales.outletLongitude = "4343243423";
                            //                   //
                            //                   //       //  var conn = await Utilities.isInternetWorking();
                            //                   //
                            //                   //
                            //                   //
                            //                   //       Get.find<OutletsController>().addoutletInList(outlet[index].id.toString()) ;
                            //                   //       //else {
                            //                   //       //   Get.find<ProductsController>().storeSalesOffline(sales);
                            //                   //       // }
                            //                   //       //
                            //                   //       // Get.find<ProductsController>().removeAllProductFromList();
                            //                   //   //    Get.find<ProductsController>().sellProducts(sales);
                            //                   //           var conn = await Utilities.isInternetWorking();
                            //                   //       if (conn) {
                            //                   //         var response = await sellProductApi(sales);
                            //                   //         print(sales);
                            //                   //         // Get.back();
                            //                   //         Utilities.showInToast(response.message,
                            //                   //             toastType: response.success
                            //                   //                 ? ToastType.SUCCESS
                            //                   //                 : ToastType.ERROR);
                            //                   //
                            //                   //         //   if (response.success) {
                            //                   //         //     outlet.synced = true;
                            //                   //         //     Get.back();
                            //                   //         //   }
                            //                   //         // } else {
                            //                   //         //   Get.back();
                            //                   //         //   outlet.synced = false;
                            //                   //         //
                            //                   //         //   Utilities.showInToast('Storing Offline',
                            //                   //         //       toastType: ToastType.INFO);
                            //                   //         // }
                            //                   //         // await DatabaseHelper.instance
                            //                   //         //     .insertOutlet(outlet);
                            //                   //         // Get.find<ProductsController>().addremark(sales);
                            //                   //         Get.back();
                            //                   //       } else {
                            //                   //         Utilities.showInToast('Please complete the form',
                            //                   //             toastType: ToastType.ERROR);
                            //                   //       }
                            //                   //     } else {
                            //                   //       Utilities.showInToast("Please add quantity");
                            //                   //     }
                            //                   //     Get.back(
                            //                   //
                            //                   //     );
                            //                   //   },
                            //                   //   child: Text("Add"),
                            //                   // )
                            //                 ],
                            //               ),
                            //             )),
                            //         shape: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                            //         backgroundColor: Colors.white,
                            //         enableDrag: true,
                            //       );
                            //       // Get.bottomSheet(
                            //       //   // ListView.builder(itemCount: Get.find<OutletsController>().item?.length != null ? Get.find<OutletsController>().item?.length  : "",
                            //       //   //   itemBuilder: (context, index){
                            //       //   //     return
                            //       //   Container(
                            //       //       child: Padding(
                            //       //         padding: const EdgeInsets.all(10.0),
                            //       //         child: Column(
                            //       //           mainAxisSize: MainAxisSize.min,
                            //       //           children: [
                            //       //             Padding(
                            //       //                 padding: const EdgeInsets.all(12.0),
                            //       //                 child:
                            //       //                 // DropdownButton(
                            //       //                 //
                            //       //                 //   // Initial Value
                            //       //                 //     value: selectedDrowpdown,
                            //       //                 //
                            //       //                 //     // Down Arrow Icon
                            //       //                 //     icon: const Icon(Icons.keyboard_arrow_down),
                            //       //                 //
                            //       //                 //     // Array list of items
                            //       //                 //     items: item.map((String items) {
                            //       //                 //       return DropdownMenuItem(
                            //       //                 //         value: items,
                            //       //                 //         child: Text(items),
                            //       //                 //       );
                            //       //                 //     }).toList(),
                            //       //                 // After selecting the desired option,it will
                            //       //                 // change button value to selected value
                            //       //                 // onChanged: (String newValue) {
                            //       //                 //   setState(() {
                            //       //                 //     selectedDrowpdown = newValue;
                            //       //                 //   });
                            //       //                 //                 DropdownButton(
                            //       //                 //                 hint: Text("Outlet Closed Image"), // Not necessary for Option 1
                            //       //                 //   value:selectedDrowpdown,
                            //       //                 //   onChanged: (newValue) {
                            //       //                 //     selectedDrowpdown = newValue;
                            //       //                 //   setState(() {
                            //       //                 //   selectedDrowpdown = newValue;
                            //       //                 // //  print(newValue);
                            //       //                 //   //print(selectedDrowpdown);
                            //       //                 //   });
                            //       //                 //   },
                            //       //                 //   items: item.map((location) {
                            //       //                 //   return DropdownMenuItem(
                            //       //                 //   child: new Text(location),
                            //       //                 //   value: location,
                            //       //                 //   );
                            //       //                 //   }).toList(),
                            //       //                 //   ),
                            //       //                 Padding(
                            //       //                   padding: const EdgeInsets.all(10.0),
                            //       //                   child: GetBuilder<OutletsController>(
                            //       //                     builder: (builder) {
                            //       //                       return Get.find<OutletsController>().item.length == null
                            //       //                           ? SizedBox()
                            //       //                           : InputDecorator(
                            //       //                         decoration: decoration("Select Remark"),
                            //       //                         child: ButtonTheme(
                            //       //                           alignedDropdown: true,
                            //       //                           child: DropdownButton<String>(
                            //       //                             // iconEnabledCo
                            //       //                             // iconDisabledColor: Colors.red,
                            //       //                             isDense: true,
                            //       //                             isExpanded: true,
                            //       //                             hint: Text(
                            //       //                                 Get.find<OutletsController>().selectedDrowpdown),
                            //       //                             items:
                            //       //                             Get.find<OutletsController>().item.map((e) {
                            //       //                               return DropdownMenuItem<String>(
                            //       //                                   value: e, child: Text(e));
                            //       //                             }).toList(),
                            //       //                             onChanged: (String district) {
                            //       //                               // setState(() {
                            //       //                                 Get.find<OutletsController>().selectedDrowpdown = district;
                            //       //                                 //  Get.find<OutletsController>().setitem(district );
                            //       //                              // });
                            //       //
                            //       //                               // district = selectedDrowpdown;
                            //       //                               print(Get.find<OutletsController>().selectedDrowpdown);
                            //       //                               print(district);
                            //       //                               //   print(Get.find<OutletsController>().setitem(district ));
                            //       //                               //   district = Constants.item;
                            //       //                               //      print(selectedDrowpdown);
                            //       //                               //   district = Constants.selectedzone.zone;
                            //       //                               // Get.find<AddressController>().getAreaList(district);
                            //       //                             },
                            //       //                           ),
                            //       //                         ),
                            //       //                       );
                            //       //                     },
                            //       //                   ),
                            //       //                 )
                            //       //               // DropdownButton<String>(
                            //       //               //   hint: Text("Remark"),
                            //       //               //   value:  selectedDrowpdown,
                            //       //               //   items:
                            //       //               //   //[for(var data in  Get.find<OutletsController>().item)])
                            //       //               //   // [
                            //       //               //   //   for (var data in Get.find<OutletsController>().item)
                            //       //               //   //     DropdownMenuItem(
                            //       //               //   //       child: new Text(
                            //       //               //   //         data,
                            //       //               //   //       ),
                            //       //               //   //       value: data,
                            //       //               //   //     )
                            //       //               //   // ],
                            //       //               //
                            //       //               //   // Get.find<OutletsController>().item.map((e) {
                            //       //               //   //   return DropdownMenuItem<String>(
                            //       //               //   //           value: e,
                            //       //               //   //           child: Text(e),
                            //       //               //   //         );
                            //       //               //   // }),
                            //       //               //     item.map((  value) {
                            //       //               //     return DropdownMenuItem<String>(
                            //       //               //       value: value,
                            //       //               //       child: Text(value),
                            //       //               //     );
                            //       //               //   }).toList(),
                            //       //               //   onChanged: (newvalue) {
                            //       //               //     setState(() {
                            //       //               //      selectedDrowpdown = newvalue ;
                            //       //               //     });
                            //       //               //
                            //       //               // //   Get.find<OutletsController>().setitem(newvalue);
                            //       //               //
                            //       //               //
                            //       //               //    //_selectedvalue = newvalue;
                            //       //               //   })
                            //       //             ),
                            //       //
                            //       //             SizedBox(height: Get.size.height * 0.01),
                            //       //             // Container(
                            //       //             //   child: _imageFile == null
                            //       //             //       ? Center(
                            //       //             //     child: Text("No Image Selected"),
                            //       //             //   )
                            //       //             //       : Image.file(File(_imageFile.path)),
                            //       //             // ),
                            //       //             ElevatedButton(
                            //       //               onPressed: () async {
                            //       //                 // pickImage();
                            //       //                 if (Get.find<OutletsController>().selectedDrowpdown.isNotEmpty) {
                            //       //                   var conn = await Utilities.isInternetWorking();
                            //       //                   showDialog(
                            //       //                       barrierDismissible: false,
                            //       //                       context: context,
                            //       //                       builder: (context) {
                            //       //                         return CupertinoAlertDialog(
                            //       //                           title: Text('Please Wait'),
                            //       //                           content: Column(
                            //       //                             children: [
                            //       //                               Divider(),
                            //       //                               Padding(
                            //       //                                 padding: const EdgeInsets.all(8.0),
                            //       //                                 child: Text(conn
                            //       //                                     ? 'Registering new Sales Outlet'
                            //       //                                     : 'Saving offline'),
                            //       //                               ),
                            //       //                               CupertinoActivityIndicator(
                            //       //                                 radius: 17,
                            //       //                               )
                            //       //                             ],
                            //       //                           ),
                            //       //                         );
                            //       //                       });
                            //       //                   // var sales = Sales(
                            //       //                   //     outletId:  outlet[index].id.toString(),
                            //       //                   //     remark:  Get.find<OutletsController>().selectedDrowpdown
                            //       //                   // );
                            //       //                   // selectedoutlet.add({
                            //       //                   //   //"outlet_id": outletId,
                            //       //                   //
                            //       //                   //   "remark": selectedDrowpdown,
                            //       //                   //
                            //       //                   // });
                            //       //                   if (conn) {
                            //       //                     var response = await sellProductApi(sales);
                            //       //                     print(sales);
                            //       //                     // Get.back();
                            //       //                     Utilities.showInToast(response.message,
                            //       //                         toastType: response.success
                            //       //                             ? ToastType.SUCCESS
                            //       //                             : ToastType.ERROR);
                            //       //
                            //       //                     //   if (response.success) {
                            //       //                     //     outlet.synced = true;
                            //       //                     //     Get.back();
                            //       //                     //   }
                            //       //                     // } else {
                            //       //                     //   Get.back();
                            //       //                     //   outlet.synced = false;
                            //       //                     //
                            //       //                     //   Utilities.showInToast('Storing Offline',
                            //       //                     //       toastType: ToastType.INFO);
                            //       //                     // }
                            //       //                     // await DatabaseHelper.instance
                            //       //                     //     .insertOutlet(outlet);
                            //       //                     // Get.find<ProductsController>().addremark(sales);
                            //       //                     Get.back();
                            //       //                   } else {
                            //       //                     Utilities.showInToast('Please complete the form',
                            //       //                         toastType: ToastType.ERROR);
                            //       //                   }
                            //       //                   // if (selectedDrowpdown != null) {
                            //       //                   //   // selectedoutlet.add({
                            //       //                   //   //   //"outlet_id": outletId,
                            //       //                   //   //
                            //       //                   //   //   "remark": selectedDrowpdown,
                            //       //                   //   //
                            //       //                   //   // });
                            //       //                   //   sales.remark = jsonEncode(selectedoutlet);
                            //       //                   //   Get.find<OutletsController>().addoutletInList(outletId);
                            //       //                   //   //Get.find<ProductsController>().addremark(selectedoutlet);
                            //       //                   //   Utilities.showInToast("Remark Noted");
                            //       //                   //   print(selectedDrowpdown);
                            //       //                   // } else {
                            //       //                   //   Utilities.showInToast("Please add Remark");
                            //       //                   // }
                            //       //                   Get.back();}
                            //       //               },
                            //       //               child: Text("Add"),
                            //       //             ),
                            //       //           //  outlet.id..toString().isEmpty
                            //       //           //       ? ElevatedButton(
                            //       //           //     onPressed: () {
                            //       //           //       showQuantityBottomSheet(null, products.id.toString());
                            //       //           //     },
                            //       //           //     child: Text("Sell"),
                            //       //           //   )
                            //       //           //       : ExpansionTile(
                            //       //           //     title: Text("Batches"),
                            //       //           //     children: products.batches.map((batch) {
                            //       //           //       return buildBatchTile(batch, products);
                            //       //           //     }).toList(),
                            //       //           //   ),
                            //       //           ],
                            //       //         ),)),
                            //       //
                            //       //
                            //       //
                            //       //
                            //       //   shape: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                            //       //   backgroundColor: Colors.white,
                            //       //   enableDrag: true,
                            //       // );
                            //     } , icon: Icon(Icons.add))
                            // )
                          ],
                        ),
                        Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      routeList[index].routename,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text("  Outlets: ${Constants}",style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal),)
                                  ],
                                )
                                // Padding(
                                //   padding: const EdgeInsets.only(top: 1),
                                //   child:

                                //    ),
                                // Container(
                                //   child:   Text(
                                //     "Number of Outlet: ${outlet.length.toString()}",
                                //     style: TextStyle(
                                //         fontSize: 10,
                                //         fontWeight: FontWeight.bold),
                                //   ),
                                // ),
                                // Text(
                                //   outlet[index].name,
                                //   style: TextStyle(
                                //       fontSize: 10,
                                //       fontWeight: FontWeight.bold),
                                // ),

                              ],
                            )
                        ),


                      ],
                    ),
                  ),
                ),
              )
              // Text(
              //   routeList[index].routename,
              // ),
          );
        },
      );
    }
    Widget routeList() {
      return Expanded(
        child: GetBuilder<Routecontroller>(
          init: Routecontroller(),
          builder: (routeController) {
            return routeController.searchedroutelist.isNotEmpty
                ? listSegment(routeController.searchedroutelist)
                : routeController.routeList != null
                ? routeController.routeList.isEmpty
                ? Center(child: CupertinoActivityIndicator())
               //  : routeController.routeList ==null ?Center(child: Text("No Route Assign Please contact your Distributor"),)
                : listSegment(routeController.routeList)
                : Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      );
    }

    Future<bool> willPopAction() async {
      if (selectedRoute != null) {
        return true;
      } else {
        Utilities.showInToast("You have not selected a Routes",
            toastType: ToastType.ERROR);
        return false;
      }
    }
    return WillPopScope(
      onWillPop: willPopAction,
      child: Scaffold(
        appBar: AppBar(

          backgroundColor: Colors.white,
          title: Text("Routes",style: TextStyle(color: Colors.black),),
          actions: [
            // TextButton(
            //   onPressed: () {
            //     if (Constants.selectedDistributor != null &&
            //         selectedDistributor.value.name != null) {
            //       print(Constants.selectedDistributor);
            //       Get.find<PreferenceController>().setDistributor(
            //           jsonEncode(Constants.selectedDistributor));
            //       Get.back();
            //     } else {
            //       Utilities.showInToast("Please select a distributor",
            //           toastType: ToastType.ERROR);
            //     }
            //   },
            //   child: Text(
            //     "Save",
            //     style: TextStyle(color: Colors.white),
            //   ),
            // )
          ],
        ),
        body: Container(
          color: Colors.black.withOpacity(0.1),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red, //this has no effect
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: "Search Routes...",
                  ),
                  onChanged: (text) {
                    Get.find<Routecontroller>().searchDistributor(text);
                  },
                ),

                routeList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


