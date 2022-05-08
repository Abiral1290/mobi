import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_carousel_slider/carousel_slider_indicators.dart';
import 'package:flutter_carousel_slider/carousel_slider_transforms.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hawk_fab_menu/hawk_fab_menu.dart';
import 'package:mobitrack_dv_flutter/view/attendance/show_attendance.dart';
import 'package:mobitrack_dv_flutter/view/drawer.dart';

import 'package:mobitrack_dv_flutter/view/outlets/remarks.dart';
import 'package:mobitrack_dv_flutter/view/outlets/view_outlets.dart';
import 'package:mobitrack_dv_flutter/view/view_distributor.dart';
import 'package:mobitrack_dv_flutter/view/widgets/dashboardmain.dart';
import 'package:mobitrack_dv_flutter/view/widgets/scoreboard.dart';
import 'package:path_provider/path_provider.dart';
import 'package:perspective_pageview/perspective_pageview.dart';
import 'package:workmanager/workmanager.dart';

import '../controller/auth_controller.dart';
import '../controller/location_controller.dart';
import '../controller/outlets_controller.dart';
import '../controller/preference_controller.dart';
import '../main.dart';
import '../model/app_version.dart';
import '../model/check_in_out.dart';
import '../model/distributor.dart';
import '../model/location_model.dart';
import '../utils/constants.dart';
import '../utils/downloader.dart';
import '../utils/utilities.dart';
import 'credentials/checkauth.dart';
import 'location_status.dart';

class DashBoard extends StatefulWidget{

  //Duration myDuration = Duration(days: 5);

  //DashBoard({Key key, this.myDuration}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DashBoard();
  }
}
class _DashBoard extends State<DashBoard>{



  TabController tebController;
  int _selectedIndex = 0;
    VoidCallback next;

  LocationPermission permission;
  bool serviceEnabled;
  bool hasLocationPermission = false;
  String checkInId = "";
  Timer countdown;
  Duration myDuration = Duration(days: 5);



  var locationController = Get.find<LocationController>();
  var outletController = Get.lazyPut(()=>OutletsController());
   //final _controller = PageController();
  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   tebController.dispose();
  //   super.dispose();
  //
  // }
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   tebController = TabController(  );
  // }

  pushLocationData() async {
    for (var list in locationController.locationList) {
      LocationModel model = LocationModel(
        id: list.id.toString(),
        latitude: list.latitude.toString(),
        longitude: list.longitude.toString(),
        date: list.date.toString(),
        checkinoutId: list.checkinoutId.toString(),
        outletId: list.outletId,
      );

      locationController.postLocation(
          model, list.outletId == null ? false : true);

      Get.find<LocationController>().deleteLocation(list);
    }
  }

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

  void start(){
    countdown = Timer.periodic(Duration(seconds: 1), (_)=> setcount());
  }

  void setcount(){
    final reduceSceond = 1;
    setState(() {
      final second =  myDuration.inSeconds - reduceSceond;
      if(second < 0 ){
        countdown.cancel();
      }else{
       myDuration = Duration(seconds: second);
      }
    });
  }

  @override
  void initState() {
    start();
    // Get.find<ProductsController>();
    //  Get.find<AddressController>();
    //  Get.find<BankController>();
    //  Get.find<CollectionController>();

    Get.find<PreferenceController>().getCheckInValue().then((value) {
      if (value.split("//").last == "true") {
        Constants.checkInOut = value.split("//")[1];
        Get.find<LocationController>().startLocationService();
        checkInId = value.split("//")[1];
      }
    });

    Get.find<PreferenceController>().getDistributor().then((value) {
      if (value.isEmpty) {
        Get.to(() => View_route());
      } else {
        Constants.selectedDistributor = Distributor.fromJson(jsonDecode(value));
        print(Constants.selectedDistributor);
      }
    });

    Future.delayed(Duration(seconds: 6), () {
      Get.find<OutletsController>();
    });

    // Timer.periodic(Duration(hours: 1), (timer) {
    //   pushLocationData();
    // });

    pushLocationData();

    //initFunction();
    super.initState();
  }
  initFunction() async {
    var tempPath = await getTemporaryDirectory();
    var downloadPath = tempPath.path + '/' + Constants.tempApkName;

    //delete previous apk if exists
    var apk = File(downloadPath);
    if (apk.existsSync()) {
      apk.delete();
    }

    var conn = await Utilities.isInternetWorking();
    var auth = Get.find<AuthController>().isLoggedIn;
    if (conn && auth) {
      var resp = await checkForUpdate();
      if (resp.success) {
        print(resp.response.versionId)  ;
        print(Constants.appVerId);
        if (resp.response.versionId > Constants.appVerId) {
          print(resp.response.url);
          downloadApk(resp.response.url, downloadPath, context);
          // Constants.storage = resp.response.versionId;
          //  resp.response.versionId = id;
        } else {
          Future.delayed(
              Duration(seconds: 2), () => Get.off(() => CheckAuthPage()));
        }
      } else {
        Utilities.showInToast('Failed to check for update.\n' + resp.message);
        Future.delayed(
            Duration(seconds: 2), () => Get.off(() => CheckAuthPage()));
      }
    } else {
      Future.delayed(
          Duration(seconds: 2), () => Get.off(() => CheckAuthPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final days = strDigits( myDuration.inDays);
    final hours = strDigits( myDuration.inHours.remainder(6));
    final minutes = strDigits( myDuration.inMinutes.remainder(60));
    final seconds = strDigits( myDuration.inSeconds.remainder(60));
   return DefaultTabController(
     length: 3,
     child: Scaffold(
       drawer: DrawerPage(),
        appBar:  AppBar(
          backgroundColor: Colors.black,
          title:  Text("DashBoard"),
            actions: [

              TextButton(
                onPressed: () {
                  Get.to(() => AttendancePage());
                },
                child: Text("Attendance", style: TextStyle(color: Colors.white)),
              ),
              IconButton(
                onPressed:
                    () {setState(() {
                  //  Platform.isAndroid ?    initFunction() : Get.to(() => DashBoardMain());
                  if (Platform.isAndroid) {
                    initFunction();
                  } else {
                    Text("Your Application is Updated");
                    // Get.to(() => DashBoardMain());
                    // Future.delayed(
                    //     Duration(seconds: 2), () => Get.off(() => CheckAuthPage()));
                  }
                });
                  //   Get.to(() => LocationStatusPage());
                },
                icon: Icon(Icons.update),
              ),
    //           TextButton(
    //             onPressed: () {
    //               setState(() {
    //               //  Platform.isAndroid ?    initFunction() : Get.to(() => DashBoardMain());
    // if (Platform.isAndroid) {
    //         initFunction();
    //       } else {
    //   Text("Your Application is Updated");
    //  // Get.to(() => DashBoardMain());
    //         // Future.delayed(
    //         //     Duration(seconds: 2), () => Get.off(() => CheckAuthPage()));
    //       }
    //               });
    //            //   Get.to(() => LocationStatusPage());
    //             },
    //             child: IconButton(
    //               onPressed: ,
    //               icon: Icon(Icons.update),
    //             ),
    //           ),
              TextButton(
                onPressed: () {
                  Get.to(() => LocationStatusPage());
                },
                child: Text("Status", style: TextStyle(color: Colors.white)),
              ),

            ],
          bottom: TabBar(
            controller: tebController,
            tabs:[
              Tab(icon: Text("Dashboard"),),
              Tab(icon: Text("Route")),
              Tab(icon: Text("ScoreBoard")),
            ]
          )
        ),
       body: GetBuilder<PreferenceController>(
         builder: (preferenceController) {
          // print("Checked in home: ${preferenceController.isCheckedIn}");
           // var user = Get.find<AuthController>();
           var location = Get.find<LocationController>();
         //  print(preferenceController.isCheckedIn ? 'is check' : ' not check');
           return HawkFabMenu(
             icon: AnimatedIcons.arrow_menu,
             fabColor: Get.find<PreferenceController>().isCheckedIn ?
                  Colors.black
                 : Colors.white,
               //  : Colors.red[900],
             iconColor: Colors.white,
             items: [
               // preferenceController.isCheckedIn
               //     ? HawkFabMenuItem(
               //   label: 'Check In',
               //   ontap: () async {
               //     workManagerInitialization();
               //     var conn = await Utilities.isInternetWorking();
               //     if (conn) {
               //       // Test if location services are enabled.
               //       serviceEnabled =
               //       await Geolocator.isLocationServiceEnabled();
               //       if (!serviceEnabled) {
               //         return Utilities.showInToast(
               //             'Location services are disabled.',
               //             toastType: ToastType.ERROR);
               //       }
               //       // check for permission
               //       permission = await Geolocator.checkPermission();
               //       if (permission == LocationPermission.denied ||
               //           permission ==
               //               LocationPermission.deniedForever) {
               //         Utilities.showInToast(
               //             "Location permission is denied, Please enable permission for future use",
               //             toastType: ToastType.ERROR);
               //         // request permission
               //         permission = await Geolocator.requestPermission();
               //         if (permission == LocationPermission.denied ||
               //             permission ==
               //                 LocationPermission.deniedForever) {
               //           // Permissions are denied,
               //           return Utilities.showInToast(
               //               "Location permission is denied, Please enable permission for future use",
               //               toastType: ToastType.ERROR);
               //         }
               //       }
               //
               //       await Get.find<LocationController>()
               //           .getCurrentPosition();
               //       if (location.userPosition != null) {
               //         var resp = await checkInAPI(
               //             location.userPosition.latitude.toString(),
               //             location.userPosition.longitude.toString());
               //         if (resp.success) {
               //           location.startLocationService();
               //           Get.find<PreferenceController>()
               //               .setCheckInValue(true,
               //               checkInId: resp.response.toString());
               //           Constants.checkInOut = resp.response.toString();
               //           checkInId = resp.response.toString();
               //          // Get.to(() => ViewDistributorPage());
               //         } else {
               //           Utilities.showInToast(resp.message,
               //               toastType: ToastType.ERROR);
               //         }
               //       } else {
               //         Utilities.showInToast(
               //             "Could not get your location",
               //             toastType: ToastType.ERROR);
               //       }
               //     } else {
               //       Utilities.showInToast(
               //           'Please connect to the internet to check in!',
               //           toastType: ToastType.ERROR);
               //     }
               //   },
               //   icon: Icon(Icons.login_rounded),
               //   color: Colors.green[900],
               //   labelBackgroundColor: Colors.green[900],
               //   labelColor: Colors.white,
               // )
           //        :
           HawkFabMenuItem(
                   label:
                  '$hours:$minutes:$seconds',
                   ontap: () async {
                     // cancel workmanager
                    // Workmanager().cancelAll();

                     var conn = await Utilities.isInternetWorking();
                     if (conn) {
                       // sync location data

                       // await pushLocationData();
                       //
                       // // Test if location services are enabled.
                       // serviceEnabled =
                       // await Geolocator.isLocationServiceEnabled();
                       // if (!serviceEnabled) {
                       //   return Future.error(
                       //       'Location services are disabled.');
                       // }

                       // check for permission
                       // permission = await Geolocator.checkPermission();
                       // if (permission == LocationPermission.denied ||
                       //     permission ==
                       //         LocationPermission.deniedForever) {
                       //   Utilities.showInToast(
                       //       "Location permission is denied, Please enable permission for future use");
                       //   // request permission
                       //   permission = await Geolocator.requestPermission();
                       //   if (permission == LocationPermission.denied ||
                       //       permission ==
                       //           LocationPermission.deniedForever) {
                       //     // Permissions are denied,
                       //     return Utilities.showInToast(
                       //         "Location permission is denied, Please enable permission for future use");
                       //   }
                       // }
                       await Get.find<LocationController>()
                           .getCurrentPosition();
                       if (location.userPosition != null) {
                         var resp = await checkOutAPI(
                             location.userPosition.latitude.toString(),
                             location.userPosition.longitude.toString(),
                             Constants.checkInOut);
                         if (resp.success) {
                          // location.stopBackgroundLocationService();
                           // Get.find<PreferenceController>()
                           //     .setCheckInValue(true);
                           SystemNavigator.pop();
                         //  Get.to(() => View_route());
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
                           'Please connect to the internet to check out!',
                           toastType: ToastType.ERROR);
                     }
                   },
                 icon: Icon(Icons.list),
                 color: Colors.red[900],
                 labelBackgroundColor: Colors.red[900],
                 labelColor: Colors.white,
               ),
             //  !preferenceController.isCheckedIn
               //     ? HawkFabMenuItem(
               //   label: 'Check In',
               //   ontap: () async {
               //     //start();
               //     workManagerInitialization();
               //
               //     var conn = await Utilities.isInternetWorking();
               //
               //     if (conn) {
               //       // Test if location services are enabled.
               //       serviceEnabled =
               //       await Geolocator.isLocationServiceEnabled();
               //       if (!serviceEnabled) {
               //         return Utilities.showInToast(
               //             'Location services are disabled.',
               //             toastType: ToastType.ERROR);
               //       }
               //       // check for permission
               //       permission = await Geolocator.checkPermission();
               //       if (permission == LocationPermission.denied ||
               //           permission ==
               //               LocationPermission.deniedForever) {
               //         Utilities.showInToast(
               //             "Location permission is denied, Please enable permission for future use",
               //             toastType: ToastType.ERROR);
               //         // request permission
               //         permission = await Geolocator.requestPermission();
               //         if (permission == LocationPermission.denied ||
               //             permission ==
               //                 LocationPermission.deniedForever) {
               //           // Permissions are denied,
               //           return Utilities.showInToast(
               //               "Location permission is denied, Please enable permission for future use",
               //               toastType: ToastType.ERROR);
               //         }
               //       }
               //
               //       await Get.find<LocationController>()
               //           .getCurrentPosition();
               //
               //     } else {
               //       Utilities.showInToast(
               //           'Please connect to the internet to check in!',
               //           toastType: ToastType.ERROR);
               //     }
               //   },
               //   icon: Icon(Icons.login_rounded),
               //   color: Colors.green[900],
               //   labelBackgroundColor: Colors.green[900],
               //   labelColor: Colors.white,
               // )
                  // :
           // HawkFabMenuItem(
           //       label:
           //       '$hours:$minutes:$seconds',
           //       ontap: () async {
           //         // cancel workmanager
           //        // Workmanager().cancelAll();
           //         var conn = await Utilities.isInternetWorking();
           //         if (conn) {
           //           // sync location data
           //           // await pushLocationData();
           //           // // Test if location services are enabled.
           //           // serviceEnabled =
           //           // await Geolocator.isLocationServiceEnabled();
           //           // if (!serviceEnabled) {
           //           //   return Future.error(
           //           //       'Location services are disabled.');
           //           // }
           //           //
           //           // // check for permission
           //           // permission = await Geolocator.checkPermission();
           //           // if (permission == LocationPermission.denied ||
           //           //     permission ==
           //           //         LocationPermission.deniedForever) {
           //           //   Utilities.showInToast(
           //           //       "Location permission is denied, Please enable permission for future use");
           //           //   // request permission
           //           //   permission = await Geolocator.requestPermission();
           //           //   if (permission == LocationPermission.denied ||
           //           //       permission ==
           //           //           LocationPermission.deniedForever) {
           //           //     // Permissions are denied,
           //           //     return Utilities.showInToast(
           //           //         "Location permission is denied, Please enable permission for future use");
           //           //   }
           //           // }
           //           if(Platform.isAndroid){
           //             SystemNavigator.pop();
           //           }else if(Platform.isIOS){
           //             exit(0);
           //           }
           //
           //           await Get.find<LocationController>()
           //               .getCurrentPosition();
           //           if (location.userPosition != null) {
           //             var resp = await checkOutAPI(
           //                 location.userPosition.latitude.toString(),
           //                 location.userPosition.longitude.toString(),
           //                 checkInId);
           //             if (resp.success) {
           //               location.stopBackgroundLocationService();
           //               Get.find<PreferenceController>()
           //                   .setCheckInValue(false);
           //
           //             } else {
           //               Utilities.showInToast(resp.message,
           //                   toastType: ToastType.ERROR);
           //             }
           //           } else {
           //             Utilities.showInToast(
           //                 "Could not get your location",
           //                 toastType: ToastType.ERROR);
           //           }
           //         } else {
           //           Utilities.showInToast(
           //               'Please connect to the internet to check out!',
           //               toastType: ToastType.ERROR);
           //         }
           //       },
           //       icon: Icon(Icons.logout),
           //       color: Colors.red[900],
           //       labelBackgroundColor: Colors.red[900],
           //       labelColor: Colors.white,
           //     ),
             ],

             body:  TabBarView(
               controller: tebController,
                 children: [

                   ScoreBoard(),
               ViewOutletstPage(),
                   DashBoardMain(),
             ])
             // ListView(
             //   children: [
             //     // Container(
             //     //   child: Center(
             //     //     // Adding Child Widget of Perspective PageView
             //     //     child: PerspectivePageView(
             //     //       hasShadow: true, // Enable-Disable Shadow
             //     //       shadowColor: Colors.black12, // Change Color
             //     //       aspectRatio: PVAspectRatio.ONE_ONE, // Aspect Ratio of 1:1 (Default)
             //     //       children: <Widget>[
             //     //         GestureDetector(
             //     //           onTap: () {
             //     //             debugPrint("Statement One");
             //     //           },
             //     //           child: Container(
             //     //             color: Colors.red,
             //     //           ),
             //     //         ),
             //     //         GestureDetector(
             //     //           onTap: () {
             //     //             debugPrint("Statement Two");
             //     //           },
             //     //           child: Container(
             //     //             color: Colors.green,
             //     //           ),
             //     //         )
             //     //       ],
             //     //
             //     //     ),
             //     //   ),
             //     // ),
             //     Container(
             //       width:  500,
             //       height: 500,
             //       child: CarouselSlider.builder(
             //         unlimitedMode: true,
             //         slideBuilder: (index){
             //           return Container(
             //             alignment: Alignment.center,
             //             child: _list,
             //             Text(
             //              _list,
             //                 style: TextStyle(fontSize: 200, color: Colors.white)
             //             ),
             //           );
             //         },
             //           slideTransform: CubeTransform(),
             //           slideIndicator: CircularSlideIndicator(
             //             padding: EdgeInsets.only(bottom: 32),
             //           ),
             //           itemCount: _list.length
             //       ),
             //     )
             //   ],
             // ),
             // body: Stack(
             //   children: [
             //     Center(
             //       child: GetBuilder<LocationController>(
             //         builder: (controller) {
             //           return Column(
             //             mainAxisAlignment: MainAxisAlignment.center,
             //             children: [
             //               Text(
             //                 "You are near:",
             //                 style: TextStyle(
             //                     fontSize: 20, fontWeight: FontWeight.bold),
             //               ),
             //               SizedBox(
             //                 height: Get.size.height * 0.05,
             //               ),
             //               Get.find<PreferenceController>().isCheckedIn
             //                   ? Glow(
             //                       startDelay: Duration(milliseconds: 000),
             //                       glowColor: Colors.blue[500],
             //                       endRadius: 200.0,
             //                       child: InkWell(
             //                         onTap: () {
             //                           if (Get.find<LocationController>()
             //                                       .nearestOutletName !=
             //                                   "To be Determined" &&
             //                               Get.find<LocationController>()
             //                                       .nearestOutlet !=
             //                                   null) {
             //                             Get.to(() => SellProductPage(
             //                                 outlet:
             //                                     Get.find<LocationController>()
             //                                         .nearestOutlet));
             //                           }
             //                         },
             //                         child: Text(
             //                           Get.find<LocationController>()
             //                               .nearestOutletName,
             //                           style: TextStyle(
             //                               fontSize: 20,
             //                               fontWeight: FontWeight.bold),
             //                         ),
             //                       ),
             //                     )
             //                   : Text(
             //                       "To Be Determined",
             //                       style: TextStyle(
             //                           fontSize: 20,
             //                           fontWeight: FontWeight.bold),
             //                     ),
             //             ],
             //           );
             //         },
             //       ),
             //     ),
             //   ],
             // ),
           );
         },
       ),
        // body:
        // TabBarView(
        //   controller: tebController,
        //     children: [
        //
        //     DashBoardMain(),
        //   ViewOutletstPage(),
        //      DashBoardMain(),
        // ])
        // ListView(
        //   children: [
        //     // Container(
        //     //   child: Center(
        //     //     // Adding Child Widget of Perspective PageView
        //     //     child: PerspectivePageView(
        //     //       hasShadow: true, // Enable-Disable Shadow
        //     //       shadowColor: Colors.black12, // Change Color
        //     //       aspectRatio: PVAspectRatio.ONE_ONE, // Aspect Ratio of 1:1 (Default)
        //     //       children: <Widget>[
        //     //         GestureDetector(
        //     //           onTap: () {
        //     //             debugPrint("Statement One");
        //     //           },
        //     //           child: Container(
        //     //             color: Colors.red,
        //     //           ),
        //     //         ),
        //     //         GestureDetector(
        //     //           onTap: () {
        //     //             debugPrint("Statement Two");
        //     //           },
        //     //           child: Container(
        //     //             color: Colors.green,
        //     //           ),
        //     //         )
        //     //       ],
        //     //
        //     //     ),
        //     //   ),
        //     // ),
        //     Container(
        //       width:  500,
        //       height: 500,
        //       child: CarouselSlider.builder(
        //         unlimitedMode: true,
        //         slideBuilder: (index){
        //           return Container(
        //             alignment: Alignment.center,
        //             child: _list,
        //             Text(
        //              _list,
        //                 style: TextStyle(fontSize: 200, color: Colors.white)
        //             ),
        //           );
        //         },
        //           slideTransform: CubeTransform(),
        //           slideIndicator: CircularSlideIndicator(
        //             padding: EdgeInsets.only(bottom: 32),
        //           ),
        //           itemCount: _list.length
        //       ),
        //     )
        //   ],
        // ),
      ),
   );
  }
  // Widget dashBoard(){
  //   return Container(
  //     child: Column(
  //       children: [
  //         Text("Select Route"),
  //         ElevatedButton(onPressed: (){
  //
  //        //   setState(() {
  //            //  Get.to(()=> tebController.animateTo(2));
  //             // tebController.animateTo(2);
  //         //   });
  //         }, child: Text("Route"))
  //       ],
  //     ),
  //   );
  // }
}

// Scrollbar(
// isAlwaysShown: true,
// interactive: true,
// thickness: 6.0,
// child: SingleChildScrollView(
// child: Padding(
// padding: const EdgeInsets.all(10.0),
// child: Center(
// child: Column(
// children: [
// // Text(
// //   "Distributor: ${Constants.selectedDistributor.name}",
// //   style: TextStyle(fontSize: 18.0),
// // ),
// SizedBox(
// height: Get.size.height * 0.03,
// ),
// TextField(
// style: TextStyle(color: Colors.red),
// decoration: decoration("Search Outlet" ),
// onChanged: (text) {
// //       Get.find<OutletsController>().searchList;
// },
// ),
// Column(
// children: [
//
// SizedBox(
// height: Get.size.height * 0.04,
// ),
// GetBuilder<OutletsController>(
// builder: (outletcontroller) {
// return
// // Get.find<OutletsController>()
// //   .searchList !=
// //   null
// //   ?  Get.find<OutletsController>()
// //   .searchList
// //   .isNotEmpty
// //   ? _buildListViewWidget(
// //   Get.find<OutletsController>()
// //       .searchList)
// //   : Center(child: Text("No Products"))
// //     Get.find<OutletsController>()
// //   .outletList ==
// //   null
// //    ?
// // Center(
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             CupertinoActivityIndicator(),
// //           ],
// //         ),
// //       )
// Get.find<OutletsController>()
//     .outletList
//     .isEmpty
// ? Center(child: Text("No Outlet"))
//     : _buildListViewWidget(
// Get.find<OutletsController>()
//     .outletList);
// },
// ),
// ],
// ),
//
// SizedBox(height: Get.size.height * 0.02),
// ],
// ),
// ),
// ),
// ),
// ),