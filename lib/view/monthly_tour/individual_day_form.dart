import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mobitrack_dv_flutter/model/monthly_tour.dart';
import 'package:mobitrack_dv_flutter/utils/utilities.dart';

class IndividualDayFormPage extends StatelessWidget {
  IndividualDayFormPage({@required this.day, @required this.date});

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
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                ),
                SizedBox(
                  height: Get.size.height * 0.02,
                ),
                TextField(
                  controller: stocklistPhoneController,
                  decoration: _decoration("STOCKLIST PHONE NO."),
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                ),
                SizedBox(
                  height: Get.size.height * 0.02,
                ),
                TextField(
                  controller: hotelPhoneController,
                  decoration: _decoration("HOTEL PHONE NO."),
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
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
