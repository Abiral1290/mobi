import 'dart:convert';

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
import 'package:mobitrack_dv_flutter/utils/constants.dart';
import 'package:mobitrack_dv_flutter/utils/utilities.dart';
import 'package:mobitrack_dv_flutter/view/location_status.dart';
import 'package:mobitrack_dv_flutter/view/drawer.dart';
import 'package:mobitrack_dv_flutter/view/products/sell_products.dart';
import 'package:mobitrack_dv_flutter/view/view_distributor.dart';
import 'package:mobitrack_dv_flutter/view/widgets/glow.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  LocationPermission permission;
  bool serviceEnabled;
  bool hasLocationPermission = false;
  String checkInId = "";

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

    super.initState();
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
              body: Stack(
                children: [
                  // Align(
                  //   alignment: Alignment.topCenter,
                  //   child: Text("You are near: "),
                  // ),
                  // if (Get.find<PreferenceController>().isCheckedIn)
                  //   Align(
                  //     alignment: Alignment.center,
                  //     child: Glow(
                  //       child: Container(),
                  //       startDelay: Duration(milliseconds: 000),
                  //       glowColor: Colors.blue[500],
                  //       endRadius: 200.0,
                  //     ),
                  //   ),
                  Center(
                    child: GetBuilder<LocationController>(
                      builder: (controller) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "You are near:",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: Get.size.height * 0.05,
                            ),
                            Get.find<PreferenceController>().isCheckedIn
                                ? Glow(
                                    startDelay: Duration(milliseconds: 000),
                                    glowColor: Colors.blue[500],
                                    endRadius: 200.0,
                                    child: InkWell(
                                      onTap: () {
                                        if (Get.find<LocationController>()
                                                    .nearestOutletName !=
                                                "To be Determined" &&
                                            Get.find<LocationController>()
                                                    .nearestOutlet !=
                                                null) {
                                          Get.to(() => SellProductPage(
                                              outlet:
                                                  Get.find<LocationController>()
                                                      .nearestOutlet));
                                        }
                                      },
                                      child: Text(
                                        Get.find<LocationController>()
                                            .nearestOutletName,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  )
                                : Text(
                                    "To Be Determined",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
