import 'package:get/get.dart';
import 'package:mobitrack_dv_flutter/model/products.dart';
import 'package:mobitrack_dv_flutter/utils/utilities.dart';

class ProductsController extends GetxController {
  List<Products> productList;
  List<Sales> salesList = [];

  ProductsController() {
    getProductList();
  }

  getProductList() {
    fetchProducts().then((value) {
      productList = value;
      update();
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
