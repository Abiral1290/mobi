import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobitrack_dv_flutter/controller/auth_controller.dart';
import 'package:mobitrack_dv_flutter/controller/location_controller.dart';
import 'package:mobitrack_dv_flutter/controller/preference_controller.dart';
import 'package:mobitrack_dv_flutter/view/location_status.dart';

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
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.logout),
          onPressed: () {
            Get.find<AuthController>().setLoggedInData(false);
          },
        ),
        appBar: AppBar(
          title: const Text('Mobitrack'),
          actions: [
            TextButton(
              child: Text("Start", style: TextStyle(color: Colors.white)),
              onPressed: () {
                Get.find<LocationController>().startLocationService();
                Get.find<PreferenceController>().setCheckInValue(true);

                // await BackgroundLocation.setAndroidNotification(
                //   title: "Background service is running",
                //   message: "Background service is running",
                //   icon: "@mipmap/ic_launcher",
                // );
                // await BackgroundLocation.setAndroidConfiguration(10000);
                // await BackgroundLocation.startLocationService(
                //     distanceFilter: 0);
                // Geolocator.getCurrentPosition(
                //   desiredAccuracy: LocationAccuracy.bestForNavigation,
                // ).then((value) {
                //   if (value != null) {
                //     LocationModel model = LocationModel(
                //       id: Random().nextInt(100).toString(),
                //       latitude: value.latitude,
                //       longitude: value.longitude,
                //       time: value.timestamp.toString(),
                //     );
                //     Get.find<LocationController>().addLocation(model);
                //   }
                // });
                // BackgroundLocation().getCurrentLocation().then((location) {
                //   Get.showSnackbar(GetBar(
                //     title: "Running",
                //     message: "",
                //     messageText: Text(DateTime.now().toString()),
                //     duration: Duration(seconds: 1),
                //   ));

                //   LocationModel model = LocationModel(
                //     id: Random().nextInt(100).toString(),
                //     latitude: location.latitude,
                //     longitude: location.longitude,
                //     time: location.time.toString(),
                //   );
                //   Get.find<LocationController>().addLocation(model);

                //   print("""\n
                //           Latitude:  ${location.latitude}
                //           Longitude: ${location.longitude}
                //           Altitude: ${location.altitude}
                //           Accuracy: ${location.accuracy}
                //           Bearing:  ${location.bearing}
                //           Speed: ${location.speed}
                //           Time: ${location.time}
                //         """);
                // });
              },
            ),
            TextButton(
              onPressed: () {
                Get.find<LocationController>().stopBackgroundLocationService();
                Get.find<PreferenceController>().setCheckInValue(false);
                // BackgroundLocation.stopLocationService();
              },
              child: Text("Stop", style: TextStyle(color: Colors.white)),
            ),
            TextButton(
              onPressed: () {
                Get.to(() => LocationStatusPage());
              },
              child: Text("Status", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
        body: Center(
          child: Text("This is home page"),
        ));
  }
}
