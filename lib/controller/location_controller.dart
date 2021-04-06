import 'dart:async';
import 'dart:math';

import 'package:background_location/background_location.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:mobitrack_dv_flutter/model/location_model.dart';
import 'package:mobitrack_dv_flutter/controller/database_controller.dart';

class LocationController extends GetxController {
  List<LocationModel> locationList;
  DatabaseHelper databaseHelper = DatabaseHelper.instance;
  Timer timer;

  LocationController() {
    getLocationData();
  }

  startLocationService() async {
    await BackgroundLocation.setAndroidNotification(
      title: "Background service is running",
      message: "Background service is running",
      icon: "@mipmap/ic_launcher",
    );
    await BackgroundLocation.setAndroidConfiguration(1000);
    await BackgroundLocation.startLocationService(distanceFilter: 0)
        .then((value) {
      print(value.toString());
    });
    Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.bestForNavigation,
    ).then((value) {
      if (value != null) {
        LocationModel model = LocationModel(
          id: Random().nextInt(100).toString(),
          latitude: value.latitude,
          longitude: value.longitude,
          time: value.timestamp.toString(),
        );
        Get.find<LocationController>().addLocation(model);
      }
    });
    timer = Timer.periodic(Duration(seconds: 20), (timer) {
      print("Timer started");
      BackgroundLocation().getCurrentLocation().then((location) {
        Get.showSnackbar(GetBar(
          title: "Running",
          message: "",
          messageText: Text(DateTime.now().toString()),
          duration: Duration(seconds: 1),
        ));

        LocationModel model = LocationModel(
          id: Random().nextInt(100).toString(),
          latitude: location.latitude,
          longitude: location.longitude,
          time: location.time.toString(),
        );
        Get.find<LocationController>().addLocation(model);

        print("""\n
                          Latitude:  ${location.latitude}
                          Longitude: ${location.longitude}
                          Altitude: ${location.altitude}
                          Accuracy: ${location.accuracy}
                          Bearing:  ${location.bearing}
                          Speed: ${location.speed}
                          Time: ${location.time}
                        """);
      });
      print("Running: ${DateTime.now()}");
    });
  }

  stopBackgroundLocationService() {
    BackgroundLocation.stopLocationService();
    timer?.cancel();
    print("Timer cancelled");
  }

  getLocationData() {
    databaseHelper.getAllLocationData().then((value) {
      locationList = value;
      update();
    });
  }

  addLocation(LocationModel locationModel) {
    databaseHelper.insertLocationData(locationModel).then((value) {
      locationList.add(value);
      update();
    });
  }

  deleteLocation(LocationModel locationModel) {
    databaseHelper
        .removeLocationData(locationModel.id.toString())
        .then((value) {
      if (value == 1) {
        locationList.remove(locationModel);
        update();
      } else {}
    });
  }

  deleteAllLocation() {
    databaseHelper.removeAllLocationData().then((value) {
      // if (value == 1) {
      locationList.clear();
      update();
      // } else {}
    });
  }

  @override
  void dispose() {
    // BackgroundLocation.stopLocationService();
    timer?.cancel();
    super.dispose();
  }
}
