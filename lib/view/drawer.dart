import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:mobitrack_dv_flutter/controller/auth_controller.dart';
import 'package:mobitrack_dv_flutter/model/products.dart';
import 'package:mobitrack_dv_flutter/utils/constants.dart';
import 'package:mobitrack_dv_flutter/utils/utilities.dart';
import 'package:mobitrack_dv_flutter/view/attendance/show_attendance.dart';
import 'package:mobitrack_dv_flutter/view/info/about.dart';
import 'package:mobitrack_dv_flutter/view/monthly_tour/register_monthly_tour.dart';
import 'package:mobitrack_dv_flutter/view/outlets/view_outlets.dart';
import 'package:mobitrack_dv_flutter/view/products/brandwiseproduct.dart';
import 'package:mobitrack_dv_flutter/view/products/view_products.dart';
import 'package:mobitrack_dv_flutter/view/profile.dart';
import 'package:mobitrack_dv_flutter/view/outlets/register_outlet.dart';
import 'package:mobitrack_dv_flutter/view/collections/add_collections.dart';
import 'package:mobitrack_dv_flutter/view/collections/view_collection.dart';
import 'package:mobitrack_dv_flutter/view/report/sales_report_page.dart';
import 'package:mobitrack_dv_flutter/view/stock_count/add_stock_count.dart';
import 'package:mobitrack_dv_flutter/view/view_distributor.dart';
import 'package:mobitrack_dv_flutter/view/view_routes.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart' as picker;

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
                user.id.toString(),
                style: TextStyle(fontSize: 25),
              ),
            ],
          ),
        ),
      );
    }
    showAlertDialog( BuildContext context ) {

      // set up the buttons
      Widget cancelButton = TextButton(
        child: Text("Cancel"),
        onPressed:  () {
          Get.back();
        },
      );
      Widget continueButton = TextButton(
        child: Text("Submit Request"),
        onPressed:  () async {
          var conn = await Utilities.isInternetWorking();
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return CupertinoAlertDialog(
                  title: Text('Please Wait'),
                  content: Column(
                    children: [
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(conn
                            ? 'Submitting Your Request'
                            : 'Saving offline'),
                      ),
                      CupertinoActivityIndicator(
                        radius: 17,
                      )
                    ],
                  ),
                );
              });

          // if(conn){
          //   var response = await DeleteOutletPost(delete);
          //
          //   Utilities.showInToast(response.message,
          //       toastType: response.success
          //           ? ToastType.SUCCESS
          //           : ToastType.ERROR);
          //   Get.back();
          //   Get.back();
          // }else{
          //   Get.back();
          //   //  outlet.synced = false;
          //
          //   Utilities.showInToast('Storing Offline',
          //       toastType: ToastType.INFO);
          // }
        },
      );

      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: Text("Absent Request"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Register your reason for taking a leave below :"),
              TextField(
          //      controller: remarkcontroller,
              )
            ],
          ),
        ),
        actions: [
          cancelButton,
          continueButton,
        ],
      );

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
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
                      onPressed: Constants.selectmyRoute != null
                          ? Constants.selectmyRoute != null
                              ? () async {
                                  var res = await GeolocatorPlatform.instance
                                      .checkPermission();

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
                                //      Get.to(() => RegisterShopPage());
                                    }
                                  } else {
                                    Utilities.showInToast(
                                        'Please enable location services and permision',
                                        toastType: ToastType.INFO);
                                    await GeolocatorPlatform.instance
                                        .openLocationSettings();
                                    await GeolocatorPlatform.instance
                                        .requestPermission();
                                  }
                                }
                              : () => Utilities.showInToast(
                                  "Please select route first")
                          : () => Utilities.showInToast(
                              "Please select route first"),
                      child: Text("Register Shop"),
                      style: expandedButtonStyle,
                    ),
                    ElevatedButton(
                      onPressed: Constants.selectmyRoute != null
                          ? Constants.selectmyRoute != null
                              ? () => Get.to(() => ViewOutletstPage())
                              : () => Utilities.showInToast(
                                  "Please select route first")
                          : () => Utilities.showInToast(
                              "Please select route first"),
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
                        Get.to(() => ViewOutletstPage());
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
                          "Routes",
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Get.to(() => View_route());
                      },
                      child: Text("View Routes"),
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
                        Icon(Icons.request_quote),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Absent Request",
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // showDialog(
                        //   context: context,
                        //   builder: (context) {
                        //     return
                        //        CupertinoAlertDialog(
                        //       title: Text("Please Wait"),
                        //       content: Column(
                        //         children: [
                        //           Text("Stock Status is being fetch!"),
                        //           CupertinoActivityIndicator(),
                        //         ],
                        //       ),
                        //     );
                        //   },
                        //   barrierDismissible: false,
                        // );
                        // fetchStockStatus(
                        //     Constants.selectedroute.id.toString())
                        //     .then((value) {
                        //   Get.back();
                        //   if (value.success) {
                        //     print(value.response);
                        //     Get.to(() => AddStockCount(
                        //       stockType: value.response,
                        //     ));
                        //   } else {
                        //     Utilities.showInToast(
                        //         "Could not fetch stock status data. Please try again later",
                        //         toastType: ToastType.ERROR);
                        //   }
                        // });
                        showAlertDialog(context);
                      },
                      child: Text("Absent Request"),
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
                        Icon(Icons.tour_rounded),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Monthly Tour",
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        NepaliDateTime dateTime =
                            await picker.showMaterialDatePicker(
                          context: context,
                          initialDate: NepaliDateTime.now(),
                          firstDate: NepaliDateTime(1970),
                          lastDate: NepaliDateTime(2100),
                          initialDatePickerMode: DatePickerMode.day,
                        );
                        if (dateTime != null)
                          Get.to(() => RegisterMonthlyTourPage(
                                dateTime: dateTime,
                              ));
                      },
                      child: Text("Store Monthly Tour"),
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
                        Icon(Icons.format_list_numbered),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Stock Count",
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return CupertinoAlertDialog(
                              title: Text("Please Wait"),
                              content: Column(
                                children: [
                                  Text("Stock Status is being fetch!"),
                                  CupertinoActivityIndicator(),
                                ],
                              ),
                            );
                          },
                          barrierDismissible: false,
                        );
                        fetchStockStatus(
                                Constants.selectedroute.id.toString())
                            .then((value) {
                          Get.back();
                          if (value.success) {
                            print(value.response);
                            Get.to(() => AddStockCount(
                                  stockType: value.response,
                                ));
                          } else {
                            Utilities.showInToast(
                                "Could not fetch stock status data. Please try again later",
                                toastType: ToastType.ERROR);
                          }
                        });
                      },
                      child: Text("Store Stock Count"),
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
                SizedBox(height: Get.size.height * 0.08),
                Container(
                    height: Get.size.height * 0.08,
                    width: Get.size.width * 0.3,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25.0),
                          bottomRight: Radius.circular(25.0))),
                 // color: Colors.grey,
                  child: Padding(
                    padding: EdgeInsets.only(left: 15 ,top: 4),
                      child: Text("Version : ${Constants.appVerId}"
                          " 16 June 022")),
                ),
                SizedBox(height: Get.size.height * 0.06),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    onPressed: () {
                      Utilities.showInToast("Logout", toastType: ToastType.SUCCESS);
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
