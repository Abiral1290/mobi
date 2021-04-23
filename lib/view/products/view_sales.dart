import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../controller/products_controller.dart';
import '../../utils/utilities.dart';

class ViewSalesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Unsynced sales")),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var conn = await Utilities.isInternetWorking();
          if (conn) {
            Get.find<ProductsController>().syncSalesData();
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
              itemCount: Get.find<ProductsController>().salesList.length,
              itemBuilder: (builder, index) {
                return ListTile(
                  title: Text(DateFormat().add_yMEd().format(DateTime.parse(
                      Get.find<ProductsController>().salesList[index].soldAt))),
                );
              });
        },
      ),
    );
  }
}