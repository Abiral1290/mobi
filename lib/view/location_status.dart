import 'package:background_location/background_location.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobitrack_dv_flutter/controller/location_controller.dart';

class LocationStatusPage extends StatefulWidget {
  @override
  _LocationStatusPageState createState() => _LocationStatusPageState();
}

class _LocationStatusPageState extends State<LocationStatusPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Status'),
          actions: [
            TextButton(
              onPressed: () {
                Get.find<LocationController>().deleteAllLocation();
              },
              child: Text("Clear", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
        body: GetBuilder<LocationController>(
          builder: (location) {
            return Get.find<LocationController>().locationList == null
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount:
                        Get.find<LocationController>().locationList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(Get.find<LocationController>()
                            .locationList[index]
                            .time),
                        subtitle: Text(Get.find<LocationController>()
                                .locationList[index]
                                .latitude
                                .toString() +
                            ", " +
                            Get.find<LocationController>()
                                .locationList[index]
                                .longitude
                                .toString()),
                      );
                    },
                  );
          },
        ));
  }

  Widget locationData(String data) {
    return Text(
      data,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      textAlign: TextAlign.center,
    );
  }

  getCurrentLocation() {
    BackgroundLocation().getCurrentLocation().then((location) {
      print("This is current Location " + location.toMap().toString());
    });
  }

  // @override
  // void dispose() {
  //   BackgroundLocation.stopLocationService();
  //   super.dispose();
  // }
}
