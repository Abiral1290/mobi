import 'dart:convert';

import 'package:get/get.dart';
import 'package:mobitrack_dv_flutter/controller/database_controller.dart';
import 'package:mobitrack_dv_flutter/model/products.dart';
import 'package:mobitrack_dv_flutter/utils/utilities.dart';

class ProductsController extends GetxController {
  List<Product> productList;
  List<Sales> salesList = [];
  DatabaseHelper databaseHelper = DatabaseHelper.instance;

  ProductsController() {
    getProductListFromAPI();
  }
  getProductListFromAPI() async {
    var conn = await Utilities.isInternetWorking();
    if (!conn) {
      fetchProducts().then((value) async {
        await databaseHelper.deleteAllProducts().then((res) {
          for (var data in value.response) {
            databaseHelper.insertProducts(data);
          }
        });
        update();
      });
    } else {
      databaseHelper.getAllProductsData().then((value) {
        if (value != null) {
          productList = value;
          update();
        } else {
          productList = [];
          update();
        }
      });
    }
  }

  // getProductList() {
  //   fetchProducts().then((value) {
  //     if (value.success) {
  //       productList = value.response;
  //       update();
  //     } else {
  //       Utilities.showInToast(value.message, toastType: ToastType.ERROR);
  //       productList = [];
  //       update();
  //     }
  //   });
  // }

  sellProducts(Sales sales) async {
    sellProductApi(sales).then((value) {
      Get.back();

      if (value.success) {
        salesList.add(value.response);
        Utilities.showInToast(value.message, toastType: ToastType.SUCCESS);
        Get.back();

        update();
      } else {
        Utilities.showInToast(value.message, toastType: ToastType.ERROR);
      }
    });
  }
}
