import 'dart:async';
import 'dart:math';

import 'package:background_location/background_location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:mobitrack_dv_flutter/controller/outlets_controller.dart';
import 'package:mobitrack_dv_flutter/model/location_model.dart';
import 'package:mobitrack_dv_flutter/controller/database_controller.dart';
import 'package:mobitrack_dv_flutter/model/outlet.dart';
import 'package:mobitrack_dv_flutter/utils/constants.dart';
import 'package:mobitrack_dv_flutter/utils/utilities.dart';

class LocationController extends GetxController {
  List<LocationModel> locationList = [];
  DatabaseHelper databaseHelper = DatabaseHelper.instance;
  Position userPosition;
  StreamSubscription<Position> positionStream;
  String nearestOutlet = 'To be Determined';

  var outlets = Get.lazyPut(() => OutletsController());

  Future<bool> _checkLocation() async {
    bool isLocationOpened = await Geolocator.isLocationServiceEnabled();
    bool hasPerm = false;

    if (!isLocationOpened) {
      Utilities.showInToast('Please enable location!',
          toastType: ToastType.INFO);
      // Geolocator.openAppSettings();
      await Geolocator.openLocationSettings();
    } else {
      hasPerm = await Geolocator.checkPermission().then((value) {
        return (value == LocationPermission.always ||
            value == LocationPermission.whileInUse);
      });
      if (!hasPerm) {
        bool hasPerm = await Geolocator.requestPermission().then((value) {
          return (value == LocationPermission.always ||
              value == LocationPermission.whileInUse);
        });
        if (!hasPerm) {
          await Geolocator.openAppSettings();
        }
        print(hasPerm);
      }
    }
    return hasPerm && isLocationOpened;
  }

  _init() async {
    _checkLocation().then((value) {
      if (value) {
        getLocationData();
        getCurrentPosition();
      }
    });
  }

  LocationController() {
    _init();
  }

  setNearestOutletName(Position userPos) async {
    var outlets = Get.find<OutletsController>().outletList;
    if (outlets.isNotEmpty) {
      Map<Outlet, double> values = new Map<Outlet, double>();

      for (var o in outlets) {
        var dist = Geolocator.distanceBetween(
            o.latitude, o.longitude, userPos.latitude, userPos.longitude);
        values[o] = dist;
      }
      var nearOut = values.entries.first;
      values.forEach((key, value) {
        if (value < nearOut.value) {
          nearOut = MapEntry(key, value);
        }
      });
      nearestOutlet = nearOut.key.name;

      update();
    }
  }

  getPositionStream() async {
    positionStream =
        Geolocator.getPositionStream(intervalDuration: Duration(seconds: 20))
            .listen((Position position) async {
      if (position != null) {
        setNearestOutletName(position);

        LocationModel model = LocationModel(
          id: Random().nextInt(100).toString(),
          latitude: position.latitude.toString(),
          longitude: position.longitude.toString(),
          date: DateTime.now().toString(),
          checkinoutId: Constants.checkInOut,
        );
        if (await Utilities.isInternetWorking()) {
          postLocationApi(model, false).then((value) {
            if (value.success) {
              print("Location send success");
            } else {
              Get.find<LocationController>().addLocation(model, false);
            }
          });
        } else {
          Get.find<LocationController>().addLocation(model, false);
        }

        position = position;
        update();
      }
    });
  }

  getCurrentPosition() {
    Geolocator.getCurrentPosition().then((value) {
      if (value != null) {
        userPosition = value;
        update();
      }
    });
  }

  startLocationService() async {
    await BackgroundLocation.setAndroidNotification(
      title: "Background service is running",
      message: "Background service is running",
      icon: "@mipmap/ic_launcher",
    );
    await BackgroundLocation.setAndroidConfiguration(1000);
    await BackgroundLocation.startLocationService(distanceFilter: 0);

    getPositionStream();
  }

  stopBackgroundLocationService() {
    BackgroundLocation.stopLocationService();
    // timer?.cancel();
    positionStream.cancel();
    nearestOutlet = 'To be Determined';
    update();

    print("Stream cancelled");
  }

  getLocationData() {
    databaseHelper.getAllLocationData().then((value) {
      locationList = value;
      update();
    });
  }

  addLocation(LocationModel locationModel, bool inOutlet) {
    databaseHelper.insertLocationData(locationModel, inOutlet).then((value) {
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
    // timer?.cancel();
    super.dispose();
  }
}
