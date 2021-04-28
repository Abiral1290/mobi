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
    fetchsales();
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

  sellProducts(Sales sales) async {
    sellProductApi(sales).then((value) {
      if (value.success) {
        Utilities.showInToast(value.message, toastType: ToastType.SUCCESS);
      } else {
        Utilities.showInToast(value.message, toastType: ToastType.ERROR);
      }
    });
  }

  fetchsales() {
    databaseHelper.getAllSalesData().then((value) {
      if (value != null) {
        salesList = value;
      }
    });
  }

  storeSalesOffline(Sales sales) async {
    sales.id = DateTime.now().millisecondsSinceEpoch;
    databaseHelper.insertSales(sales).then((value) {
      if (value) {
        salesList.add(sales);
        update();
        Utilities.showInToast("Sales Stored locally",
            toastType: ToastType.SUCCESS);
      } else {
        Utilities.showInToast("Error storing sales locally",
            toastType: ToastType.ERROR);
      }
    });
  }

  Future<bool> syncSalesData() async {
    Utilities.showInToast('Syncing Data', toastType: ToastType.INFO);
    for (var i = 0; i < salesList.length; i++) {
      var item = salesList[i];
      var res = await sellProductApi(item);
      if (res.success) {
        await databaseHelper.deleteSales(item).then((value) {
          if (value) {
            salesList.remove(item);
            update();
          }
        });
      }
    }
    Utilities.showInToast('Syncing Complete', toastType: ToastType.INFO);

    return true;
  }
}
