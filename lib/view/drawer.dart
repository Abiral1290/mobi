import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:mobitrack_dv_flutter/controller/auth_controller.dart';
import 'package:mobitrack_dv_flutter/utils/utilities.dart';
import 'package:mobitrack_dv_flutter/view/attendance/show_attendance.dart';
import 'package:mobitrack_dv_flutter/view/info/about.dart';
import 'package:mobitrack_dv_flutter/view/outlets/view_outlets.dart';
import 'package:mobitrack_dv_flutter/view/products/view_products.dart';
import 'package:mobitrack_dv_flutter/view/profile.dart';
import 'package:mobitrack_dv_flutter/view/outlets/register_outlet.dart';
import 'package:mobitrack_dv_flutter/view/collections/add_collections.dart';
import 'package:mobitrack_dv_flutter/view/collections/view_collection.dart';
import 'package:mobitrack_dv_flutter/view/report/sales_report.dart';
import 'package:mobitrack_dv_flutter/view/view_distributor.dart';

class DrawerPage extends StatelessWidget {
  final ButtonStyle buttonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
    minimumSize: MaterialStateProperty.all<Size>(
        Size(Get.size.width, Get.size.height * 0.05)),
  );

  final ButtonStyle expandedButtonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(Colors.blue[900]),
    minimumSize: MaterialStateProperty.all<Size>(
        Size(Get.size.width, Get.size.height * 0.05)),
    elevation: MaterialStateProperty.all<double>(10.0),
  );

  @override
  Widget build(BuildContext context) {
    Widget header() {
      var user = Get.find<AuthController>().user;
      return Container(
        child: Center(
          child: Column(
            children: [
              GestureDetector(
                onTap: () => Get.to(() => ProfilePage()),
                child: CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: Get.size.width * 0.1,
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: Get.size.height * 0.01,
              ),
              Text(
                user.name,
                style: TextStyle(fontSize: 19),
              ),
              SizedBox(
                height: Get.size.height * 0.01,
              ),
              Text(
                user.phone,
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                header(),
                Divider(
                  thickness: 5.0,
                ),
                ExpansionTile(
                  title: InputDecorator(
                    decoration: InputDecoration(),
                    child: Row(
                      children: [
                        Icon(Icons.shopping_bag_outlined),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Outlet",
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  // backgroundColor: Colors.green,
                  // collapsedBackgroundColor: Colors.green,
                  children: [
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
                        } else {
                          Utilities.showInToast(
                              'Please enable location services and permision',
                              toastType: ToastType.INFO);
                          await GeolocatorPlatform.instance
                              .openLocationSettings();
                          await GeolocatorPlatform.instance.requestPermission();
                        }
                      },
                      child: Text("Register Shop"),
                      style: expandedButtonStyle,
                    ),
                    ElevatedButton(
                      onPressed: () => Get.to(() => ViewOutletsPage()),
                      child: Text("View Shop"),
                      style: expandedButtonStyle,
                    ),
                  ],
                ),
                SizedBox(height: Get.size.height * 0.01),
                ExpansionTile(
                  title: InputDecorator(
                    decoration: InputDecoration(),
                    child: Row(
                      children: [
                        Icon(Icons.category_outlined),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Products",
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Get.to(() => ViewProductsPage());
                      },
                      child: Text("View Products"),
                      style: expandedButtonStyle,
                    ),
                  ],
                ),
                SizedBox(height: Get.size.height * 0.01),
                ExpansionTile(
                  title: InputDecorator(
                    decoration: InputDecoration(),
                    child: Row(
                      children: [
                        Icon(Icons.file_present),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Report",
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Get.to(() => SalesReportPage());
                      },
                      child: Text("Sales Report"),
                      style: expandedButtonStyle,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Get.to(() => AttendancePage());
                      },
                      child: Text("Attendance Report"),
                      style: expandedButtonStyle,
                    ),
                  ],
                ),
                SizedBox(height: Get.size.height * 0.01),
                ExpansionTile(
                  title: InputDecorator(
                    decoration: InputDecoration(),
                    child: Row(
                      children: [
                        Icon(Icons.collections_bookmark),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Collection",
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Get.to(() => ViewCollectionPage());
                      },
                      child: Text("View Collection"),
                      style: expandedButtonStyle,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Get.to(() => AddCollectionsPage());
                      },
                      child: Text("Store Collection"),
                      style: expandedButtonStyle,
                    ),
                  ],
                ),
                SizedBox(height: Get.size.height * 0.01),
                ExpansionTile(
                  title: InputDecorator(
                    decoration: InputDecoration(),
                    child: Row(
                      children: [
                        Icon(Icons.select_all),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Distributor",
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Get.to(() => ViewDistributorPage());
                      },
                      child: Text("View Distributor"),
                      style: expandedButtonStyle,
                    ),
                  ],
                ),
                InputDecorator(
                  decoration: InputDecoration(),
                  child: GestureDetector(
                    onTap: () => Get.to(() => AboutPage()),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Row(
                        children: [
                          Icon(Icons.info_outline_rounded),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "About",
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: Get.size.height * 0.09),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.find<AuthController>().logout();
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
      ),
    );
  }
}
