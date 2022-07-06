// // // // import 'package:flutter/material.dart';
// // // // import 'package:get/get.dart';
// // // // import 'package:mobitrack_dv_flutter/controller/distributor_controller.dart';
// // // // import 'package:mobitrack_dv_flutter/controller/outlets_controller.dart';
// // // // import 'package:mobitrack_dv_flutter/controller/products_controller.dart';
// // // // import 'package:mobitrack_dv_flutter/controller/sales_report_controller.dart';
// // // // import 'package:mobitrack_dv_flutter/model/distributor.dart';
// // // // import 'package:mobitrack_dv_flutter/utils/pdf_api.dart';
// // // // import 'package:mobitrack_dv_flutter/view/report/sales_report_pdf_generator.dart';
// // // // import 'package:share_plus/share_plus.dart';
// // // //
// // // // class SalesReportPage extends StatefulWidget {
// // // //   SalesReportPage({Key key}) : super(key: key);
// // // //
// // // //   @override
// // // //   _SalesReportPageState createState() => _SalesReportPageState();
// // // // }
// // // //
// // // // class _SalesReportPageState extends State<SalesReportPage> {
// // // //   var salesReportController = Get.lazyPut(() => SalesReportController());
// // // //   var distributorController = Get.lazyPut(() => DistributorController());
// // // //   var outletController = Get.lazyPut(() => OutletsController());
// // // //  // var productController = Get.lazyPut(() => ProductsController());
// // // //   final profileController = Get.put(ProductsController());
// // // //
// // // //   Distributor selectedDistributor;
// // // //
// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return Scaffold(
// // // //       appBar: AppBar(
// // // //         title: Text("Sales Report"),
// // // //         actions: [
// // // //           MaterialButton(
// // // //             onPressed: () async {
// // // //               print(Get.find<SalesReportController>().formattedSalesReportList);
// // // //
// // // //               final pdfFile = await PdfParagraphApi.generate(
// // // //                   Get.find<SalesReportController>().formattedSalesReportList,
// // // //                   distributor: selectedDistributor);
// // // //               Get.bottomSheet(
// // // //                 Container(
// // // //                   padding: EdgeInsets.all(10.0),
// // // //                   child: ButtonBar(
// // // //                     alignment: MainAxisAlignment.spaceEvenly,
// // // //                     children: [
// // // //                       ElevatedButton(
// // // //                         onPressed: () {
// // // //                           Get.back();
// // // //                           PdfApi.openFile(pdfFile);
// // // //                         },
// // // //                         child: Text("Open"),
// // // //                       ),
// // // //                       ElevatedButton(
// // // //                         onPressed: () async {
// // // //                           Get.back();
// // // //                           await Share.shareFiles(
// // // //                             [pdfFile.path],
// // // //                             text: "Sales Report",
// // // //                           );
// // // //                         },
// // // //                         child: Text("Share"),
// // // //                       ),
// // // //                     ],
// // // //                   ),
// // // //                 ),
// // // //                 backgroundColor: Colors.white,
// // // //                 shape: RoundedRectangleBorder(
// // // //                   borderRadius: BorderRadius.circular(20.0),
// // // //                 ),
// // // //               );
// // // //             },
// // // //             child: Icon(Icons.picture_as_pdf),
// // // //             color: Colors.red[900],
// // // //             elevation: 10.0,
// // // //           )
// // // //         ],
// // // //       ),
// // // //       body: GetBuilder<SalesReportController>(
// // // //         // initState: Get.find<SalesReportController>().fetchSalesReportFromAPI(),
// // // //         builder: (salesReportController) {
// // // //           return Column(
// // // //             children: [
// // // //               Padding(
// // // //                 padding: const EdgeInsets.all(10.0),
// // // //                 child: Row(
// // // //                   children: [
// // // //                     Text(
// // // //                         "Total data: ${Get.find<SalesReportController>().formattedSalesReportList.length.toString()}"),
// // // //                     Spacer(),
// // // //                     IconButton(
// // // //                       icon: Icon(
// // // //                         Icons.calendar_today_outlined,
// // // //                         semanticLabel: "Filter by Date",
// // // //                       ),
// // // //                       onPressed: () async {
// // // //                         var pickedDate = await showDatePicker(
// // // //                             context: context,
// // // //                             initialDate: DateTime.now(),
// // // //                             firstDate: DateTime(1990, 1, 1),
// // // //                             lastDate: DateTime.now().add(Duration(days: 1)));
// // // //                         if (pickedDate != null) {
// // // //                           Get.find<SalesReportController>()
// // // //                               .formatSalesDate(pickedDate);
// // // //                           selectedDistributor = null;
// // // //                         }
// // // //                       },
// // // //                       tooltip: "Filter by date",
// // // //                     ),
// // // //                     PopupMenuButton<Distributor>(
// // // //                       elevation: 3.2,
// // // //                       onCanceled: () {
// // // //                         print('You have not choosed anything');
// // // //                       },
// // // //                       tooltip: 'Filter by distributor',
// // // //                       onSelected: (distributor) {
// // // //                         Get.find<SalesReportController>()
// // // //                             .formatSalesDistributor(distributor);
// // // //                         selectedDistributor = distributor;
// // // //                       },
// // // //                       icon: Icon(Icons.person),
// // // //                       itemBuilder: (BuildContext context) {
// // // //                         return Get.find<DistributorController>()
// // // //                             .distributorList
// // // //                             .map((distributor) {
// // // //                           return PopupMenuItem<Distributor>(
// // // //                             textStyle:
// // // //                                 TextStyle(fontSize: 16.0, color: Colors.black),
// // // //                             value: distributor,
// // // //                             child: Text(distributor.name),
// // // //                           );
// // // //                         }).toList();
// // // //                       },
// // // //                     ),
// // // //                   ],
// // // //                 ),
// // // //               ),
// // // //               Padding(
// // // //                 padding: const EdgeInsets.all(10.0),
// // // //                 child: Text(
// // // //                   Get.find<SalesReportController>().selectedData,
// // // //                   style: TextStyle(
// // // //                     fontSize: 18.0,
// // // //                     fontWeight: FontWeight.bold,
// // // //                   ),
// // // //                 ),
// // // //               ),
// // // //               // Text(DateFormat.yMMMMEEEEd()
// // // //               //     .format(Get.find<SalesReportController>().selectedData)),
// // // //               Expanded(
// // // //                 child: Get.find<SalesReportController>()
// // // //                         .formattedSalesReportList
// // // //                         .isNotEmpty
// // // //                     ? ListView.builder(
// // // //                         itemCount: Get.find<SalesReportController>()
// // // //                             .formattedSalesReportList
// // // //                             .length,
// // // //                         itemBuilder: (context, index) {
// // // //
// // // //                           var item = Get.find<SalesReportController>().formattedSalesReportList[index];
// // // //                           //var items  = Get.find<ProductsController>().productList.firstWhere((element) => element.id == item.id).name;
// // // //                           return ListTile(
// // // //                             subtitle: Row(
// // // //                               children: [
// // // //                                 Text("QTY:  ${Get.find<SalesReportController>()
// // // //                                     .formattedSalesReportList[index]
// // // //                                     .quantity
// // // //                                     .toString()}",
// // // //                                 ),
// // // //                                // Spacer(),
// // // //                                 SizedBox(width:  Get.size.width * 0.3,),
// // // //                                 Get.find<SalesReportController>()
// // // //                                             .formattedSalesReportList[index]
// // // //                                             .discount ==
// // // //                                         null
// // // //                                     ? Text("Discount: 0 %")
// // // //                                     : Text(
// // // //                                         "Discount: ${Get.find<SalesReportController>().formattedSalesReportList[index].discount} %"),
// // // //                               ],
// // // //                             ),
// // // //                             title:
// // // //                             Text(
// // // //                                 //Get.find<SalesReportController>().formattedSalesReportList[index].
// // // //                                 Get.find<ProductsController>()
// // // //                                 .productList
// // // //                                 .where((element) =>
// // // //                                     element.id ==
// // // //                                     Get.find<SalesReportController>()
// // // //                                         .formattedSalesReportList[index]
// // // //                                         .productId)
// // // //                                 .toList()
// // // //                                 .first
// // // //                                 .name),
// // // //                           );
// // // //                         })
// // // //                     : Center(
// // // //                         child: Text("No Data!!"),
// // // //                       ),
// // // //               ),
// // // //             ],
// // // //           );
// // // //         },
// // // //       ),
// // // //     );
// // // //   }
// // // // }
// // //
// // //
// // //
// // // import 'package:flutter/material.dart';
// // // import 'package:get/get.dart';
// // // import 'package:mobitrack_dv_flutter/controller/distributor_controller.dart';
// // // import 'package:mobitrack_dv_flutter/controller/outlets_controller.dart';
// // // import 'package:mobitrack_dv_flutter/controller/products_controller.dart';
// // // import 'package:mobitrack_dv_flutter/controller/sales_report_controller.dart';
// // // import 'package:mobitrack_dv_flutter/model/distributor.dart';
// // // import 'package:mobitrack_dv_flutter/utils/pdf_api.dart';
// // // import 'package:mobitrack_dv_flutter/utils/utilities.dart';
// // // import 'package:mobitrack_dv_flutter/view/report/sales_report_pdf_generator.dart';
// // // import 'package:share_plus/share_plus.dart';
// // // import 'package:mobitrack_dv_flutter/controller_bindings.dart';
// // // import 'package:collection/collection.dart';
// // //
// // // class SalesReportPage extends StatefulWidget {
// // //   SalesReportPage({Key key}) : super(key: key);
// // //
// // //   @override
// // //   _SalesReportPageState createState() => _SalesReportPageState();
// // // }
// // //
// // // class _SalesReportPageState extends State<SalesReportPage> {
// // //   var salesReportController = Get.lazyPut(() => SalesReportController());
// // //   var distributorController = Get.lazyPut(() => DistributorController());
// // //   var outletController = Get.lazyPut(() => OutletsController());
// // //   var productController = Get.lazyPut(() => ProductsController());
// // //
// // //   Distributor selectedDistributor;
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: Text("Sales Report"),
// // //         actions: [
// // //           MaterialButton(
// // //             onPressed: () async {
// // //               print(Get.find<SalesReportController>().formattedSalesReportList);
// // //
// // //               final pdfFile = await PdfParagraphApi.generate(
// // //                   Get.find<SalesReportController>().formattedSalesReportList,
// // //                   distributor: selectedDistributor);
// // //               Get.bottomSheet(
// // //                 Container(
// // //                   padding: EdgeInsets.all(10.0),
// // //                   child: ButtonBar(
// // //                     alignment: MainAxisAlignment.spaceEvenly,
// // //                     children: [
// // //                       ElevatedButton(
// // //                         onPressed: () {
// // //                           Get.back();
// // //                           PdfApi.openFile(pdfFile);
// // //                         },
// // //                         child: Text("Open"),
// // //                       ),
// // //                       ElevatedButton(
// // //                         onPressed: () async {
// // //                           Get.back();
// // //                           await Share.shareFiles(
// // //                             [pdfFile.path],
// // //                             text: "Sales Report",
// // //                           );
// // //                         },
// // //                         child: Text("Share"),
// // //                       ),
// // //                     ],
// // //                   ),
// // //                 ),
// // //                 backgroundColor: Colors.white,
// // //                 shape: RoundedRectangleBorder(
// // //                   borderRadius: BorderRadius.circular(20.0),
// // //                 ),
// // //               );
// // //             },
// // //             child: Icon(Icons.picture_as_pdf),
// // //             color: Colors.red[900],
// // //             elevation: 10.0,
// // //           )
// // //         ],
// // //       ),
// // //       body: GetBuilder<SalesReportController>(
// // //         // initState: Get.find<SalesReportController>().fetchSalesReportFromAPI(),
// // //         builder: (salesReportController) {
// // //           return Column(
// // //             children: [
// // //               Padding(
// // //                 padding: const EdgeInsets.all(10.0),
// // //                 child: Row(
// // //                   children: [
// // //                     Text(
// // //                         "Total data: ${Get.find<SalesReportController>().formattedSalesReportList.length.toString()}"),
// // //                     Spacer(),
// // //                     IconButton(
// // //                       icon: Icon(
// // //                         Icons.calendar_today_outlined,
// // //                         semanticLabel: "Filter by Date",
// // //                       ),
// // //                       onPressed: () async {
// // //                         // var pickedDate = await showDatePicker(
// // //                         //     context: context,
// // //                         //     initialDate: DateTime.now(),
// // //                         //     firstDate: DateTime(1990, 1, 1),
// // //                         //     lastDate: DateTime.now().add(Duration(days: 1)));
// // //                         // if (pickedDate != null) {
// // //                         //   Get.find<SalesReportController>()
// // //                         //       .formatSalesDate(pickedDate);
// // //                         //
// // //                         //   selectedDistributor = null;
// // //                         widg();
// // //                         // }else {
// // //                         //   Utilities.showInToast("Data not Found", toastType:  ToastType.ERROR);
// // //                         // }
// // //                       },
// // //                       tooltip: "Filter by date",
// // //                     ),
// // //                     PopupMenuButton<Distributor>(
// // //                       elevation: 3.2,
// // //                       onCanceled: () {
// // //                         print('You have not choosed anything');
// // //                       },
// // //                       tooltip: 'Filter by distributor',
// // //                       onSelected: (distributor) {
// // //                         Get.find<SalesReportController>()
// // //                             .formatSalesDistributor(distributor);
// // //                         selectedDistributor = distributor;
// // //                       },
// // //                       icon: Icon(Icons.person),
// // //                       itemBuilder: (BuildContext context) {
// // //                         return Get.find<DistributorController>()
// // //                             .distributorList
// // //                             .map((distributor) {
// // //                           return PopupMenuItem<Distributor>(
// // //                             textStyle:
// // //                             TextStyle(fontSize: 16.0, color: Colors.black),
// // //                             value: distributor,
// // //                             child: Text(distributor.name),
// // //                           );
// // //                         }).toList();
// // //                       },
// // //                     ),
// // //                   ],
// // //                 ),
// // //               ),
// // //               Padding(
// // //                 padding: const EdgeInsets.all(10.0),
// // //                 child: Text(
// // //                   Get.find<SalesReportController>().selectedData,
// // //                   style: TextStyle(
// // //                     fontSize: 18.0,
// // //                     fontWeight: FontWeight.bold,
// // //                   ),
// // //                 ),
// // //               ),
// // //               // Text(DateFormat.yMMMMEEEEd()
// // //               //     .format(Get.find<SalesReportController>().selectedData)),
// // //               Expanded(
// // //                 child:
// // //                 Get.find<SalesReportController>()
// // //                     .formattedSalesReportList
// // //                     .isNotEmpty
// // //                     ?
// // //                 ListView.builder(
// // //                     itemCount: Get.find<SalesReportController>()
// // //                         .formattedSalesReportList
// // //                         .length,
// // //                     itemBuilder: (context, index) {
// // //                       return ListTile(
// // //                         subtitle: Row(
// // //                           children: [
// // //                             Text(Get.find<SalesReportController>()
// // //                                 .formattedSalesReportList[index]
// // //                                 .quantity
// // //                                 .toString()),
// // //                             Spacer(),
// // //                             Get.find<SalesReportController>()
// // //                                 .formattedSalesReportList[index]
// // //                                 .discount ==
// // //                                 null
// // //                                 ? Text("Discount: 0 %")
// // //                                 : Text(
// // //                                 "Discount: ${Get.find<SalesReportController>().formattedSalesReportList[index].discount} %"),
// // //                           ],
// // //                         ),
// // //                         title:
// // //                           Text(
// // //                         Get.find<ProductsController>()
// // //                             .productList
// // //                             .firstWhereOrNull((element) =>
// // //                         element.id ==
// // //                             Get.find<SalesReportController>()
// // //                                 .formattedSalesReportList[index]
// // //                                 .productId).name
// // //                       ));
// // //                     })
// // //                     // : ListView.builder(
// // //                     // itemCount: Get.find<ProductsController>()
// // //                     //     .searchProductList
// // //                     //     .length,
// // //                     // itemBuilder: (context, index) {
// // //                     //   return ListTile(
// // //                           //subtitle: Row(
// // //                             //children: [
// // //                           //     Text(Get.find<SalesReportController>()
// // //                           //         .formattedSalesReportList[index]
// // //                           //         .quantity
// // //                           //         .toString()),
// // //                           //     Spacer(),
// // //                           //     Get.find<SalesReportController>()
// // //                           //         .formattedSalesReportList[index]
// // //                           //         .discount ==
// // //                           //         null
// // //                           //         ? Text("Discount: 0 %")
// // //                           //         : Text(
// // //                           //         "Discount: ${Get.find<SalesReportController>().formattedSalesReportList[index].discount} %"),
// // //                           //   ],
// // //                           // ),
// // //                           // title:  Text(
// // //                           //   Get.find<ProductsController>().searchProductList[index].name
// // //                           // )
// // //                     //  );
// // //                    // })
// // //           )
// // //
// // //               ],
// // //           );
// // //         },
// // //       ),
// // //     );
// // //   }
// // //   List<dynamic> list = Get.find<ProductsController>().productList;
// // //   void widg () async{
// // //     var pickedDate = await showDatePicker(
// // //         context: context,
// // //         initialDate: DateTime.now(),
// // //         firstDate: DateTime(1990, 1, 1),
// // //         lastDate: DateTime.now().add(Duration(days: 1)));
// // //     if (pickedDate != null) {
// // //       Get.find<SalesReportController>()
// // //           .formatSalesDate(pickedDate);
// // //       selectedDistributor = null;
// // //     }else {
// // //       Utilities.showInToast("Data not Found", toastType:  ToastType.ERROR);
// // //     }
// // //   }
// // // }
// //
// //
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:mobitrack_dv_flutter/controller/alloutletcontroller.dart';
// // import 'package:mobitrack_dv_flutter/controller/distributor_controller.dart';
// // import 'package:mobitrack_dv_flutter/controller/outlets_controller.dart';
// // import 'package:mobitrack_dv_flutter/controller/products_controller.dart';
// // import 'package:mobitrack_dv_flutter/controller/sales_report_controller.dart';
// // import 'package:mobitrack_dv_flutter/model/distributor.dart';
// // import 'package:mobitrack_dv_flutter/utils/pdf_api.dart';
// // import 'package:mobitrack_dv_flutter/view/report/sales_report_pdf_generator.dart';
// // import 'package:share_plus/share_plus.dart';
// //
// // class SalesReportPage extends StatefulWidget {
// //   SalesReportPage({Key key}) : super(key: key);
// //
// //   @override
// //   _SalesReportPageState createState() => _SalesReportPageState();
// // }
// //
// // class _SalesReportPageState extends State<SalesReportPage> {
// //   var salesReportController = Get.lazyPut(() => SalesReportController());
// //   var distributorController = Get.lazyPut(() => DistributorController());
// //   var outletController = Get.lazyPut(() => OutletsController());
// //   var product = Get.put(ProductsController());
// //   var alloutlet= Get.lazyPut(()=>AllOutletController());
// //
// //   Distributor selectedDistributor;
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text("Sales Report"),
// //         actions: [
// //           MaterialButton(
// //             onPressed: () async {
// //               print(Get.find<SalesReportController>().formattedSalesReportList);
// //
// //               final pdfFile = await PdfParagraphApi.generate(
// //                   Get.find<SalesReportController>().formattedSalesReportList,
// //                   distributor: selectedDistributor);
// //               Get.bottomSheet(
// //                 Container(
// //                   padding: EdgeInsets.all(10.0),
// //                   child: ButtonBar(
// //                     alignment: MainAxisAlignment.spaceEvenly,
// //                     children: [
// //                       ElevatedButton(
// //                         onPressed: () {
// //                           Get.back();
// //                           PdfApi.openFile(pdfFile);
// //                         },
// //                         child: Text("Open"),
// //                       ),
// //                       ElevatedButton(
// //                         onPressed: () async {
// //                           Get.back();
// //                           await Share.shareFiles(
// //                             [pdfFile.path],
// //                             text: "Sales Report",
// //                           );
// //                         },
// //                         child: Text("Share"),
// //                       ),
// //
// //                     ],
// //                   ),
// //                 ),
// //                 backgroundColor: Colors.white,
// //                 shape: RoundedRectangleBorder(
// //                   borderRadius: BorderRadius.circular(20.0),
// //                 ),
// //               );
// //             },
// //             child: Icon(Icons.picture_as_pdf),
// //             color: Colors.red[900],
// //             elevation: 10.0,
// //           ),
// //           ElevatedButton(onPressed: (){
// //
// //
// //             // print( Get.find<AllOutletController>()
// //             //     .alloutlet.length
// //             // );
// //             print(Get.find<ProductsController>().productList.length);
// //             //print(Get.find<ChannelController>().channelList.length);
// //           }, child: Text("Press",style: TextStyle(color: Colors.grey),)),
// //         ],
// //       ),
// //       body: GetBuilder<SalesReportController>(
// //         // initState: Get.find<SalesReportController>().fetchSalesReportFromAPI(),
// //         builder: (salesReportController) {
// //           return Column(
// //             children: [
// //               Padding(
// //                 padding: const EdgeInsets.all(10.0),
// //                 child: Row(
// //                   children: [
// //                     // Text(
// //                     //     "Total data: ${Get.find<SalesReportController>().formattedSalesReportList.length.toString()}"),
// //                     Spacer(),
// //
// //                     IconButton(
// //                       icon: Icon(
// //                         Icons.calendar_today_outlined,
// //                         semanticLabel: "Filter by Date",
// //                       ),
// //                       onPressed: () async {
// //                         var pickedDate = await showDatePicker(
// //                             context: context,
// //                             initialDate: DateTime.now(),
// //                             firstDate: DateTime(1990, 1, 1),
// //                             lastDate: DateTime.now().add(Duration(days: 1)));
// //                         if (pickedDate != null) {
// //                           Get.find<SalesReportController>()
// //                               .formatSalesDate(pickedDate);
// //                           selectedDistributor = null;
// //                         }
// //                       },
// //                       tooltip: "Filter by date",
// //                     ),
// //                     PopupMenuButton<Distributor>(
// //                       elevation: 3.2,
// //                       onCanceled: () {
// //                         print('You have not choosed anything');
// //                       },
// //                       tooltip: 'Filter by distributor',
// //                       onSelected: (distributor) {
// //                         Get.find<SalesReportController>()
// //                             .formatSalesDistributor(distributor);
// //                         // selectedDistributor = distributor;
// //                       },
// //                       icon: Icon(Icons.person),
// //                       itemBuilder: (BuildContext context) {
// //                         return Get.find<DistributorController>()
// //                             .distributorList
// //                             .map((distributor) {
// //                           return PopupMenuItem<Distributor>(
// //                             textStyle:
// //                             TextStyle(fontSize: 16.0, color: Colors.black),
// //                             value: distributor,
// //                             child: Text(distributor.name),
// //                           );
// //                         }).toList();
// //                       },
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //               Padding(
// //                 padding: const EdgeInsets.all(10.0),
// //                 child: Text(
// //                   Get.find<SalesReportController>().selectedData,
// //                   style: TextStyle(
// //                     fontSize: 18.0,
// //                     fontWeight: FontWeight.bold,
// //                   ),
// //                 ),
// //               ),
// //               // Text(DateFormat.yMMMMEEEEd()
// //               //     .format(Get.find<SalesReportController>().selectedData)),
// //               Expanded(
// //                 child: Get.find<SalesReportController>()
// //                     .formattedSalesReportList
// //                     .isNotEmpty
// //                     ? ListView.builder(
// //                     itemCount: Get.find<ProductsController>()
// //                         .productList
// //                         .length,
// //                     itemBuilder: (context, index) {
// //                       return ListTile(
// //                         subtitle: Row(
// //                           children: [
// //                             Text(Get.find<SalesReportController>()
// //                                 .formattedSalesReportList[index]
// //                                 .quantity
// //                                 .toString()),
// //                             Spacer(),
// //                             Get.find<SalesReportController>()
// //                                 .formattedSalesReportList[index]
// //                                 .discount ==
// //                                 null
// //                                 ? Text("Discount: 0 %")
// //                                 : Text(
// //                                 "Discount: ${Get.find<SalesReportController>().formattedSalesReportList[index].discount} %"),
// //                           ],
// //                         ),
// //                         title: Text(
// //                             // Get.find<SalesReportController>().formattedSalesReportList[index].productId == Get.find<ProductsController>().productList[index].name ? Get.find<ProductsController>()
// //                             //     .productList[index].name : "No Product"
// //                             Get.find<ProductsController>()
// //                             .productList
// //
// //                             .where((element) =>
// //                         element.id ==
// //                             Get.find<SalesReportController>()
// //                                 .formattedSalesReportList[index]
// //                                 .productId)
// //
// //                             .first
// //                             .name
// //                         ),
// //                       );
// //                     })
// //                     : Center(
// //                   child: Text("No Data!!"),
// //                 ),
// //               ),
// //             ],
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:mobitrack_dv_flutter/controller/alloutletcontroller.dart';
// import 'package:mobitrack_dv_flutter/controller/distributor_controller.dart';
// import 'package:mobitrack_dv_flutter/controller/outlets_controller.dart';
// import 'package:mobitrack_dv_flutter/controller/productbrand_controller.dart';
// import 'package:mobitrack_dv_flutter/controller/products_controller.dart';
// import 'package:mobitrack_dv_flutter/controller/routes_controller.dart';
// import 'package:mobitrack_dv_flutter/controller/sales_report_controller.dart';
// import 'package:mobitrack_dv_flutter/model/distributor.dart';
// import 'package:mobitrack_dv_flutter/model/routes.dart';
// import 'package:mobitrack_dv_flutter/utils/constants.dart';
// import 'package:mobitrack_dv_flutter/utils/pdf_api.dart';
// import 'package:mobitrack_dv_flutter/view/report/sales_report_pdf_generator.dart';
// import 'package:share_plus/share_plus.dart';
//
// class SalesReportPage extends StatefulWidget {
//   SalesReportPage({Key key}) : super(key: key);
//
//   @override
//   _SalesReportPageState createState() => _SalesReportPageState();
// }
//
// class _SalesReportPageState extends State<SalesReportPage> {
//   var salesReportController = Get.lazyPut(() => SalesReportController());
//   var distributorController = Get.lazyPut(() => DistributorController());
//   var outletController = Get.lazyPut(() => OutletsController());
//   var productController = Get.lazyPut(()=>ProductsController());
//   var alloutletCOntroller = Get.lazyPut(() => AllOutletController());
//   var productcontroller = Get.lazyPut(()=>ProductBrandController());
//
//   Routees selectedDistributor;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//
//
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Sales Report"),
//         actions: [
//           MaterialButton(
//             onPressed: () async {
//               print(Get.find<SalesReportController>().formattedSalesReportList);
//
//               final pdfFile = await PdfParagraphApi.generate(
//                   Get.find<SalesReportController>().formattedSalesReportList,
//                   distributor: Constants.selectedRoute);
//               Get.bottomSheet(
//                 Container(
//                   padding: EdgeInsets.all(10.0),
//                   child: ButtonBar(
//                     alignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       ElevatedButton(
//                         onPressed: () {
//                           Get.back();
//                           PdfApi.openFile(pdfFile);
//                         },
//                         child: Text("Open"),
//                       ),
//                       ElevatedButton(
//                         onPressed: () async {
//                           Get.back();
//                           await Share.shareFiles(
//                             [pdfFile.path],
//                             text: "Sales Report",
//                           );
//                         },
//                         child: Text("Share"),
//                       ),
//                     ],
//                   ),
//                 ),
//                 backgroundColor: Colors.white,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20.0),
//                 ),
//               );
//             },
//             child: Icon(Icons.picture_as_pdf),
//             color: Colors.red[900],
//             elevation: 10.0,
//           )
//         ],
//       ),
//       body: GetBuilder<SalesReportController>(
//         // initState: Get.find<SalesReportController>().fetchSalesReportFromAPI(),
//         builder: (salesReportController) {
//           return Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: Row(
//                   children: [
//
//                     Text(
//                         "Total data: ${Get.find<SalesReportController>().formattedSalesReportList.length.toString()}"),
//                     Spacer(),
//                     IconButton(
//                       icon: Icon(
//                         Icons.calendar_today_outlined,
//                         semanticLabel: "Filter by Date",
//                       ),
//                       onPressed: () async {
//                         var pickedDate = await showDatePicker(
//                             context: context,
//                             initialDate: DateTime.now(),
//                             firstDate: DateTime(1990, 1, 1),
//                             lastDate: DateTime.now().add(Duration(days: 1)));
//                         if (pickedDate != null) {
//                           Get.find<SalesReportController>()
//                               .formatSalesDate(pickedDate);
//                           selectedDistributor = null;
//                         }
//                       },
//                       tooltip: "Filter by date",
//                     ),
//                     PopupMenuButton<Routees>(
//                       elevation: 3.2,
//                       onCanceled: () {
//                         print('You have not choosed anything');
//                       },
//                       tooltip: 'Filter by distributor',
//                       onSelected: (distributor) {
//                         Get.find<SalesReportController>()
//                             .formatSalesDistributor(distributor);
//                         selectedDistributor = distributor;
//                       },
//                       icon: Icon(Icons.person),
//                       itemBuilder: (BuildContext context) {
//                         return Get.find<Routecontroller>()
//                             .routeList
//                             .map((distributor) {
//                           return PopupMenuItem<Routees>(
//                             textStyle:
//                             TextStyle(fontSize: 16.0, color: Colors.black),
//                             value: distributor,
//                             child: Text(distributor.routename),
//                           );
//                         }).toList();
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: Text(
//                   Get.find<SalesReportController>().selectedData,
//                   style: TextStyle(
//                     fontSize: 18.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               // Text(DateFormat.yMMMMEEEEd()
//               //     .format(Get.find<SalesReportController>().selectedData)),
//               Expanded(
//                 child: Get.find<SalesReportController>()
//                     .formattedSalesReportList
//                     .isNotEmpty
//                     ? ListView.builder(
//                     itemCount: Get.find<SalesReportController>()
//                         .formattedSalesReportList
//                         .length,
//
//                     itemBuilder: (context, index) {
//
//                       var item = Get.find<SalesReportController>()
//                           .formattedSalesReportList;
//                       return ListTile(
//                         subtitle: Row(
//                           children: [
//                             Text(Get.find<SalesReportController>()
//                             .formattedSalesReportList[index]
//                             .quantity.toString().isNotEmpty ?
//                                 Get.find<SalesReportController>()
//                                 .formattedSalesReportList[index]
//                                 .quantity
//                                 .toString(): "Please Choose Approximate Date "
//                             ),
//                             ElevatedButton(onPressed: (){
//                               // print(Get.find<ProductBrandController>()
//                               //     .productList
//                               //     .where((element) => element.id== item[index].productId)
//                               //     .toList().first.id);
//                               print(item.first.productId);
//                             }, child: Text("press")),
//                             Spacer(),
//                             Get.find<SalesReportController>()
//                                 .formattedSalesReportList[index]
//                                 .discount ==
//                                 null
//                                 ? Text("Discount: 0 %")
//                                 : Text(
//                                 "Discount: ${Get.find<SalesReportController>().formattedSalesReportList[index].discount} %"),
//                           ],
//                         ),
//                         title: Text(
//                           Get.find<ProductBrandController>()
//                                   .productList
//                                   .where((element) => element.id== item[index].productId)
//                                   .toList()
//                                   .isNotEmpty
//                         ? Get.find<ProductsController>()
//                             .productList
//                             .firstWhere((element) => element.id == item[index].productId, orElse: null)
//                             .name
//                            : "Choose Date"
//                         ),
//                       );
//                     })
//                     : Center(
//                   child: Text("No Data!!"),
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
//   // void refresh(){
//   //   Get.find<ProductsController>()
//   //       .productList
//   //       .firstWhere((element) => element., orElse: null)
//   //       .name
//   // }
// }

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobitrack_dv_flutter/controller/distributor_controller.dart';
import 'package:mobitrack_dv_flutter/controller/outlets_controller.dart';
import 'package:mobitrack_dv_flutter/controller/productbrand_controller.dart';
import 'package:mobitrack_dv_flutter/controller/products_controller.dart';
import 'package:mobitrack_dv_flutter/controller/routes_controller.dart';
import 'package:mobitrack_dv_flutter/controller/sales_report_controller.dart';
import 'package:mobitrack_dv_flutter/model/distributor.dart';
import 'package:mobitrack_dv_flutter/model/products.dart';
import 'package:mobitrack_dv_flutter/model/routes.dart';
import 'package:mobitrack_dv_flutter/utils/constants.dart';
import 'package:mobitrack_dv_flutter/utils/pdf_api.dart';
import 'package:mobitrack_dv_flutter/view/report/sales_report_pdf_generator.dart';
import 'package:pdf/pdf.dart';
import 'package:share_plus/share_plus.dart';

class SalesReportPage extends StatefulWidget {
  SalesReportPage({Key? key}) : super(key: key);

  @override
  _SalesReportPageState createState() => _SalesReportPageState();
}

class _SalesReportPageState extends State<SalesReportPage> {
  var salesReportController = Get.lazyPut(() => SalesReportController());
  var distributorController = Get.lazyPut(() => DistributorController());
  var outletController = Get.lazyPut(() => OutletsController());
  var productbrandcontroller = Get.lazyPut(() => ProductBrandController());

  Routees? selectedDistributor;
  Product? product;
  // sw(){
  //   //Get.find<ProductBrandController>(). ==    item.productId.toString() ?     Get.find<ProductBrandController>().name.first : ""
  //   Get.find<ProductBrandController>().productList
  //       .where((element) =>
  //   element.id ==
  //       Get.find<SalesReportController>()
  //           .formattedSalesReportList).toList().single.name;
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      Get.find<ProductBrandController>().productList.length;
      //  print(  Get.find<ProductBrandController>().productList.elementAt().name);
      print(Get.find<SalesReportController>(). formattedSalesReportList!.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Sales Report"),
        actions: [
          MaterialButton(
            onPressed: () async {
              print(Get.find<SalesReportController>().formattedSalesReportList);

              final pdfFile = await PdfParagraphApi.generate(
                  Get.find<SalesReportController>().formattedSalesReportList!,
                  distributor: Constants.selectedRoute!);
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
      body: RefreshIndicator(
        onRefresh: () async{
          await Future.delayed(Duration(seconds: 1));
          Get.find<SalesReportController>().fetchSalesReportFromAPI();
        },
        child: GetBuilder<SalesReportController>(
          // initState: Get.find<SalesReportController>().fetchSalesReportFromAPI(),
          builder: (salesReportController) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Text(
                          "Total data: ${ Get.find<SalesReportController>().formattedSalesReportList!.length}"),
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
                            selectedDistributor = null;
                          }
                        },
                        tooltip: "Filter by date",
                      ),
                      // PopupMenuButton<Routes>(
                      //   elevation: 3.2,
                      //   onCanceled: () {
                      //     print('You have not choosed anything');
                      //   },
                      //   tooltip: 'Filter by distributor',
                      //   onSelected: (distributor) {
                      //     Get.find<SalesReportController>()
                      //         .formatSalesDistributor(distributor);
                      //     Constants.selectedRoute= distributor;
                      //   },
                      //   icon: Icon(Icons.person),
                      //   itemBuilder: (BuildContext context) {
                      //     return Get.find<Routecontroller>()
                      //         .routeList
                      //         .map((distributor) {
                      //       return PopupMenuItem<Routees>(
                      //         textStyle:
                      //         TextStyle(fontSize: 16.0, color: Colors.black),
                      //         value: distributor,
                      //         child: Text(distributor.routename),
                      //       );
                      //     }).toList();
                      //   },
                      // ),
                    ],
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor : MaterialStateProperty.all(Colors.black)
                  ),
                    onPressed: (){
                  setState(() {
                          Get.find<ProductBrandController>().productList.length;
                   //  print(  Get.find<ProductBrandController>().productList.elementAt().name);
                    print(Get.find<SalesReportController>(). formattedSalesReportList!.length);
                  });
                }
                    , child: Text("Click to View Unloaded Data")),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    Get.find<SalesReportController>().selectedData!,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // Text(DateFormat.yMMMMEEEEd()
                //     .format(Get.find<SalesReportController>().selectedData)),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0,right: 20.0),
                  child: Table(
                    border:  TableBorder.symmetric(inside: BorderSide(width: 1, color: Colors.blue), outside: BorderSide(width: 1)),
                      columnWidths: {
                        0: FractionColumnWidth(0.30),
                        1: FractionColumnWidth(0.15),
                        2: FractionColumnWidth(0.1),
                        3: FractionColumnWidth(0.1),
                        4: FractionColumnWidth(0.2),
                        5: FractionColumnWidth(0.15),
                      },
                    children: [
                      TableRow(
                        children: [
                          //'Product', 'Outlet', 'Quantity', 'Discount %',"Remark",
                          Container(
                            color: Colors.lightBlueAccent,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Product',textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: Get.size.height *0.015,color: Colors.white)),
                            ),
                          ),
                          Container(
                            color: Colors.lightBlueAccent,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Outlet',textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: Get.size.height *0.015,color: Colors.white)),
                            ),
                          ),
                          Container(
                            color: Colors.lightBlueAccent,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Qty',textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.normal,fontSize: Get.size.height *0.015,color: Colors.white)),
                            ),
                          ),
                          Container(
                            color: Colors.lightBlueAccent,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text( '  %',textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: Get.size.height *0.015,color: Colors.white)),
                            ),
                          ),
                          Container(
                            color: Colors.lightBlueAccent,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Remark",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: Get.size.height *0.015,color: Colors.white)),
                            ),
                          ),
                          Container(
                            color: Colors.lightBlueAccent,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Cost",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: Get.size.height *0.015,color: Colors.white)),
                            ),
                          ),
                        ]
                      )
                    ],
                  ),
                ),
                Expanded(
                  child:
                  GetBuilder<SalesReportController>(
                    builder: (context) {
                      return Get.find<SalesReportController>()
                          .formattedSalesReportList!
                          .isNotEmpty
                          ? ListView.builder(
                          itemCount: Get.find<SalesReportController>()
                              .formattedSalesReportList!
                              .length,
                          itemBuilder: (context, index) {
                            var item = Get.find<SalesReportController>()
                                .formattedSalesReportList ;
                            // var newlist = Get.find<ProductBrandController>()
                            //     .productList
                            //     .where((element) => element.id==item[index].productId || item[index].productId == 0 ).first.name;
                            return Padding(
                              padding: const EdgeInsets.only(left: 20.0,right: 20.0),
                              child:
                              Table (
                                border:   TableBorder.symmetric(inside: BorderSide(width: 1, color: Colors.blue), outside: BorderSide(width: 1)),
                            columnWidths: {
                              0: FractionColumnWidth(0.30),
                              1: FractionColumnWidth(0.15),
                              2: FractionColumnWidth(0.1),
                              3: FractionColumnWidth(0.1),
                              4: FractionColumnWidth(0.2),
                              5: FractionColumnWidth(0.20),
                            },
                                children: [
                                  // TableRow(
                                  //   children:[
                                  //
                                  //
                                  //   ],
                              //    ),
                                  TableRow(
                                    children: [
                                     Padding(
                                       padding: const EdgeInsets.all(8.0),
                                       child: Text( item![index].productId == 0 ?
                                       // newlist
                                       //       .isEmpty ?
                                       "-"
                                           : Get.find<ProductBrandController>()
                                           .productList
                                           .where((element) => element.id == item[index].productId)
                                           .toList()
                                           .first.name
                                           .toString(),textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: Get.size.height *0.012))
                                     ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                            Get.find<OutletsController>()
                                            .outletList!
                                            .where((element) => element.id == item[index].outletId)
                                            .toList()
                                            .isNotEmpty
                                            ? Get.find<OutletsController>()
                                            .outletList!
                                            .where((element) => element.id == item[index].outletId)
                                            .toList()
                                            .first
                                            .name!
                                            : "N/A",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: Get.size.height *0.012)
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(item[index].quantity == 0 ? "-" :item[index].quantity.toString() ,textAlign: TextAlign.center,
                                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: Get.size.height *0.01)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text( item[index].discount  == null ? "-" :item[index].discount.toString(),textAlign: TextAlign.center,
                                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: Get.size.height *0.01)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(  item[index].remarks ==null ? "-" : item[index].remarks!,textAlign: TextAlign.center,
                                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: Get.size.height *0.01)),
                                      ),
                                      Container(

                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                              Get.find<ProductBrandController>()
                                              .productList
                                              .where((element) => element.id == item[index].productId)
                                              .toList()
                                              .isNotEmpty
                                             ?
                                              (Get.find<ProductBrandController>()
                                              .productList
                                              .where((element) => element.id == item[index].productId)
                                              .toList()
                                              .first
                                              .value! * item[index].quantity!).toString()
                                             : "N/A"
                                              ,textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: Get.size.height *0.01)),
                                        ),
                                      ),
                                    ]
                                  )
                                ],
                                // headers: [, 'Product', 'Outlet', 'Quantity', 'Discount %',"Remark"],
                                // data: List<List<dynamic>>.generate(
                                //   item.length,
                                //       (index) => <dynamic>[
                                //     index + 1,
                                //     item[index].productId == 0 ?
                                //     // newlist
                                //     //       .isEmpty ?
                                //     "-"
                                //         :
                                //     Get.find<ProductBrandController>()
                                //         .productList
                                //         .where((element) => element.id == item[index].productId || item[index].productId == 0 )
                                //         .toList()
                                //         .first
                                //         .name,
                                //     // .isNotEmpty
                                //     // ? "Shop": Get.find<ProductBrandController>()
                                //     // .productList
                                //     // .where((element) => element.id == salesList[index].productId)
                                //     // .toList()
                                //     // .first
                                //     // .name,
                                //     Get.find<OutletsController>()
                                //         .outletList
                                //         .where((element) => element.id == item[index].outletId)
                                //         .toList()
                                //         .isNotEmpty
                                //         ? Get.find<OutletsController>()
                                //         .outletList
                                //         .where((element) => element.id == item[index].outletId)
                                //         .toList()
                                //         .first
                                //         .name
                                //         : "N/A",
                                //    item[index].quantity,
                                //     item[index].discount,
                                //     item[index].remarks ==null ? "-" : item[index].remarks,
                                //   ],
                                // ),
                                // headerStyle: TextStyle(
                                //   color: Colors.white,
                                //   fontWeight: FontWeight.bold,
                                // ),
                                // headerDecoration: BoxDecoration(
                                //   color:  Colors.cyan,
                                // ),
                                // rowDecoration: BoxDecoration(
                                //   border: Border(
                                //     bottom: BorderSide(
                                //       color:  Colors.cyan,
                                //       width: .5,
                                //     ),
                                //   ),
                                // ),
                                // cellAlignment: Alignment.centerRight,
                                // cellAlignments: {0: Alignment.centerLeft},
                              ),
                            );
                            //   ListTile(
                            //   subtitle: Row(
                            //     children: [
                            //       // ElevatedButton(onPressed: (){
                            //       //   setState(() {
                            //       //     print(Get.find<SalesReportController>()
                            //       //         .formattedSalesReportList[index].productId);
                            //       // //    Get.find<ProductsController>()
                            //       // //         .productList
                            //       // //         .firstWhere((element) => element.id == Get.find<SalesReportController>()
                            //       // //         .formattedSalesReportList[index].productId, orElse: ()=> null).name;
                            //       //     //      Get.find<ProductBrandController>().productList.length;
                            //       //   //  print(Get.find<SalesReportController>().formattedSalesReportList.length);
                            //       //     //   print(Get.find<SalesReportController>().formattedformattedSalesReportList.first.productId);
                            //       //   });
                            //       // }
                            //       //     , child: Text("Press")),
                            //       // Text(Get.find<SalesReportController>()
                            //       //     .formattedSalesReportList[index]
                            //       //     .remarks
                            //       //     .toString()),
                            //       Text(Get.find<SalesReportController>()
                            //           .formattedSalesReportList[index]
                            //           .quantity
                            //           .toString()),
                            //       Spacer(),
                            //       Get.find<SalesReportController>()
                            //           .formattedSalesReportList[index]
                            //           .discount ==
                            //           null
                            //           ? Text("Discount: 0 %")
                            //           : Text(
                            //           "Discount: ${Get.find<SalesReportController>().formattedSalesReportList[index].discount} %"),
                            //     ],
                            //   ),
                            //   title:
                            //   Text(
                            //    //  newlist == null ? "Please Click The Show Button Above" :  newlist.toString()
                            //    item[index].productId == 0 ?
                            //       // newlist
                            //       //       .isEmpty ?
                            //       Get.find<SalesReportController>()
                            //           .formattedSalesReportList[index]
                            //           .remarks
                            //           .toString()
                            //      : newlist
                            //     //Get.find<ProductsController>().productList.toSet().intersection(Get.find<SalesReportController>().formattedSalesReportList.toSet()).toList().first.name
                            //     //   Get.find<ProductsController>()
                            //     //   .productList
                            //     //   .where((element) => 3== 3).first.name
                            //     //  Get.find<ProductsController>().localSalesList.toString()
                            //
                            //   //  })
                            //   //   Get.find<ProductBrandController>().productList.removeWhere((element) => Get.find<SalesReportController>()
                            //   // .formattedSalesReportList.
                            //  )
                            // //   Text(
                            // //       Get.find<ProductBrandController>().productList
                            // //           .where((element) =>
                            // //       element.id ==
                            // //           Get.find<SalesReportController>()
                            // //               .formattedSalesReportList[index].productId).toList().first.name.isEmpty ? "Refresh":  Get.find<ProductBrandController>().productList
                            // //           .where((element) =>
                            // //       element.id ==
                            // //           Get.find<SalesReportController>()
                            // //               .formattedSalesReportList[index].productId).toList().first.name
                            // //    )
                            // );
                          })
                          : Center(
                        child: Text("No Data!!"),
                      );
                    }
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

}
