import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mobitrack_dv_flutter/controller/outlets_controller.dart';

import '../../controller/products_controller.dart';
import '../../utils/utilities.dart';

class ViewSalesPage extends StatelessWidget {
  bool _lock = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Unsynced sales")),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (_lock) return;
          var conn = await Utilities.isInternetWorking();
          if (conn) {
            _lock = true;

            await Get.find<ProductsController>().syncSalesData();
            _lock = false;
          } else {
            Utilities.showInToast("No Connection to internet",
                toastType: ToastType.INFO);
          }
        },
        child: Text("Sync"),
      ),
      body: GetBuilder<ProductsController>(
        builder: (productsController) {
          return ListView.builder(
              itemCount: Get.find<ProductsController>().localSalesList.length,
              itemBuilder: (builder, index) {
                return ListTile(
                  title: Text(DateFormat().add_yMEd().format(DateTime.parse(
                      Get.find<ProductsController>()
                          .localSalesList[index]
                          .soldAt))),
                  subtitle: ExpansionTile(
                    title: Text(Get.find<OutletsController>()
                        .outletList
                        .where((element) =>
                            element.id ==
                            int.parse(Get.find<ProductsController>()
                                .localSalesList[index]
                                .outletId))
                        .toList()
                        .first
                        .name),
                    children: jsonDecode((Get.find<ProductsController>()
                            .localSalesList[index]
                            .orders))
                        .map<Widget>((product) {
                      print(product);
                      return ListTile(
                        title: Text(Get.find<ProductsController>()
                            .productList
                            .where((element) =>
                                element.id == int.parse(product["product_id"]))
                            .toList()
                            .first
                            .name),
                        subtitle: Text("Quantity: ${product["quantity"]}"),
                      );
                    }).toList(),
                  ),
                );
              });
        },
      ),
    );
  }
}
