import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:hawk_fab_menu/hawk_fab_menu.dart';
import 'package:mobitrack_dv_flutter/controller/address_controller.dart';
import 'package:mobitrack_dv_flutter/controller/bank_controller.dart';
import 'package:mobitrack_dv_flutter/controller/collections_controller.dart';
import 'package:mobitrack_dv_flutter/controller/location_controller.dart';
import 'package:mobitrack_dv_flutter/controller/outlets_controller.dart';
import 'package:mobitrack_dv_flutter/controller/preference_controller.dart';
import 'package:mobitrack_dv_flutter/controller/products_controller.dart';
import 'package:mobitrack_dv_flutter/model/check_in_out.dart';
import 'package:mobitrack_dv_flutter/model/distributor.dart';
import 'package:mobitrack_dv_flutter/model/location_model.dart';
import 'package:mobitrack_dv_flutter/model/products.dart';
import 'package:mobitrack_dv_flutter/utils/constants.dart';
import 'package:mobitrack_dv_flutter/utils/utilities.dart';
import 'package:mobitrack_dv_flutter/view/attendance/show_attendance.dart';
import 'package:mobitrack_dv_flutter/view/collections/add_collections.dart';
import 'package:mobitrack_dv_flutter/view/collections/view_collection.dart';
import 'package:mobitrack_dv_flutter/view/location_status.dart';
import 'package:mobitrack_dv_flutter/view/drawer.dart';
import 'package:mobitrack_dv_flutter/view/monthly_tour/register_monthly_tour.dart';
import 'package:mobitrack_dv_flutter/view/outlets/register_outlet.dart';
import 'package:mobitrack_dv_flutter/view/outlets/view_outlets.dart';
import 'package:mobitrack_dv_flutter/view/products/view_products.dart';
import 'package:mobitrack_dv_flutter/view/report/sales_report_page.dart';
import 'package:mobitrack_dv_flutter/view/stock_count/add_stock_count.dart';
import 'package:mobitrack_dv_flutter/view/view_distributor.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart' as picker;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  LocationPermission permission;
  bool serviceEnabled;
  bool hasLocationPermission = false;
  String checkInId = "";

  var locationController = Get.find<LocationController>();

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

      // postLocationApi(model, list.outletId == null ? false : true)
      //     .then((value) {
      //   if (value.success) {
      //     Get.find<LocationController>().deleteLocation(list);
      //     print("Location send success");
      //   }
      // });
    }
  }

  @override
  void initState() {
    Get.find<ProductsController>();
    Get.find<AddressController>();
    Get.find<BankController>();
    Get.find<CollectionController>();

    Get.find<PreferenceController>().getCheckInValue().then((value) {
      if (value.split("//").last == "true") {
        Constants.checkInOut = value.split("//")[1];
        Get.find<LocationController>().startLocationService();
        checkInId = value.split("//")[1];
      }
    });

    Get.find<PreferenceController>().getDistributor().then((value) {
      if (value.isEmpty) {
        Get.to(() => ViewDistributorPage());
      } else {
        Constants.selectedDistributor = Distributor.fromJson(jsonDecode(value));
        print(Constants.selectedDistributor);
      }
    });

    // Get.find<OutletsController>();

    Future.delayed(Duration(seconds: 6), () {
      Get.find<OutletsController>();
    });

    Timer.periodic(Duration(hours: 1), (timer) {
      pushLocationData();
    });

    super.initState();
  }

  Widget singleTileItem(
      IconData icon, String title, Color color, VoidCallback onPressed) {
    return InkWell(
      borderRadius: BorderRadius.circular(12.0),
      onTap: onPressed,
      enableFeedback: true,
      child: Card(
        elevation: 8.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        shadowColor: color,
        color: color,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: Colors.white70,
                size: 30,
              ),
              SizedBox(
                height: Get.size.height * 0.02,
              ),
              Text(
                title,
                style: TextStyle(color: Colors.white70, fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        drawer: Drawer(
          child: DrawerPage(),
        ),
        appBar: AppBar(
          title: const Text('Mobitrack'),
          actions: [
            TextButton(
              onPressed: () {
                Get.to(() => LocationStatusPage());
              },
              child: Text("Status", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
        body: GetBuilder<PreferenceController>(
          builder: (preferenceController) {
            print("Checked in home: ${preferenceController.isCheckedIn}");
            // var user = Get.find<AuthController>();
            var location = Get.find<LocationController>();
            print(preferenceController.isCheckedIn ? 'is check' : ' not check');

            return HawkFabMenu(
              icon: AnimatedIcons.arrow_menu,
              fabColor: Get.find<PreferenceController>().isCheckedIn
                  ? Colors.green[900]
                  : Colors.red[900],
              iconColor: Colors.white,
              items: [
                !preferenceController.isCheckedIn
                    ? HawkFabMenuItem(
                        label: 'Check In',
                        ontap: () async {
                          var conn = await Utilities.isInternetWorking();

                          if (conn) {
                            // Test if location services are enabled.
                            serviceEnabled =
                                await Geolocator.isLocationServiceEnabled();
                            if (!serviceEnabled) {
                              return Utilities.showInToast(
                                  'Location services are disabled.',
                                  toastType: ToastType.ERROR);
                            }
                            // check for permission
                            permission = await Geolocator.checkPermission();
                            if (permission == LocationPermission.denied ||
                                permission ==
                                    LocationPermission.deniedForever) {
                              Utilities.showInToast(
                                  "Location permission is denied, Please enable permission for future use",
                                  toastType: ToastType.ERROR);
                              // request permission
                              permission = await Geolocator.requestPermission();
                              if (permission == LocationPermission.denied ||
                                  permission ==
                                      LocationPermission.deniedForever) {
                                // Permissions are denied,
                                return Utilities.showInToast(
                                    "Location permission is denied, Please enable permission for future use",
                                    toastType: ToastType.ERROR);
                              }
                            }

                            await Get.find<LocationController>()
                                .getCurrentPosition();
                            if (location.userPosition != null) {
                              var resp = await checkInAPI(
                                  location.userPosition.latitude.toString(),
                                  location.userPosition.longitude.toString());
                              if (resp.success) {
                                location.startLocationService();
                                Get.find<PreferenceController>()
                                    .setCheckInValue(true,
                                        checkInId: resp.response.toString());
                                Constants.checkInOut = resp.response.toString();
                                checkInId = resp.response.toString();
                                Get.to(() => ViewDistributorPage());
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
                        },
                        icon: Icon(Icons.login_rounded),
                        color: Colors.green[900],
                        labelBackgroundColor: Colors.green[900],
                        labelColor: Colors.white,
                      )
                    : HawkFabMenuItem(
                        label: 'Check Out',
                        ontap: () async {
                          var conn = await Utilities.isInternetWorking();

                          if (conn) {
                            // sync location data

                            pushLocationData();

                            // Test if location services are enabled.
                            serviceEnabled =
                                await Geolocator.isLocationServiceEnabled();
                            if (!serviceEnabled) {
                              return Future.error(
                                  'Location services are disabled.');
                            }

                            // check for permission
                            permission = await Geolocator.checkPermission();
                            if (permission == LocationPermission.denied ||
                                permission ==
                                    LocationPermission.deniedForever) {
                              Utilities.showInToast(
                                  "Location permission is denied, Please enable permission for future use");
                              // request permission
                              permission = await Geolocator.requestPermission();
                              if (permission == LocationPermission.denied ||
                                  permission ==
                                      LocationPermission.deniedForever) {
                                // Permissions are denied,
                                return Utilities.showInToast(
                                    "Location permission is denied, Please enable permission for future use");
                              }
                            }
                            await Get.find<LocationController>()
                                .getCurrentPosition();
                            if (location.userPosition != null) {
                              var resp = await checkOutAPI(
                                  location.userPosition.latitude.toString(),
                                  location.userPosition.longitude.toString(),
                                  checkInId);
                              if (resp.success) {
                                location.stopBackgroundLocationService();
                                Get.find<PreferenceController>()
                                    .setCheckInValue(false);
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

                          //down
                        },
                        icon: Icon(Icons.logout),
                        color: Colors.red[900],
                        labelBackgroundColor: Colors.red[900],
                        labelColor: Colors.white,
                      ),
              ],

              body: GridView.count(
                crossAxisCount: 2,
                children: [
                  singleTileItem(Icons.shop_two, "View Shop", Colors.blue[900],
                      () => Get.to(() => ViewOutletsPage())),
                  singleTileItem(
                    Icons.shopping_bag_outlined,
                    "Register Shop",
                    Colors.blue[900],
                    () async {
                      var res =
                          await GeolocatorPlatform.instance.checkPermission();

                      if (res == LocationPermission.whileInUse ||
                          res == LocationPermission.always) {
                        var res = await GeolocatorPlatform.instance
                            .isLocationServiceEnabled();
                        if (!res) {
                          Utilities.showInToast(
                              'Please enable location services and permision',
                              toastType: ToastType.INFO);
                          await GeolocatorPlatform.instance
                              .openLocationSettings();
                        } else {
                          Get.to(() => RegisterShopPage());
                        }
                      } else {
                        Utilities.showInToast(
                            'Please enable location services and permision',
                            toastType: ToastType.INFO);
                        await GeolocatorPlatform.instance
                            .openLocationSettings();
                        await GeolocatorPlatform.instance.requestPermission();
                      }
                    },
                  ),
                  singleTileItem(
                    Icons.category_outlined,
                    "Products",
                    Colors.red[900],
                    () {
                      Get.to(() => ViewProductsPage());
                    },
                  ),
                  singleTileItem(
                    Icons.select_all,
                    "Distributors",
                    Colors.red[900],
                    () {
                      Get.to(() => ViewDistributorPage());
                    },
                  ),
                  singleTileItem(
                    Icons.list,
                    "Sales Report",
                    Colors.green[900],
                    () {
                      Get.to(() => SalesReportPage());
                    },
                  ),
                  singleTileItem(
                    Icons.list_alt_rounded,
                    "Attendance Report",
                    Colors.green[900],
                    () {
                      Get.to(() => AttendancePage());
                    },
                  ),
                  singleTileItem(
                    Icons.collections_sharp,
                    "View Collection",
                    Colors.amber[900],
                    () {
                      Get.to(() => ViewCollectionPage());
                    },
                  ),
                  singleTileItem(
                    Icons.control_point_duplicate_outlined,
                    "Store Collection",
                    Colors.amber[900],
                    () {
                      Get.to(() => AddCollectionsPage());
                    },
                  ),
                  singleTileItem(
                    Icons.tour_rounded,
                    "Monthly Tour",
                    Colors.red[900],
                    () async {
                      NepaliDateTime dateTime =
                          await picker.showMaterialDatePicker(
                        context: context,
                        initialDate: NepaliDateTime.now(),
                        firstDate: NepaliDateTime(1970),
                        lastDate: NepaliDateTime(2100),
                        initialDatePickerMode: DatePickerMode.day,
                      );
                      if (dateTime != null)
                        Get.to(() => RegisterMonthlyTourPage(
                              dateTime: dateTime,
                            ));
                    },
                  ),
                  singleTileItem(
                    Icons.format_list_numbered,
                    "Store Stock Count",
                    Colors.purple[900],
                    () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return CupertinoAlertDialog(
                            title: Text("Please Wait"),
                            content: Column(
                              children: [
                                Text("Stock Status is being fetch!"),
                                CupertinoActivityIndicator(),
                              ],
                            ),
                          );
                        },
                        barrierDismissible: false,
                      );
                      fetchStockStatus(
                              Constants.selectedDistributor.id.toString())
                          .then((value) {
                        Get.back();
                        if (value.success) {
                          print(value.response);
                          Get.to(() => AddStockCount(
                                stockType: value.response,
                              ));
                        } else {
                          Utilities.showInToast(
                              "Could not fetch stock status data. Please try again later",
                              toastType: ToastType.ERROR);
                        }
                      });
                    },
                  ),
                ],
              ),
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
      ),
    );
  }
}
