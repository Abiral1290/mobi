import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobitrack_dv_flutter/controller/distributor_controller.dart';
import 'package:mobitrack_dv_flutter/controller/products_controller.dart';
import 'package:intl/intl.dart';
import 'package:mobitrack_dv_flutter/controller/sales_report_controller.dart';
import 'package:mobitrack_dv_flutter/model/distributor.dart';
import 'package:mobitrack_dv_flutter/utils/constants.dart';
import 'package:mobitrack_dv_flutter/utils/pdf_api.dart';
import 'package:mobitrack_dv_flutter/utils/utilities.dart';
import 'package:mobitrack_dv_flutter/view/report/sales_report_pdf_generator.dart';
import 'package:share_plus/share_plus.dart';

class SalesReportPage extends StatefulWidget {
  SalesReportPage({Key key}) : super(key: key);

  @override
  _SalesReportPageState createState() => _SalesReportPageState();
}

class _SalesReportPageState extends State<SalesReportPage> {
  var salesReportController = Get.lazyPut(() => SalesReportController());
  var distributorController = Get.lazyPut(() => DistributorController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sales Report"),
        actions: [
          MaterialButton(
            onPressed: () async {
              print(Get.find<SalesReportController>().formattedSalesReportList);

              final pdfFile = await PdfParagraphApi.generate(
                  Get.find<SalesReportController>().formattedSalesReportList);
              Get.bottomSheet(
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: ButtonBar(
                    alignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Get.back();
                          PdfApi.openFile(pdfFile);
                        },
                        child: Text("Open"),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          Get.back();
                          await Share.shareFiles(
                            [pdfFile.path],
                            text: "Sales Report",
                          );
                        },
                        child: Text("Share"),
                      ),
                    ],
                  ),
                ),
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              );
            },
            child: Icon(Icons.picture_as_pdf),
            color: Colors.red[900],
            elevation: 10.0,
          )
        ],
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
                      icon: Icon(
                        Icons.calendar_today_outlined,
                        semanticLabel: "Filter by Date",
                      ),
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
                      tooltip: "Filter by date",
                    ),
                    PopupMenuButton<Distributor>(
                      elevation: 3.2,
                      onCanceled: () {
                        print('You have not choosed anything');
                      },
                      tooltip: 'Filter by distributor',
                      onSelected: (distributor) {
                        Get.find<SalesReportController>()
                            .formatSalesDistributor(distributor);
                      },
                      icon: Icon(Icons.person),
                      itemBuilder: (BuildContext context) {
                        return Get.find<DistributorController>()
                            .distributorList
                            .map((distributor) {
                          return PopupMenuItem<Distributor>(
                            textStyle:
                                TextStyle(fontSize: 16.0, color: Colors.black),
                            value: distributor,
                            child: Text(distributor.name),
                          );
                        }).toList();
                      },
                    ),
                    // GetBuilder<DistributorController>(
                    //   builder: (builder) {
                    //     return PopupMenuButton<Distributor>(
                    //       elevation: 3.2,
                    //       onCanceled: () {
                    //         print('You have not choosed anything');
                    //       },
                    //       tooltip: 'Filter by distributor',
                    //       onSelected: (distributor) {
                    //         Get.find<SalesReportController>()
                    //             .formatSalesDistributor(distributor);
                    //       },
                    //       icon: Icon(Icons.person),
                    //       itemBuilder: (BuildContext context) {
                    //         return Get.find<DistributorController>()
                    //             .distributorList
                    //             .map((distributor) {
                    //           return PopupMenuItem<Distributor>(
                    //             textStyle: TextStyle(
                    //                 fontSize: 16.0, color: Colors.black),
                    //             value: distributor,
                    //             child: Text(distributor.name),
                    //           );
                    //         }).toList();
                    //       },
                    //     );
                    //   },
                    // ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  Get.find<SalesReportController>().selectedData,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Text(DateFormat.yMMMMEEEEd()
              //     .format(Get.find<SalesReportController>().selectedData)),
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
                            subtitle: Row(
                              children: [
                                Text(Get.find<SalesReportController>()
                                    .formattedSalesReportList[index]
                                    .quantity
                                    .toString()),
                                Spacer(),
                                Get.find<SalesReportController>()
                                            .formattedSalesReportList[index]
                                            .discount ==
                                        null
                                    ? Text("Discount: 0 %")
                                    : Text(
                                        "Discount: ${Get.find<SalesReportController>().formattedSalesReportList[index].discount} %"),
                              ],
                            ),
                            title: Text(Get.find<ProductsController>()
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
