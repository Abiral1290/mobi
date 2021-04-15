import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hawk_fab_menu/hawk_fab_menu.dart';
import 'package:mobitrack_dv_flutter/controller/auth_controller.dart';
import 'package:mobitrack_dv_flutter/controller/location_controller.dart';
import 'package:mobitrack_dv_flutter/controller/preference_controller.dart';
import 'package:mobitrack_dv_flutter/utils/constants.dart';
import 'package:mobitrack_dv_flutter/utils/utilities.dart';
import 'package:mobitrack_dv_flutter/view/location_status.dart';
import 'package:mobitrack_dv_flutter/view/drawer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    Get.find<PreferenceController>().getCheckInValue().then((value) {
      if (value) {
        Get.find<LocationController>().startLocationService();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          var user = Get.find<AuthController>();
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
                          //TODO: check in API
                          var resp = await user.checkInOut(
                              Check.checkIn,
                              location.userPosition.latitude.toString(),
                              location.userPosition.longitude.toString());
                          if (resp.success) {
                            location.startLocationService();
                            Get.find<PreferenceController>()
                                .setCheckInValue(true);
                          } else {
                            Utilities.showInToast(resp.message,
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
                          //TODO: check in API
                          var resp = await user.checkInOut(
                              Check.checkOut,
                              location.userPosition.latitude.toString(),
                              location.userPosition.longitude.toString());
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
            body: Center(
              child: Text(
                'You are near: Khadka Store',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          );
        },
      ),
    );
  }
}
