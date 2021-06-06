import 'package:get/get.dart';
import 'package:mobitrack_dv_flutter/model/sales_report.dart';
import 'package:mobitrack_dv_flutter/utils/utilities.dart';

class SalesReportController extends GetxController {
  List<SalesReport> salesReportList = [];
  List<SalesReport> formattedSalesReportList = [];
  DateTime selectedDate = DateTime.now();

  SalesReportController() {
    fetchSalesReportFromAPI();
  }

  // sales data from API
  fetchSalesReportFromAPI() async {
    var conn = await Utilities.isInternetWorking();
    if (conn) {
      fetchSalesReport().then((value) {
        if (value.success) {
          salesReportList = value.response;
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
    formattedSalesReportList = salesReportList
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
}
