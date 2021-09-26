import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobitrack_dv_flutter/controller/products_controller.dart';
import 'package:mobitrack_dv_flutter/model/products.dart';
import 'package:mobitrack_dv_flutter/utils/constants.dart';
import 'package:mobitrack_dv_flutter/utils/utilities.dart';

class AddStockCount extends StatefulWidget {
  AddStockCount({@required this.stockType});

  String stockType;

  @override
  State<AddStockCount> createState() => _AddStockCountState();
}

class _AddStockCountState extends State<AddStockCount> {
  final TextStyle titleStyle = TextStyle(
    fontSize: 18,
  );

  final TextStyle contentStyle = TextStyle(
    fontSize: 17,
  );

  var selectedStockType = "Opening".obs;

  @override
  void initState() {
    super.initState();
    Get.find<ProductsController>().setStockCountData();
    if (widget.stockType == "Opening") {
      selectedStockType.value = "Select"; //if select then show dropdown
    } else if (widget.stockType == "Purchases") {
      selectedStockType.value = "Closing";
    } else {
      selectedStockType.value = "Opening";
    }
  }

  Widget buildMainTile(Product products) {
    int count = 0;

    TextEditingController _stockController = TextEditingController();

    Get.find<ProductsController>().stockCountList.forEach((key, value) {
      if (key == products.id.toString()) {
        count = int.parse(value);
        return;
      }
    });
    return Card(
      elevation: 7.0,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "Name:",
                  style: titleStyle,
                ),
                Spacer(),
                Expanded(
                  child: Text(
                    products.name,
                    overflow: TextOverflow.visible,
                    maxLines: null,
                    style: contentStyle,
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: Text("Add Count"),
              children: [
                TextField(
                  controller: _stockController..text = count.toString(),
                  onChanged: (text) {
                    print("${products.id} : $text");
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    filled: true,
                    label: Text("Quantity"),
                  ),
                ),
                OutlinedButton(
                  onPressed: () {
                    if (_stockController.text.isEmpty)
                      _stockController.text = "0";
                    Get.find<ProductsController>().addStockCount(
                        products.id.toString(), _stockController.text);
                  },
                  child: Text("Save"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Stock Count"),
        actions: [
          TextButton(
            onPressed: () async {
              print(Get.find<ProductsController>().stockCountList);

              var conn = await Utilities.isInternetWorking();
              if (selectedStockType.value != "Select") {
                if (conn) {
                  addStockCountApi(
                    jsonEncode(Get.find<ProductsController>().stockCountList),
                    Constants.selectedDistributor.id.toString(),
                    selectedStockType.value,
                  ).then((value) {
                    Utilities.showInToast(value.message,
                        toastType: ToastType.SUCCESS);
                    if (value.success) {
                      Get.back();
                    }
                  });
                } else {
                  Utilities.showInToast(
                      "No internet Connection. Please try again",
                      toastType: ToastType.ERROR);
                }
              } else {
                Utilities.showInToast("Please select stock type",
                    toastType: ToastType.INFO);
              }
            },
            child: Text(
              "save",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Stock Type: ",
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
              selectedStockType.value == "Select"
                  ? Obx(
                      () => DropdownButton<String>(
                        hint: Text(selectedStockType.value),
                        items: ["Purchases", "Closing"].map((value) {
                          return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(color: Colors.black),
                              ));
                        }).toList(),
                        onChanged: (s) {
                          selectedStockType.value = s;
                        },
                      ),
                    )
                  : Text(
                      selectedStockType.value,
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
            ],
          ),
          SizedBox(
            height: Get.size.height * 0.03,
          ),
          Expanded(
            child: GetBuilder<ProductsController>(
              builder: (productsController) {
                return Get.find<ProductsController>().productList == null
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Get.find<ProductsController>().productList.isEmpty
                        ? Center(child: Text("No Products"))
                        : Scrollbar(
                            isAlwaysShown: true,
                            interactive: true,
                            thickness: 6.0,
                            child: ListView.builder(
                              itemCount: Get.find<ProductsController>()
                                  .productList
                                  .length,
                              itemBuilder: (context, index) {
                                return buildMainTile(
                                    Get.find<ProductsController>()
                                        .productList[index]);
                              },
                            ),
                          );
              },
            ),
          ),
        ],
      ),
    );
  }
}
