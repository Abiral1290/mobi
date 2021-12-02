import 'dart:math';

import 'package:get/get.dart';
import 'package:mobitrack_dv_flutter/controller/database_controller.dart';
import 'package:mobitrack_dv_flutter/controller/location_controller.dart';
import 'package:mobitrack_dv_flutter/model/location_model.dart';
import 'package:mobitrack_dv_flutter/model/products.dart';
import 'package:mobitrack_dv_flutter/utils/constants.dart';
import 'package:mobitrack_dv_flutter/utils/utilities.dart';

class ProductsController extends GetxController {
  List<Product> productList = [];
  List<Product> searchProductList;
  List<Sales> localSalesList = [];

  Map<String, String> stockCountList = {};

  DatabaseHelper databaseHelper = DatabaseHelper.instance;
  var location = Get.lazyPut(() => LocationController());
  var locationController = Get.find<LocationController>();

  ProductsController() {
    getProductListFromAPI();
    fetchLocalSales();
  }

  getProductListFromAPI() async {
    var conn = await Utilities.isInternetWorking();
    if (conn) {
      await fetchProducts().then((value) async {
        print(value.response);
        await databaseHelper.deleteAllProducts().then((res) {
          if (value.success) {
            for (var data in value.response) {
              databaseHelper.insertProducts(data);
            }
          } else {
            Utilities.showInToast(value.message, toastType: ToastType.ERROR);
          }
        });
      });
    }
    databaseHelper.getAllProductsData().then((value) {
      if (value != null) {
        productList = value;
        setStockCountData();
        // productList.forEach((element) {
        //   stockCountList[element.id.toString()] = "0";
        // });
        update();
      } else {
        productList = [];
        update();
      }
    });
  }

  setStockCountData() {
    productList.forEach((element) {
      stockCountList[element.id.toString()] = "0";
    });
    update();
  }

  addStockCount(String id, String count) {
    stockCountList[id] = count == "" ? "0" : count;
    // update();
  }

  searchProducts(String text) {
    if (productList != null && productList.isNotEmpty) {
      searchProductList = productList
          .where((element) =>
              element.name.toLowerCase().contains(text.toLowerCase()))
          .toList();
      update();
    }
  }

  addProductInList(String productId) {
    for (var product in productList) {
      if (productId == product.id.toString()) {
        product.selected = true;
        break;
      }
    }
    update();
  }

  removeAllProductFromList() {
    for (var product in productList) {
      product.selected = false;
    }
    update();
  }

  sellProducts(Sales sales) async {
    sellProductApi(sales).then((value) {
      if (value.success) {
        LocationModel model = LocationModel(
          id: Random().nextInt(100).toString(),
          latitude: sales.outletLatitude.toString(),
          longitude: sales.outletLongitude.toString(),
          date: DateTime.now().toString(),
          checkinoutId: Constants.checkInOut,
          outletId: sales.outletId,
        );

        locationController.postLocation(model, true);

        // postLocationApi(model, true).then((value) {
        //   if (value.success) {
        //     print("Location send success");
        //   } else {
        //     Get.find<LocationController>().addLocation(model, true);
        //   }
        // });

        Utilities.showInToast(value.message, toastType: ToastType.SUCCESS);
        Get.back();
      } else {
        Utilities.showInToast(value.message, toastType: ToastType.ERROR);
      }
    });
  }

  // local sales data
  fetchLocalSales() {
    databaseHelper.getAllSalesData().then((value) {
      if (value != null) {
        localSalesList = value;
      }
    });
  }

  storeSalesOffline(Sales sales) async {
    sales.id = DateTime.now().millisecondsSinceEpoch;
    databaseHelper.insertSales(sales).then((value) {
      if (value) {
        localSalesList.add(sales);
        update();
        Utilities.showInToast("Sales Stored locally",
            toastType: ToastType.SUCCESS);
        Get.back();
      } else {
        Utilities.showInToast("Error storing sales locally",
            toastType: ToastType.ERROR);
      }
    });
  }

  Future<bool> syncSalesData() async {
    Utilities.showInToast('Syncing Data', toastType: ToastType.INFO);
    for (var i = 0; i < localSalesList.length; i++) {
      var item = localSalesList[i];
      var res = await sellProductApi(item);
      if (res.success) {
        LocationModel model = LocationModel(
          id: Random().nextInt(100).toString(),
          latitude: item.outletLatitude.toString(),
          longitude: item.outletLongitude.toString(),
          date: DateTime.now().toString(),
          checkinoutId: Constants.checkInOut,
          outletId: item.outletId,
        );

        locationController.postLocation(model, true);

        // postLocationApi(model, true).then((value) {
        //   if (value.success) {
        //     print("Location send success");
        //   } else {
        //     Get.find<LocationController>().addLocation(model, true);
        //   }
        // });
        await databaseHelper.deleteSales(item).then((value) {
          if (value) {
            localSalesList.remove(item);
            update();
          }
        });
      }
    }
    Utilities.showInToast('Syncing Complete', toastType: ToastType.INFO);

    return true;
  }
}
