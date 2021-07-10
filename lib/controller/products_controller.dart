import 'package:get/get.dart';
import 'package:mobitrack_dv_flutter/controller/database_controller.dart';
import 'package:mobitrack_dv_flutter/model/products.dart';
import 'package:mobitrack_dv_flutter/utils/utilities.dart';

class ProductsController extends GetxController {
  List<Product> productList = [];
  List<Product> searchProductList;
  List<Sales> localSalesList = [];
  DatabaseHelper databaseHelper = DatabaseHelper.instance;

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
        update();
      } else {
        productList = [];
        update();
      }
    });
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

  sellProducts(Sales sales) async {
    sellProductApi(sales).then((value) {
      if (value.success) {
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
