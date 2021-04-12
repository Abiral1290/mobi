import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hawk_fab_menu/hawk_fab_menu.dart';
import 'package:mobitrack_dv_flutter/controller/location_controller.dart';
import 'package:mobitrack_dv_flutter/controller/preference_controller.dart';
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
          return HawkFabMenu(
            icon: AnimatedIcons.arrow_menu,
            fabColor: Get.find<PreferenceController>().isCheckedIn
                ? Colors.green[900]
                : Colors.red[900],
            iconColor: Colors.white,
            items: [
              HawkFabMenuItem(
                label: 'Check In',
                ontap: () {
                  Get.find<LocationController>().startLocationService();
                  Get.find<PreferenceController>().setCheckInValue(true);
                },
                icon: Icon(Icons.login_rounded),
                color: Colors.green[900],
                labelBackgroundColor: Colors.green[900],
                labelColor: Colors.white,
              ),
              HawkFabMenuItem(
                label: 'Check Out',
                ontap: () {
                  Get.find<LocationController>()
                      .stopBackgroundLocationService();
                  Get.find<PreferenceController>().setCheckInValue(false);
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
