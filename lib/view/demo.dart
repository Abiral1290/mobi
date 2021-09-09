import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:mobitrack_dv_flutter/model/monthly_tour.dart';
import 'package:mobitrack_dv_flutter/utils/utilities.dart';

void main() {
  runApp(MonthlyTourPage());
}

class MonthlyTourPage extends StatefulWidget {
  @override
  _MonthlyTourPageState createState() => _MonthlyTourPageState();
}

class _MonthlyTourPageState extends State<MonthlyTourPage> {
  var today = DateTime.now();
  var currentMonthInSring = "".obs;
  var currentMonthInInt = 0.obs;
  var totalNumberOfDays = 0.obs;

  List<Map<String, String>> monthlyTourList = [];

  @override
  void initState() {
    currentMonthInSring.value = DateFormat().add_MMMM().format(today);
    currentMonthInInt.value = today.month;
    getNumberOfDays();
    super.initState();
  }

  String getDayInString(int year, int month, int day) {
    return DateFormat().add_EEEE().format(DateTime(year, month, day));
  }

  void getNumberOfDays() {
    final lastDay = DateTime(today.year, today.month + 1, 0);
    totalNumberOfDays.value = lastDay.day;
    print("First Day " + DateTime.daysPerWeek.toString());
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Obx(() => Text(currentMonthInSring.value)),
          actions: [
            // Obx(() => Center(child: Text(totalNumberOfDays.value.toString()))),
            TextButton(
                onPressed: () {
                  if (monthlyTourList.isNotEmpty) {
                    var data = jsonEncode(monthlyTourList);
                    MonthlyTourApiData monthlyTourApiData =
                        MonthlyTourApiData();
                    monthlyTourApiData.data = data;
                    monthlyTourApiData.year = today.year.toString();
                    monthlyTourApiData.month =
                        currentMonthInInt.value.toString();
                    monthlyTourApiData.deviceTime = DateTime.now().toString();
                    postMonthlyTours(monthlyTourApiData).then((value) {
                      if (value.success) {
                        Utilities.showInToast(
                            "Successfully posted monthly data",
                            toastType: ToastType.SUCCESS);
                      } else {
                        Utilities.showInToast(value.message,
                            toastType: ToastType.ERROR);
                      }
                    });
                    print(data);
                  }
                },
                child: Text(
                  "Submit",
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
        body: Scrollbar(
          interactive: true,
          thickness: 10,
          isAlwaysShown: true,
          radius: Radius.circular(20),
          child: ListView.builder(
            itemCount: totalNumberOfDays.value,
            itemBuilder: (context, index) {
              var filled = false.obs;

              return ListTile(
                leading: Text((index + 1).toString()),
                title: Text(getDayInString(today.year, today.month, index + 1)),
                trailing: Obx(() => Icon(
                      Icons.check_circle,
                      color: filled.value ? Colors.green : Colors.grey,
                    )),
                onTap: () async {
                  var data = await Get.to(
                    () => MonthlyTourFormPage(
                      date: (index + 1).toString(),
                      day: getDayInString(today.year, today.month, index + 1),
                    ),
                  );
                  if (data != null) {
                    filled.value = true;
                    monthlyTourList.add(data);
                  }
                  print(monthlyTourList);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class MonthlyTourFormPage extends StatelessWidget {
  MonthlyTourFormPage({@required this.day, @required this.date});

  String date;
  String day;

  TextEditingController townController = TextEditingController();
  TextEditingController routeController = TextEditingController();
  TextEditingController nightHaltController = TextEditingController();
  TextEditingController contactAddressController = TextEditingController();
  TextEditingController stocklistPhoneController = TextEditingController();
  TextEditingController hotelPhoneController = TextEditingController();

  MonthlyTour monthlyTour = MonthlyTour();
  Map<String, String> tourMap = {};

  InputDecoration _decoration(String label) => InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.black),
        border: InputBorder.none,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueAccent),
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueAccent),
          borderRadius: BorderRadius.circular(12.0),
        ),
      );

  bool validate() {
    return townController.text.isNotEmpty &&
            routeController.text.isNotEmpty &&
            nightHaltController.text.isNotEmpty &&
            contactAddressController.text.isNotEmpty &&
            stocklistPhoneController.text.isNotEmpty &&
            hotelPhoneController.text.isNotEmpty
        ? true
        : false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(day),
          leading: IconButton(
            onPressed: () {
              Get.back(result: null);
            },
            icon: Icon(Icons.close),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                TextField(
                  controller: townController,
                  decoration: _decoration("TOWN/STOCKLIST"),
                ),
                SizedBox(
                  height: Get.size.height * 0.02,
                ),
                TextField(
                  controller: routeController,
                  decoration: _decoration("ROUTE/MARKET"),
                ),
                SizedBox(
                  height: Get.size.height * 0.02,
                ),
                TextField(
                  controller: nightHaltController,
                  decoration: _decoration("NIGHT HALT"),
                ),
                SizedBox(
                  height: Get.size.height * 0.02,
                ),
                TextField(
                  controller: contactAddressController,
                  decoration: _decoration("CONTACT ADDRESS"),
                ),
                SizedBox(
                  height: Get.size.height * 0.02,
                ),
                TextField(
                  controller: stocklistPhoneController,
                  decoration: _decoration("STOCKLIST PHONE NO."),
                ),
                SizedBox(
                  height: Get.size.height * 0.02,
                ),
                TextField(
                  controller: hotelPhoneController,
                  decoration: _decoration("HOTEL PHONE NO."),
                ),
                SizedBox(
                  height: Get.size.height * 0.02,
                ),
                Text(
                  "* All field are required",
                  style: TextStyle(
                    color: Colors.red,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(
                  height: Get.size.height * 0.02,
                ),
                ElevatedButton(
                    onPressed: () {
                      if (validate()) {
                        tourMap["date"] = date;
                        tourMap["day"] = day;
                        tourMap["town"] = townController.text;
                        tourMap["route"] = routeController.text;
                        tourMap["nightHalt"] = nightHaltController.text;
                        tourMap["contactAddress"] =
                            contactAddressController.text;
                        tourMap["stocklistPhone"] =
                            stocklistPhoneController.text;
                        tourMap["hotelPhone"] = hotelPhoneController.text;

                        monthlyTour.date = date;
                        monthlyTour.day = day;
                        monthlyTour.town = townController.text;
                        monthlyTour.route = routeController.text;
                        monthlyTour.nightHalt = nightHaltController.text;
                        monthlyTour.contactAddress =
                            contactAddressController.text;
                        monthlyTour.stocklistPhone =
                            stocklistPhoneController.text;
                        monthlyTour.hotelPhone = hotelPhoneController.text;

                        Get.back(result: tourMap);
                      } else {
                        Utilities.showInToast(
                            "Please make sure to fill all required field",
                            toastType: ToastType.ERROR);
                      }
                    },
                    child: Text("Submit"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
