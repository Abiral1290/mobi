import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobitrack_dv_flutter/controller/products_controller.dart';
import 'package:mobitrack_dv_flutter/model/products.dart';
import 'package:mobitrack_dv_flutter/utils/constants.dart';
import 'package:mobitrack_dv_flutter/utils/utilities.dart';

class AddStockCount extends StatefulWidget {
  AddStockCount({@required this.stockType});

  String? stockType;

  @override
  State<AddStockCount> createState() => _AddStockCountState();
}

class _AddStockCountState extends State<AddStockCount> {


  var stock =Get.lazyPut(()=>ProductsController());
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
    var _stockController = TextEditingController();

    Get.find<ProductsController>().stockCountList.forEach((key, value) {
      if (key == products.id.toString()) {
        _stockController.text = value;
        return;
      }
    });
    return Card(
      elevation: 7.0,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Container(
              height: Get.size.height * 0.11,
              width: Get.size.width * 0.45,
              child: Column(
                children: [
                  Text(
                    "Name:",
                    style: titleStyle,
                  ),
                  Text(
                    products.name!,
                    overflow: TextOverflow.visible,
                    maxLines: null,
                    style: contentStyle,
                  ),
                ],
              ),
            ),
            Spacer(),
            Container(
              width: Get.size.width * 0.4,
              child: TextField(
                controller: _stockController,
                onChanged: (text) {
                  // if (_stockController.text.isNotEmpty)
                  Get.find<ProductsController>().addStockCount(
                      products.id.toString(), _stockController.text);
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
                  showDialog(
                      context: context,
                      builder: (context) {
                        return CupertinoAlertDialog(
                          title: Text("Please Wait"),
                          content: Column(
                            children: [
                              Text("Your transaction is being processed"),
                              CupertinoActivityIndicator(),
                            ],
                          ),
                        );
                      });
                  addStockCountApi(
                    jsonEncode(Get.find<ProductsController>().stockCountList),
                    Constants.selectmyRoute.toString(),
                    selectedStockType.value,
                  ).then((value) {
                    Get.back();
                    Utilities.showInToast(value.message!,
                        toastType: ToastType.SUCCESS);
                    if (value.success!) {
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
                          selectedStockType.value = s!;
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
                            thickness: 20.0,
                            hoverThickness: 10.0,
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
