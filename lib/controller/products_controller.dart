import 'package:get/get.dart';
import 'package:mobitrack_dv_flutter/model/products.dart';
import 'package:mobitrack_dv_flutter/utils/utilities.dart';

class ProductsController extends GetxController {
  List<Products> productList;
  List<Sales> salesList = [];

  ProductsController() {
    getProductList();
  }
  // getProductListFromAPI() {
  //   fetchProducts().then((value) {
  //     if (value.success) {
  //       //TODO: remove this 3 lines and uncomment below lines
  //       var test = jsonEncode(value.response.first.batches);
  //       print(test);
  //       databaseHelper.deleteAllProducts().then((res) {
  //         // if (res) {
  //         //   for (var data in value.response) {
  //         //     databaseHelper.insertProducts(data);
  //         //   }
  //         // }
  //       });

  //       // productList = value.response;
  //       // update();
  //     } else {
  //       Utilities.showInToast(value.message, toastType: ToastType.ERROR);
  //       // productList = [];
  //       // update();
  //     }

  //     databaseHelper.getAllProductsData().then((value) {
  //       if (value != null) {
  //         productList = value;
  //         update();
  //       } else {
  //         productList = [];
  //         update();
  //       }
  //     });
  //   });
  // }

  getProductList() {
    fetchProducts().then((value) {
      if (value.success) {
        productList = value.response;
        update();
      } else {
        Utilities.showInToast(value.message, toastType: ToastType.ERROR);
        productList = [];
        update();
      }
    });
  }

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
