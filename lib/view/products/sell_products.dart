import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mobitrack_dv_flutter/controller/outlets_controller.dart';
import 'package:mobitrack_dv_flutter/controller/products_controller.dart';
import 'package:mobitrack_dv_flutter/model/outlet.dart';
import 'package:mobitrack_dv_flutter/model/products.dart';
import 'package:mobitrack_dv_flutter/utils/constants.dart';
import 'package:mobitrack_dv_flutter/utils/utilities.dart';

class SellProductPage extends StatelessWidget {
  final Outlet outlet;

  SellProductPage({@required this.outlet});

  TextEditingController outletTextController = TextEditingController();
  TextEditingController quantityTextController = TextEditingController();

  Sales sales = Sales();

  var selectedProductList = [].obs; //List<Map<String, String>>
  Map<String, String> selectedProducts = {};

  final TextStyle titleStyle = TextStyle(
    fontSize: 18,
  );
  final TextStyle contentStyle = TextStyle(
    fontSize: 17,
  );

  InputDecoration decoration(String labelText) {
    return InputDecoration(
      labelText: labelText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }

  void showQuantityBottomSheet(String batchId, String productId) {
    String addedQuantity;
    showModalBottomSheet(
        context: Get.context,
        shape: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        builder: (builder) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: decoration("Add Quantity"),
                  onChanged: (quantity) {
                    addedQuantity = quantity;
                  },
                  keyboardType: TextInputType.number,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (addedQuantity != null) {
                      selectedProductList.add(
                          {"product_id": productId, "quantity": addedQuantity});
                    } else {
                      Utilities.showInToast("Please add quantity");
                    }
                    // Utilities.showInToast(
                    //     "Quantity: $addedQuantity, ProductId: $productId, BatchId: $batchId");
                    Get.back();
                  },
                  child: Text("Add"),
                )
              ],
            ),
          );
        });
  }

  void showInfoBottomSheet() {
    showModalBottomSheet(
        shape: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        context: Get.context,
        enableDrag: true,
        builder: (builder) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "Selected Products",
                      style: TextStyle(
                          fontSize: 25.0, fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    IconButton(
                        icon: Icon(Icons.close), onPressed: () => Get.back()),
                  ],
                ),
                selectedProductList.isEmpty
                    ? Center(
                        child: Text("No Products"),
                      )
                    : Expanded(
                        child: ListView.builder(
                          itemCount: selectedProductList.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(Get.find<ProductsController>()
                                  .productList
                                  .where((element) =>
                                      element.id ==
                                      int.parse(selectedProductList[index]
                                          .values
                                          .elementAt(0)))
                                  .toList()
                                  .first
                                  .name),
                              subtitle: Text("Quantity: " +
                                  selectedProductList[index]
                                      .values
                                      .elementAt(1)),
                            );
                          },
                        ),
                      ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    Widget buildBatchTile(Batches batches, Product products) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text("Manufacture:", style: contentStyle),
                  Spacer(),
                  Text(
                    DateFormat.yMEd()
                        .format(DateTime.parse(batches.manufacturedAt)),
                    style: contentStyle,
                  ),
                ],
              ),
              Row(
                children: [
                  Text("Expire:", style: contentStyle),
                  Spacer(),
                  Text(
                    DateFormat.yMEd().format(DateTime.parse(batches.expiredAt)),
                    style: contentStyle,
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  showQuantityBottomSheet(
                      batches.id.toString(), batches.productId.toString());
                },
                child: Text("Sell"),
              ),
            ],
          ),
        ),
      );
    }

    Widget buildMainTile(Product products) {
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
              Row(
                children: [
                  Text("Unit:", style: titleStyle),
                  Spacer(),
                  Text(
                    products.unit,
                    style: contentStyle,
                  ),
                ],
              ),
              Row(
                children: [
                  Text("Price:", style: titleStyle),
                  Spacer(),
                  Text(
                    products.value.toString(),
                    style: contentStyle.copyWith(
                        color: Colors.red[900], fontSize: 20),
                  ),
                ],
              ),
              products.batches.isEmpty
                  ? ElevatedButton(
                      onPressed: () {
                        showQuantityBottomSheet(
                            null.toString(), products.id.toString());
                      },
                      child: Text("Sell"),
                    )
                  : ExpansionTile(
                      title: Text("Batches"),
                      children: products.batches.map((batch) {
                        return buildBatchTile(batch, products);
                      }).toList(),
                    ),
            ],
          ),
        ),
      );
    }

    Widget _buildListViewWidget(List<Product> productList) {
      return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: productList.length,
          itemBuilder: (context, index) {
            return buildMainTile(productList[index]);
          });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Sell"),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          if (selectedProductList.isEmpty) {
            Utilities.showInToast("Please add a product");
            return;
          }

          sales.orders = jsonEncode(selectedProductList);
          sales.distributorId = Constants.selectedDistributor.id.toString();
          sales.soldAt = DateTime.now().toString();
          sales.outletId = outlet.id.toString();

          var conn = await Utilities.isInternetWorking();
          if (conn) {
            Get.find<ProductsController>().sellProducts(sales);
          } else {
            Get.find<ProductsController>().storeSalesOffline(sales);
          }

          // Get.back();
        },
        label: Row(
          children: [
            Icon(Icons.check_circle),
            Text("Save"),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      outlet.name,
                      style: TextStyle(fontSize: 20.0),
                    ),
                    Obx(
                      () => IconButton(
                          icon: Icon(Icons.info),
                          onPressed: selectedProductList.isEmpty
                              ? null
                              : () {
                                  showInfoBottomSheet();
                                }),
                    ),
                  ],
                ),
                Text(
                  "Distributor: ${Constants.selectedDistributor.name}",
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(
                  height: Get.size.height * 0.03,
                ),
                InputDecorator(
                  decoration: decoration("Products"),
                  child: Column(
                    children: [
                      TextField(
                        decoration: decoration("Search Product"),
                        onChanged: (text) {
                          Get.find<ProductsController>().searchProducts(text);
                        },
                      ),
                      GetBuilder<ProductsController>(
                        // init: ProductsController(),
                        builder: (productsController) {
                          return Get.find<ProductsController>()
                                      .searchProductList !=
                                  null
                              ? Get.find<ProductsController>()
                                      .searchProductList
                                      .isNotEmpty
                                  ? _buildListViewWidget(
                                      Get.find<ProductsController>()
                                          .searchProductList)
                                  : Center(child: Text("No Products"))
                              : Get.find<ProductsController>().productList ==
                                      null
                                  ? Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : Get.find<ProductsController>()
                                          .productList
                                          .isEmpty
                                      ? Center(child: Text("No Products"))
                                      : _buildListViewWidget(
                                          Get.find<ProductsController>()
                                              .productList);
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Get.size.height * 0.02),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
