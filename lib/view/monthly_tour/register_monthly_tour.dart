import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mobitrack_dv_flutter/model/monthly_tour.dart';
import 'package:mobitrack_dv_flutter/utils/utilities.dart';
import 'package:mobitrack_dv_flutter/view/monthly_tour/individual_day_form.dart';

class RegisterMonthlyTourPage extends StatefulWidget {
  @override
  _RegisterMonthlyTourPageState createState() =>
      _RegisterMonthlyTourPageState();
}

class _RegisterMonthlyTourPageState extends State<RegisterMonthlyTourPage> {
  var today = DateTime.now();
  var currentMonthInString = "".obs;
  var currentMonthInInt = 0.obs;
  var totalNumberOfDays = 0.obs;

  // List<Map<String, String>> monthlyTourList = [];
  var monthlyTourList = [].obs;

  var selectedMap = {}.obs;

  var isSubmitable = true.obs;

  @override
  void initState() {
    currentMonthInString.value = DateFormat().add_MMMM().format(today);
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
    for (var i = 0; i < totalNumberOfDays.value; i++) {
      selectedMap[i + 1] = false;
    }
    print("First Day " + DateTime.daysPerWeek.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(currentMonthInString.value)),
        actions: [
          // Obx(() => Center(child: Text(totalNumberOfDays.value.toString()))),
          Obx(
            () => TextButton(
              onPressed: isSubmitable.value && monthlyTourList.isNotEmpty
                  ? () {
                      isSubmitable.value = false;
                      // if (monthlyTourList.isNotEmpty &&
                      //     monthlyTourList.length == totalNumberOfDays.value) {
                      var data = jsonEncode(monthlyTourList);
                      MonthlyTourApiData monthlyTourApiData =
                          MonthlyTourApiData();
                      monthlyTourApiData.data = data;
                      monthlyTourApiData.year = today.year.toString();
                      monthlyTourApiData.month =
                          currentMonthInString.value.toString();
                      monthlyTourApiData.deviceTime = DateTime.now().toString();
                      postMonthlyTours(monthlyTourApiData).then((value) {
                        isSubmitable.value = true;
                        if (value.success) {
                          Utilities.showInToast(
                              "Successfully posted monthly data",
                              toastType: ToastType.SUCCESS);
                          Get.back();
                        } else {
                          Utilities.showInToast(value.message,
                              toastType: ToastType.ERROR);
                        }
                      });
                      print(data);
                      // } else {
                      //   Utilities.showInToast("Data is insuficient",
                      //       toastType: ToastType.ERROR);
                      // }
                    }
                  : null,
              child: Text(
                "Submit",
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
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
            return ListTile(
              leading: Text((index + 1).toString()),
              title: Text(getDayInString(today.year, today.month, index + 1)),
              trailing: Obx(() => Icon(
                    Icons.check_circle,
                    color: selectedMap[index + 1] ? Colors.green : Colors.grey,
                  )),
              onTap: () async {
                var data = await Get.to(
                  () => IndividualDayFormPage(
                    date: (index + 1).toString(),
                    day: getDayInString(today.year, today.month, index + 1),
                  ),
                );
                if (data != null) {
                  selectedMap[index + 1] = true;
                  monthlyTourList.add(data);
                }
                print(monthlyTourList);
              },
            );
          },
        ),
      ),
    );
  }
}
