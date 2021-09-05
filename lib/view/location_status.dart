import 'package:background_location/background_location.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobitrack_dv_flutter/controller/location_controller.dart';
import 'package:mobitrack_dv_flutter/model/location_model.dart';
import 'package:mobitrack_dv_flutter/utils/utilities.dart';

class LocationStatusPage extends StatefulWidget {
  @override
  _LocationStatusPageState createState() => _LocationStatusPageState();
}

class _LocationStatusPageState extends State<LocationStatusPage> {
  var location = Get.lazyPut(() => LocationController());
  var locationController = Get.find<LocationController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Status'),
          actions: [
            TextButton(
              onPressed: () async {
                var conn = await Utilities.isInternetWorking();
                if (conn) {
                  Utilities.showInToast("Syncing Data",
                      toastType: ToastType.INFO);
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
                } else {
                  Utilities.showInToast("No Internet",
                      toastType: ToastType.ERROR);
                }
              },
              child: Text("Sync", style: TextStyle(color: Colors.white)),
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
                            .date),
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
