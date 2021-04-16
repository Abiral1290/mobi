import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobitrack_dv_flutter/controller/distributor_controller.dart';
import 'package:mobitrack_dv_flutter/controller/preference_controller.dart';
import 'package:mobitrack_dv_flutter/model/distributor.dart';
import 'package:mobitrack_dv_flutter/utils/constants.dart';
import 'package:mobitrack_dv_flutter/utils/utilities.dart';

class ViewDistributorPage extends StatelessWidget {
  var _selectedIndex = 0.obs;

  var selectedDistributor = Distributor()
      .obs; // if user tried to select next time then constants.selectedDistributor is not null so validate using this variable

  @override
  Widget build(BuildContext context) {
    Widget listSegment(List<Distributor> distList) {
      return ListView.builder(
        itemCount: distList.length,
        itemBuilder: (context, index) {
          return Obx(
            () => ListTile(
              onTap: () {
                Constants.selectedDistributor = distList[index];
                selectedDistributor.value = distList[index];
                _selectedIndex.value = index;
              },
              selected: index == _selectedIndex.value,
              title: Text(
                distList[index].name,
              ),
            ),
          );
        },
      );
    }

    Widget distributorList() {
      return Expanded(
        child: GetBuilder<DistributorController>(
          init: DistributorController(),
          builder: (distributorController) {
            return distributorController.searchedDistributorList.isNotEmpty
                ? listSegment(distributorController.searchedDistributorList)
                : distributorController.distributorList != null
                    ? distributorController.distributorList.isEmpty
                        ? Center(child: Text("No Distributors"))
                        : listSegment(distributorController.distributorList)
                    : Center(
                        child: CircularProgressIndicator(),
                      );
          },
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Distributors"),
        actions: [
          TextButton(
            onPressed: () {
              if (Constants.selectedDistributor != null &&
                  selectedDistributor.value.name != null) {
                print(Constants.selectedDistributor);
                Get.find<PreferenceController>()
                    .setDistributor(jsonEncode(Constants.selectedDistributor));
                Get.back();
              } else {
                Utilities.showInToast("Please select a distributor",
                    toastType: ToastType.ERROR);
              }
            },
            child: Text(
              "Save",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.red, //this has no effect
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                hintText: "Search Distributor...",
              ),
              onChanged: (text) {
                Get.find<DistributorController>().searchDistributor(text);
              },
            ),
            distributorList(),
          ],
        ),
      ),
    );
  }
}
