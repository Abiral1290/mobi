import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mobitrack_dv_flutter/controller/products_controller.dart';
import 'package:mobitrack_dv_flutter/model/outlet.dart';
import 'package:mobitrack_dv_flutter/model/products.dart';
import 'package:mobitrack_dv_flutter/utils/constants.dart';
import 'package:mobitrack_dv_flutter/utils/utilities.dart';

class SellProductPages extends StatelessWidget {
  final Outlet outlet;

  SellProductPages({@required this.outlet});

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

  String validateDiscount(int value) {
    if (!(value >= 0) && !(value <= 100)) {
      return "Discount should be less than or equal to 100%";
    }
    return null;
  }

  void showQuantityBottomSheet(String batchId, String productId) {
    String addedQuantity;
    String discountPercent = "0";
    Get.bottomSheet(
      Container(
          child: Padding(
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
                SizedBox(height: Get.size.height * 0.01),
                TextField(
                  controller: TextEditingController()..text = '0',
                  decoration: InputDecoration(
                    labelText: "Discount",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    suffixText: "%",
                    suffixStyle: TextStyle(fontSize: 20.0),
                  ),
                  onChanged: (discount) {
                    discountPercent = discount;
                  },
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (addedQuantity != null && discountPercent != null) {
                      selectedProductList.add({
                        "product_id": productId,
                        "batch_id": batchId,
                        "quantity": addedQuantity,
                        "discount": discountPercent
                      });
                      Get.find<ProductsController>().addProductInList(productId);
                    } else {
                      Utilities.showInToast("Please add quantity");
                    }
                    Get.back();
                  },
                  child: Text("Add"),
                )
              ],
            ),
          )),
      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
      backgroundColor: Colors.white,
      enableDrag: true,
    );
  }

  void showInfoBottomSheet() {
    Get.bottomSheet(
      Container(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Selected Products",
                    style:
                    TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
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
                  : Obx(
                    () => Expanded(
                  child: ListView.builder(
                    itemCount: selectedProductList.length,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                selectedProductList
                                    .remove(selectedProductList[index]);
                              },
                              icon: Icon(Icons.delete)),
                          Expanded(
                            child: Text(
                              Get.find<ProductsController>()
                                  .productList
                                  .where((element) =>
                              element.id ==
                                  int.parse(selectedProductList[index]
                                      .values
                                      .elementAt(0)))
                                  .toList()
                                  .first
                                  .name,
                              overflow: TextOverflow.visible,
                            ),
                          ),
                          Column(
                            children: [
                              Text(selectedProductList[index]
                                  .values
                                  .elementAt(2)),
                              Text(selectedProductList[index]
                                  .values
                                  .elementAt(3) +
                                  "%"),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      enableDrag: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
    );
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
        color: products.selected ? Colors.grey : Colors.white,
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
                  showQuantityBottomSheet(null, products.id.toString());
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

    return WillPopScope(
      onWillPop: () async {
        Get.find<ProductsController>().removeAllProductFromList();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Sell"),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            if (selectedProductList.isEmpty) {
              Utilities.showInToast("Please add a product",
                  toastType: ToastType.ERROR);
              return;
            }

            sales.orders = jsonEncode(selectedProductList);
            sales..route= Constants.selectedRoute.toString();
            sales.soldAt = DateTime.now().toString();
            sales.outletId = outlet.id.toString();
            sales.latitude= outlet.latitude.toString();
            sales.longitude = outlet.longitude.toString();

            var conn = await Utilities.isInternetWorking();
            if (conn) {
              Get.find<ProductsController>().sellProducts(sales);
            } else {
              Get.find<ProductsController>().storeSalesOffline(sales);
            }

            Get.find<ProductsController>().removeAllProductFromList();

            // Get.back();
          },
          label: Row(
            children: [
              Icon(Icons.check_circle),
              Text("Save"),
            ],
          ),
        ),
        body: Scrollbar(
          isAlwaysShown: true,
          interactive: true,
          thickness: 6.0,
          child: SingleChildScrollView(
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
                              Get.find<ProductsController>()
                                  .searchProducts(text);
                            },
                          ),
                          GetBuilder<ProductsController>(
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
                                  : Get.find<ProductsController>()
                                  .productList ==
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
        ),
      ),
    );
  }
}
