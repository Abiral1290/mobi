import 'dart:async';
import 'dart:math';
import 'package:background_location/background_location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:mobitrack_dv_flutter/controller/outlets_controller.dart';
import 'package:mobitrack_dv_flutter/controller/preference_controller.dart';
import 'package:mobitrack_dv_flutter/model/location_model.dart';
import 'package:mobitrack_dv_flutter/controller/database_controller.dart';
import 'package:mobitrack_dv_flutter/model/outlet.dart';
import 'package:mobitrack_dv_flutter/utils/constants.dart';
import 'package:mobitrack_dv_flutter/utils/utilities.dart';

class LocationController extends GetxController {
  var outlet = Get.lazyPut(()=>OutletsController());
  List<LocationModel> locationList = [];
  DatabaseHelper databaseHelper = DatabaseHelper.instance;
  Position userPosition;
  StreamSubscription<Position> positionStream;
  String nearestOutletName = 'To be Determined';
  Outlet nearestOutlet;

  var preference = Get.put(PreferenceController());
  var outlets = Get.lazyPut(() => OutletsController());

  Future<bool> _checkLocation() async {
    bool isLocationOpened = await Geolocator.isLocationServiceEnabled();
    bool hasPerm = false;

    if (!isLocationOpened) {
      Utilities.showInToast('Please enable location!',
          toastType: ToastType.INFO);
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

  postLocation(LocationModel locationModel, bool inOutlet) async {
    print("inside post location");
    if (await Utilities.isInternetWorking()) {
      var savedLocation = await Get.find<PreferenceController>().getLocation();
      if (savedLocation != "") {
        var lat = double.parse(savedLocation.split(",").first.toString());
        var lng = double.parse(savedLocation.split(",").last.toString());
        if (((Utilities.calculateDistance(
                        lat,
                        lng,
                        double.parse(locationModel.latitude),
                        double.parse(locationModel.latitude))) *
                    1000)
                .abs() >
            Constants.locationRadius) {
          postLocationApi(locationModel, inOutlet).then((value) {
            if (value.success) {
              print("Location send success");

              Get.find<PreferenceController>()
                  .setLocation(locationModel.latitude, locationModel.longitude);
            } else {
              Get.find<LocationController>()
                  .addLocation(locationModel, inOutlet);
            }
          });
        }
      } else {
        postLocationApi(locationModel, inOutlet).then((value) {
          if (value.success) {
            print("Location send success");

            Get.find<PreferenceController>()
                .setLocation(locationModel.latitude, locationModel.longitude);
          } else {
            Get.find<LocationController>().addLocation(locationModel, inOutlet);
          }
        });
      }
    } else {
      Get.find<LocationController>().addLocation(locationModel, inOutlet);
    }
  }

  // setNearestOutletName() async {
  //   var outletLists = Get.find<OutletsController>().outletList;
  //   if (Constants.selectedDistributor != null &&
  //       outletLists.isNotEmpty &&
  //       userPosition != null) {
  //     Map<Outlet, double> values = new Map<Outlet, double>();
  //
  //     for (var o in outletLists) {
  //       var dist = Geolocator.distanceBetween(o.latitude, o.longitude,
  //           userPosition.latitude, userPosition.longitude);
  //       values[o] = dist;
  //     }
  //     var nearOut = values.entries.first;
  //     values.forEach((key, value) {
  //       if (value < nearOut.value) {
  //         nearOut = MapEntry(key, value);
  //       }
  //     });
  //     nearestOutletName = nearOut.key.name;
  //     nearestOutlet = nearOut.key;
  //
  //     update();
  //   }
  // }

  getPositionStream() async {
    positionStream = Geolocator.getPositionStream(
      // distanceFilter: 100,
      // intervalDuration: Duration(minutes: 1),
      // desiredAccuracy: LocationAccuracy.bestForNavigation,
    ).listen((Position position) async {
      if (position != null) {
        LocationModel model = LocationModel(
          id: Random().nextInt(100).toString(),
          latitude: position.latitude.toString(),
          longitude: position.longitude.toString(),
          date: DateTime.now().toString(),
          checkinoutId: Constants.checkInOut,
        );

        postLocation(model, false);

        userPosition = position;
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
 //   await BackgroundLocation.startLocationService(distanceFilter: 0);

    getPositionStream();
  }

  stopBackgroundLocationService() {
    BackgroundLocation.stopLocationService();
    positionStream.cancel();
    nearestOutletName = 'To be Determined';
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
      locationList.clear();
      update();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
