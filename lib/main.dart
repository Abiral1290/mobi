import 'dart:math';

import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mobitrack_dv_flutter/controller/location_controller.dart';
import 'package:mobitrack_dv_flutter/model/location_model.dart';
import 'package:mobitrack_dv_flutter/utils/constants.dart';
import 'package:workmanager/workmanager.dart';
import 'package:yaml/yaml.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobitrack_dv_flutter/controller_bindings.dart';
import 'package:mobitrack_dv_flutter/view/splash_screen.dart';
import 'package:mobitrack_dv_flutter/controller/notification_controller.dart'
    as notif;

const fetchBackground = "fetchBackground";

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    switch (task) {
      case fetchBackground:
        //Geolocator geoLocator = Geolocator()..forceAndroidLocationManager = true;
        Position userLocation = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best);
        notif.Notification notification = new notif.Notification();
        notification.showNotificationWithoutSound(userLocation);
        LocationModel model = LocationModel(
          id: Random().nextInt(100).toString(),
          latitude: userLocation.latitude.toString(),
          longitude: userLocation.longitude.toString(),
          date: DateTime.now().toString(),
          checkinoutId: Constants.checkInOut,
        );
        LocationController().addLocation(model, false);
        break;
    }
    return Future.value(true);
  });
}

void main() {
  runApp(MyApp());
  setupAppVer();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'MobiTrack DV',
      initialBinding: ControllerBindings(),
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      home: SplashScreen(),
    );
  }
}

setupAppVer() async {
  var res = await rootBundle.loadString("pubspec.yaml");
  Map yaml = loadYaml(res);
  String ver = yaml['version'];
  Constants.appVerId = int.parse(ver.split('+').last);
  Constants.appVername = (ver.split('+').first);
}
