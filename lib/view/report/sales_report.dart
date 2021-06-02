import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobitrack_dv_flutter/controller/products_controller.dart';
import 'package:intl/intl.dart';

class SalesReportPage extends StatefulWidget {
  SalesReportPage({Key key}) : super(key: key);

  @override
  _SalesReportPageState createState() => _SalesReportPageState();
}

class _SalesReportPageState extends State<SalesReportPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sales Report"),
      ),
      body: GetBuilder<ProductsController>(
        builder: (productController) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Text(
                        "Total data: ${Get.find<ProductsController>().formattedSalesList.length.toString()}"),
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
                          Get.find<ProductsController>()
                              .formatSalesDate(pickedDate);
                        }
                      },
                    ),
                  ],
                ),
              ),
              Text(DateFormat.yMMMMEEEEd()
                  .format(Get.find<ProductsController>().selectedDate)),
              Expanded(
                child:
                    Get.find<ProductsController>().formattedSalesList.isNotEmpty
                        ? ListView.builder(
                            itemCount: Get.find<ProductsController>()
                                .formattedSalesList
                                .length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(Get.find<ProductsController>()
                                    .formattedSalesList[index]
                                    .quantity
                                    .toString()),
                                subtitle: Text(Get.find<ProductsController>()
                                    .productList
                                    .where((element) =>
                                        element.id ==
                                        Get.find<ProductsController>()
                                            .formattedSalesList[index]
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
