import 'package:get/get.dart';
import 'package:mobitrack_dv_flutter/controller/database_controller.dart';
import 'package:mobitrack_dv_flutter/model/products.dart';
import 'package:mobitrack_dv_flutter/utils/utilities.dart';

class ProductsController extends GetxController {
  List<Product> productList;
  List<Sales> localSalesList = [];
  List<Sales> salesList = [];
  List<Sales> formattedSalesList = [];
  DatabaseHelper databaseHelper = DatabaseHelper.instance;
  DateTime selectedDate = DateTime.now();

  ProductsController() {
    getProductListFromAPI();
    fetchLocalSales();
    fetchSalesFromAPI();
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

  // sales data from API
  fetchSalesFromAPI() async {
    var conn = await Utilities.isInternetWorking();
    if (conn) {
      fetchSales().then((value) {
        if (value.success) {
          salesList = value.response;
          update();
          formatSalesDate(DateTime.now());
        } else {
          print("Error fetching sales");
        }
      });
    } else {}
  }

  // format sales list according to selected date from user
  formatSalesDate(DateTime datetime) {
    var formattedDate = DateTime(datetime.year, datetime.month, datetime.day);
    formattedSalesList = salesList
        .where((element) =>
            DateTime(
                DateTime.parse(element.soldAt).year,
                DateTime.parse(element.soldAt).month,
                DateTime.parse(element.soldAt).day) ==
            formattedDate)
        .toList();
    selectedDate = datetime;
    update();
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
