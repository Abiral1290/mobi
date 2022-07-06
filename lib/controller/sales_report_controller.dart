import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:mobitrack_dv_flutter/controller/productbrand_controller.dart';
import 'package:mobitrack_dv_flutter/model/distributor.dart';
import 'package:mobitrack_dv_flutter/model/products.dart';
import 'package:mobitrack_dv_flutter/model/routes.dart';
import 'package:mobitrack_dv_flutter/model/sales_report.dart';
import 'package:mobitrack_dv_flutter/utils/utilities.dart';

import 'database_controller.dart';

class SalesReportController extends GetxController {
  List<SalesReport>? salesReportList = [];
  List<SalesReport>? formattedSalesReportList = [];

  List<Product>? formattedSales  = [];
  String? selectedData = DateTime.now().toString();

  SalesReportController() {
    fetchSalesReportFromAPI();
  }

  // sales data from API
  fetchSalesReportFromAPI() async {
    var conn = await Utilities.isInternetWorking();
    if (conn) {
      fetchSalesReport().then((value) {
        if (value.success!) {
          salesReportList = value.response;

          update();
          formatSalesDate(DateTime.now());
        } else {
          print("Error fetching sales");
        }
      });
    } else {}
  }
  getnae(){
    List unique = Get.find<ProductBrandController>().productList.toSet().where((element) => formattedSalesReportList!.contains(element)).toList();
    // List<Product> newlist = Get.find<ProductBrandController>().productList.where((element) => element.id ==formattedSalesReportList.map((e) => e.productId));
    // assert(listEquals(Get.find<ProductBrandController>().productList,formattedSalesReportList  ));
   // formattedSales.add(newlist.t);
  }
  // format sales list according to selected date from user
  formatSalesDate(DateTime datetime) {
    var formattedDate = DateTime(datetime.year, datetime.month, datetime.day);
    formattedSalesReportList = salesReportList!
        .where((element) =>
    DateTime(
        DateTime.parse(element.soldAt!).year,
        DateTime.parse(element.soldAt!).month,
        DateTime.parse(element.soldAt!).day) ==
        formattedDate)
        .toList();
    selectedData = datetime.toString();
    update();
  }

  // format sales list according to selected distributor from user
  formatSalesDistributor(Routees distributor) {
    formattedSalesReportList = salesReportList!
        .where((element) => element.route_id == distributor.id)
        .toList();
    selectedData = distributor.routename;
    update();
  }
}
