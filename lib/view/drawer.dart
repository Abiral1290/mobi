import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:mobitrack_dv_flutter/controller/auth_controller.dart';
import 'package:mobitrack_dv_flutter/utils/utilities.dart';
import 'package:mobitrack_dv_flutter/view/register/register_shop.dart';

class DrawerPage extends StatelessWidget {
  final ButtonStyle buttonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
    minimumSize: MaterialStateProperty.all<Size>(
        Size(Get.size.width, Get.size.height * 0.05)),
  );

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        child: Center(
          child: Column(
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey,
                radius: Get.size.width * 0.1,
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: Get.size.height * 0.01,
              ),
              Text(
                "Your Name",
                style: TextStyle(fontSize: 19),
              ),
              SizedBox(
                height: Get.size.height * 0.01,
              ),
              Text(
                "Your Number",
                style: TextStyle(fontSize: 25),
              ),
            ],
          ),
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    header(),
                    Divider(
                      thickness: 5.0,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        var res =
                            await GeolocatorPlatform.instance.checkPermission();

                        if (res == LocationPermission.whileInUse ||
                            res == LocationPermission.always) {
                          var res = await GeolocatorPlatform.instance
                              .isLocationServiceEnabled();
                          if (!res) {
                            Utilities.showInToast(
                                'Please enable location services and permision',
                                toastType: ToastType.INFO);
                            await GeolocatorPlatform.instance
                                .openLocationSettings();
                          } else {
                            Get.to(() => RegisterShopPage());
                          }

                          // setState(() {
                          //   userPos = pos;
                          //   _locationChecked = true;
                          // });
                        } else {
                          Utilities.showInToast(
                              'Please enable location services and permision',
                              toastType: ToastType.INFO);
                          await GeolocatorPlatform.instance.requestPermission();
                        }
                      },
                      child: Text("Register Shop"),
                      style: buttonStyle,
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text("Sell Product"),
                      style: buttonStyle,
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text("Add Entry"),
                      style: buttonStyle,
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  onPressed: () {
                    Get.find<AuthController>().setLoggedInData(false);
                  },
                  child: Text("Logout"),
                  style: buttonStyle.copyWith(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red[900]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
