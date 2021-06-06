import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobitrack_dv_flutter/controller/products_controller.dart';
import 'package:intl/intl.dart';
import 'package:mobitrack_dv_flutter/controller/sales_report_controller.dart';

class SalesReportPage extends StatefulWidget {
  SalesReportPage({Key key}) : super(key: key);

  @override
  _SalesReportPageState createState() => _SalesReportPageState();
}

class _SalesReportPageState extends State<SalesReportPage> {
  var taskController = Get.lazyPut(() => SalesReportController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sales Report"),
      ),
      body: GetBuilder<SalesReportController>(
        // initState: Get.find<SalesReportController>().fetchSalesReportFromAPI(),
        builder: (salesReportController) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Text(
                        "Total data: ${Get.find<SalesReportController>().formattedSalesReportList.length.toString()}"),
                    Spacer(),
                    IconButton(
                      icon: Icon(Icons.calendar_today_outlined),
                      onPressed: () async {
                        var pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1990, 1, 1),
                            lastDate: DateTime.now().add(Duration(days: 1)));
                        if (pickedDate != null) {
                          Get.find<SalesReportController>()
                              .formatSalesDate(pickedDate);
                        }
                      },
                    ),
                  ],
                ),
              ),
              Text(DateFormat.yMMMMEEEEd()
                  .format(Get.find<SalesReportController>().selectedDate)),
              Expanded(
                child: Get.find<SalesReportController>()
                        .formattedSalesReportList
                        .isNotEmpty
                    ? ListView.builder(
                        itemCount: Get.find<SalesReportController>()
                            .formattedSalesReportList
                            .length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(Get.find<SalesReportController>()
                                .formattedSalesReportList[index]
                                .quantity
                                .toString()),
                            subtitle: Text(Get.find<ProductsController>()
                                .productList
                                .where((element) =>
                                    element.id ==
                                    Get.find<SalesReportController>()
                                        .formattedSalesReportList[index]
                                        .productId)
                                .toList()
                                .first
                                .name),
                          );
                        })
                    : Center(
                        child: Text("No Data!!"),
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
