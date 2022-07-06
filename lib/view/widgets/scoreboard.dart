// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:mobitrack_dv_flutter/controller/outlets_controller.dart';
// import 'package:mobitrack_dv_flutter/controller/products_controller.dart';
// import 'package:mobitrack_dv_flutter/view/attendance/show_attendance.dart';
// import 'package:mobitrack_dv_flutter/view/report/sales_report_page.dart';
// import 'package:percent_indicator/percent_indicator.dart';
// import 'package:flutter/material.dart';
// import 'package:share_plus/share_plus.dart';
//
// import '../../controller/dashboard_Controller.dart';
// import '../../controller/sales_report_controller.dart';
// import '../../utils/constants.dart';
// import '../../utils/pdf_api.dart';
// import '../report/sales_report_pdf_generator.dart';
// import '../view_distributor.dart';
//
//
//
// class ScoreBoard extends StatelessWidget {
//   var product =  Get.lazyPut<ProductsController>(() => ProductsController());
//   var saleproduct = Get.lazyPut(()=>SalesReportController());
//   var dashprodut = Get.lazyPut(()=>DashBoard_Controller());
//   @override
//   Widget build(BuildContext context) {
//     return   Scaffold(
//           body:   Constants.selectmyRoute == null?
//           Container(
//               child: Card(
//                 child: InkWell(
//                   onTap: (){},
//                   child: Container(
//                     width: double.infinity,
//                     padding: EdgeInsets.all(20),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.only(top: 8.0),
//                           child: Text('Please Select The Routes'),
//                         ),
//                         ElevatedButton(
//                             style:  ButtonStyle(
//                               backgroundColor: MaterialStateProperty.all(Colors.black),
//                             ),
//                             onPressed: (){
//
//                                 Get.to(()=> View_route());
//
//                             },child: Text("Route")),
//                       ],
//                     ),
//
//                   ),
//                 ),
//               )
//             // Column(
//             //   children: [
//             //     Text("Select Route"),
//             //     ElevatedButton(onPressed: (){
//
//             //       setState(() {
//             //         Get.to(()=> View_route());
//             //       });
//             //     }, child: Text("Route"))
//             //   ],
//             // ),
//           ):
//           Column(
//             children: [
//               ElevatedButton(onPressed: (){}, child: Text("press")),
//               GetBuilder<DashBoard_Controller>(
//                 builder: (context) {
//                   return SingleChildScrollView(
//                     child: Column(
//                       children: [
//                         // ListView.builder(
//                         //   shrinkWrap: true,
//                         //   itemCount: Get.find<DashBoard_Controller>().dashboard.length,
//                         //   itemBuilder: (context,index) {
//                         //     var item = Get.find<DashBoard_Controller>().dashboard[index];
//                         //     return Padding(
//                         //       padding: const EdgeInsets.all(8.0),
//                         //       child: Card(
//                         //           elevation: 10,
//                         //           child: Column(
//                         //             children: [
//                         //               Padding(
//                         //                 padding: const EdgeInsets.all(8.0),
//                         //                 child: Row(
//                         //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         //                   children: [
//                         //                     ElevatedButton(onPressed: (){
//                         //                       print(item.totalcall.toString(),);
//                         //                     },child: Text("Press"),),
//                         //                     Container(
//                         //                       alignment: AlignmentDirectional.center,
//                         //                       child:   Text(
//                         //                         item.totalcall.toString(),
//                         //                         //Constants.selectmyRoute,
//                         //                         style: TextStyle(
//                         //                             fontWeight: FontWeight.w600,
//                         //                             fontSize: 30.0,
//                         //                             color: Color.fromARGB(255, 80, 79, 79)),
//                         //                       ),
//                         //                     ),
//                         //
//                         //                   ],
//                         //                 ),
//                         //               ),
//                         //
//                         //             ],
//                         //           )),
//                         //     );
//                         //   }
//                         // ),
//                       ListView.builder(
//                         shrinkWrap: true ,
//                         itemCount: Get.find<DashBoard_Controller>().dashboard.length,
//                         itemBuilder: (context, index) {
//                           var item =Get.find<DashBoard_Controller>().dashboard[index];
//                           return Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: ListTile(
//                                     title: Card(
//                                         elevation: 10,
//                                         child: Text(item.totalcall.toString()),
//                                         // Column(
//                                         //   children: [
//                                         //     Padding(
//                                         //       padding: const EdgeInsets.all(8.0),
//                                         //       child: Container(
//                                         //         alignment: AlignmentDirectional.topStart,
//                                         //         child: const Text(
//                                         //           'Calls',
//                                         //           style: TextStyle(
//                                         //               fontWeight: FontWeight.w600,
//                                         //               fontSize: 15.0,
//                                         //               color: Color.fromARGB(255, 80, 79, 79)),
//                                         //         ),
//                                         //       ),
//                                         //     ),
//                                         //     Container(
//                                         //       height: 90,
//                                         //       child:  Column(
//                                         //         children: [
//                                         //           Padding(
//                                         //             padding: const EdgeInsets.all(8.0),
//                                         //             child: Column(
//                                         //               children: [
//                                         //                 Row(
//                                         //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                         //                   children: [
//                                         //                     Column(
//                                         //                       children: [
//                                         //                         calls(text: item.totalcall.toString()),
//                                         //                         calls(
//                                         //                           text: "Total Call",
//                                         //                         ),
//                                         //                       ],
//                                         //                     ),
//                                         //                     Column(
//                                         //                       children: [
//                                         //                         calls(text:   (Constants.value_increase ~/2).toString(),
//                                         //                         ),
//                                         //                         calls(text: "Sucessfull Calls",ontap: (){
//                                         //                           Get.to(SalesReportPage());
//                                         //                         }),
//                                         //                       ],
//                                         //                     ),
//                                         //
//                                         //                     Column(
//                                         //                       children: [
//                                         //                         calls(text:  "${Get.find<OutletsController>().outletList.length -Constants.value_increase~/2}"
//                                         //                         ),
//                                         //                         calls(text: "Remaining Call"),
//                                         //                       ],
//                                         //                     ),
//                                         //                   ],
//                                         //                 ),
//                                         //               ],
//                                         //             ),
//                                         //           ),
//                                         //         ],
//                                         //       ),
//                                         //     ),
//                                         //   ],
//                                         // )),
//                                   ),
//                                     subtitle: ElevatedButton(onPressed: (){
//                                       print(item.totalcall.toString());
//                                     },child: Text("Press"),),
//                                 ));
//                         }
//                       ),
//
//     //                 Padding(
//     //                   padding: const EdgeInsets.all(8.0),
//     //                   child: Card(
//     //                       elevation: 10,
//     //                       child: Column(
//     //                         children: [
//     //                           Padding(
//     //                             padding: const EdgeInsets.all(8.0),
//     //                             child: Container(
//     //                               alignment: AlignmentDirectional.topStart,
//     //                               child: const Text(
//     //                                 'ACTIVITY',
//     //                                 style: TextStyle(
//     //                                     fontWeight: FontWeight.w600,
//     //                                     fontSize: 15.0,
//     //                                     color: Color.fromARGB(255, 80, 79, 79)),
//     //                               ),
//     //                             ),
//     //                           ),
//     //                           SizedBox(
//     //                             height: 90,
//     //                             child: activity(),
//     //                           ),
//     //                         ],
//     //                       )),
//     //                 ),
//     //                 Padding(
//     //                   padding: const EdgeInsets.all(8.0),
//     //                   child: Card(
//     //                     elevation: 10,
//     //                     child: Column(
//     //                       children: [
//     //                         Container(
//     //                             height: 280,
//     //                             width: 400,
//     //                             color: Colors.white,
//     //                             child: Column(
//     //                               children: [
//     //                                 Padding(
//     //                                   padding: const EdgeInsets.all(8.0),
//     //                                   child: Container(
//     //                                     alignment: AlignmentDirectional.topStart,
//     //                                     child: const Text('Productivity'),
//     //                                   ),
//     //                                 ),
//     //                                 Container(
//     //                                   height: 150,
//     //                                   width: 300,
//     //                                   child: Row(
//     //                                     crossAxisAlignment:
//     //                                     CrossAxisAlignment.start,
//     //                                     children: [
//     //                                       Padding(
//     //                                         padding: const EdgeInsets.all(8.0),
//     //                                         child: CircularPercentIndicator(
//     //                                           radius: 130.0,
//     //                                           lineWidth: 18.0,
//     //                                           animation: true,
//     //                                           animationDuration: 1200,
//     //                                           percent: 0.3,
//     //                                           circularStrokeCap:
//     //                                           CircularStrokeCap.butt,
//     //                                           center:  Text(
//     //                                           (Get.find<OutletsController>().outletList.length / Constants.value_increase).toString(),
//     //                                             style: TextStyle(
//     //                                                 fontWeight: FontWeight.bold,
//     //                                                 fontSize: 20.0),
//     //                                           ),
//     //                                           backgroundColor: const Color.fromARGB(
//     //                                               255, 217, 221, 227),
//     //                                           progressColor:
//     //                                           Color.fromARGB(255, 15, 104, 131),
//     //                                         ),
//     //                                       ),
//     //                                       Expanded(
//     //                                         child: ListView(
//     //                                           children: const [
//     //                                             ListTile(
//     //                                               title: Text(
//     //                                                 ' 0',
//     //                                                 style: TextStyle(
//     //                                                     fontWeight: FontWeight.w500,
//     //                                                     fontSize: 16.0),
//     //                                               ),
//     //                                               subtitle: Text(
//     //                                                 'Target',
//     //                                                 style: TextStyle(
//     //                                                     fontWeight: FontWeight.bold,
//     //                                                     fontSize: 12.0,
//     //                                                     color: Colors.grey),
//     //                                               ),
//     //                                             ),
//     //                                             ListTile(
//     //                                               title: Text(
//     //                                                 ' 0',
//     //                                                 style: TextStyle(
//     //                                                     fontWeight: FontWeight.w500,
//     //                                                     fontSize: 16.0),
//     //                                               ),
//     //                                               subtitle: Text(
//     //                                                 'Acheivement',
//     //                                                 style: TextStyle(
//     //                                                     fontWeight: FontWeight.bold,
//     //                                                     fontSize: 12.0,
//     //                                                     color: Colors.grey),
//     //                                               ),
//     //                                             )
//     //                                           ],
//     //                                         ),
//     //                                       )
//     //                                     ],
//     //                                   ),
//     //                                 ),
//     //                                 Container(
//     //                                   child: letters(),
//     //                                 )
//     //                               ],
//     //                             )),
//     //                       ],
//     //                     ),
//     //                   ),
//     //                 ),
//     //                 Padding(
//     //                   padding: const EdgeInsets.all(8.0),
//     //                   child: Card(
//     //                     elevation: 10,
//     //                     child: Column(
//     //                       children: [
//     //                         Padding(
//     //                           padding: const EdgeInsets.all(8.0),
//     //                           child: Container(
//     //                             alignment: AlignmentDirectional.topStart,
//     //                             child: const Text('ACTIVE OUTLET TARGET'),
//     //                           ),
//     //                         ),
//     //                         SizedBox(
//     //                           height: 190,
//     //                           child: Row(
//     //                             crossAxisAlignment: CrossAxisAlignment.start,
//     //                             children: [
//     //                               Padding(
//     //                                 padding: const EdgeInsets.all(8.0),
//     //                                 child: CircularPercentIndicator(
//     //                                   radius: 130.0,
//     //                                   lineWidth: 18.0,
//     //                                   animation: true,
//     //                                   animationDuration: 1200,
//     //                                   percent: Constants.value_increase /2,
//     //                                   circularStrokeCap: CircularStrokeCap.butt,
//     //                                   center:   Text(
//     // (Constants.value_increase ~/2).toString(),
//     //                                     style: TextStyle(
//     //                                         fontWeight: FontWeight.bold,
//     //                                         fontSize: 20.0),
//     //                                   ),
//     //                                   backgroundColor:
//     //                                   const Color.fromARGB(255, 217, 221, 227),
//     //                                   progressColor:
//     //                                   Color.fromARGB(255, 15, 104, 131),
//     //                                 ),
//     //                               ),
//     //                               Expanded(
//     //                                 child: ListView(
//     //                                   children:   [
//     //                                     ListTile(
//     //                                       title: Text(
//     //                                         Get.find<OutletsController>().outletList.length.toString(),
//     //                                         style: TextStyle(
//     //                                             fontWeight: FontWeight.w500,
//     //                                             fontSize: 16.0),
//     //                                       ),
//     //                                       subtitle: Text(
//     //                                         'Target',
//     //                                         style: TextStyle(
//     //                                             fontWeight: FontWeight.bold,
//     //                                             fontSize: 12.0,
//     //                                             color: Colors.grey),
//     //                                       ),
//     //                                     ),
//     //                                     ListTile(
//     //                                       title: Text(
//     //                                         '0',
//     //                                         style: TextStyle(
//     //                                             fontWeight: FontWeight.w500,
//     //                                               fontSize: 16.0),
//     //                                       ),
//     //                                       subtitle: Text(
//     //                                         'Acheivement',
//     //                                         style: TextStyle(
//     //                                             fontWeight: FontWeight.bold,
//     //                                             fontSize: 12.0,
//     //                                             color: Colors.grey),
//     //                                       ),
//     //                                     )
//     //                                   ],
//     //                                 ),
//     //                               ),
//     //                               MaterialButton(
//     //                                 onPressed: () async {
//     //                                   print(Get.find<SalesReportController>().formattedSalesReportList.length);
//     //                                   print(Constants.selectedRoute.routename);
//     //                                   final pdfFile = await PdfParagraphApi.generate(
//     //                                       Get.find<SalesReportController>().formattedSalesReportList ,
//     //                                       distributor: Constants.selectedRoute);
//     //                                   Get.bottomSheet(
//     //                                     Container(
//     //                                       padding: EdgeInsets.all(10.0),
//     //                                       child: ButtonBar(
//     //                                         alignment: MainAxisAlignment.spaceEvenly,
//     //                                         children: [
//     //                                           ElevatedButton(
//     //                                             onPressed: () {
//     //                                               Get.back();
//     //                                               PdfApi.openFile(pdfFile);
//     //                                             },
//     //                                             child: Text("Open"),
//     //                                           ),
//     //                                           ElevatedButton(
//     //                                             onPressed: () async {
//     //                                               Get.back();
//     //                                               await Share.shareFiles(
//     //                                                 [pdfFile.path],
//     //                                                 text: "Sales Report",
//     //                                               );
//     //                                             },
//     //                                             child: Text("Share"),
//     //                                           ),
//     //                                         ],
//     //                                       ),
//     //                                     ),
//     //                                     backgroundColor: Colors.white,
//     //                                     shape: RoundedRectangleBorder(
//     //                                       borderRadius: BorderRadius.circular(20.0),
//     //                                     ),
//     //                                   );
//     //                                 },
//     //                                 child: Icon(Icons.picture_as_pdf),
//     //                                 color: Colors.red[900],
//     //                                 elevation: 10.0,
//     //                               )
//     //                             ],
//     //                           ),
//     //                         ),
//     //                       ],
//     //                     ),
//     //                   ),
//     //                 )
//                       ],
//                     ),
//                   );
//                 }
//               ),
//             ],
//           ))
//     ;
//   }
//
//   Widget mycard({String text}) {
//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Text(text),
//         ),
//       ],
//     );
//   }
//
//   Widget letters() {
//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Column(
//                     children: [
//                       mycard(text: "0"),
//                       mycard(
//                         text: "Total orders",
//                       ),
//                     ],
//                   ),
//                   Column(
//                     children: [
//                       mycard(text: "0"),
//                       mycard(text: "Total invoiced"),
//                     ],
//                   ),
//                   Column(
//                     children: [
//                       mycard(text: "0"),
//                       mycard(text: "Total returns"),
//                     ],
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// Widget calls({String text,VoidCallback ontap}) {
//   return Column(
//     children: [
//       Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Text(text),
//       ),
//     ],
//   );
// }
//
// Widget activity() {
//   return Column(
//     children: [
//       Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   children: [
//                     calls(text: Constants.increase_unsucessfulcall.toString()),
//                     calls(
//                       text: "Unsucessful Call",
//                     ),
//                   ],
//                 ),
//                 // Container(
//                 //   height: 80,
//                 //   width: 50,
//                 //   child: Row(
//                 //     crossAxisAlignment:
//                 //     CrossAxisAlignment.start,
//                 //     children: [
//                 //       Padding(
//                 //         padding: const EdgeInsets.all(8.0),
//                 //         child: CircularPercentIndicator(
//                 //           radius: 50.0,
//                 //           lineWidth: 8.0,
//                 //           animation: true,
//                 //           animationDuration: 1200,
//                 //           percent: 0.8,
//                 //           circularStrokeCap:
//                 //           CircularStrokeCap.butt,
//                 //           center: const Text(
//                 //             "0%",
//                 //             style: TextStyle(
//                 //                 fontWeight: FontWeight.bold,
//                 //                 fontSize: 20.0),
//                 //           ),
//                 //           backgroundColor: const Color.fromARGB(
//                 //               255, 217, 221, 227),
//                 //           progressColor:
//                 //           Color.fromARGB(255, 15, 104, 131),
//                 //         ),
//                 //       ),
//                 //       Expanded(
//                 //         child: ListView(
//                 //           children: const [
//                 //             ListTile(
//                 //               title: Text(
//                 //                 ' 0',
//                 //                 style: TextStyle(
//                 //                     fontWeight: FontWeight.w500,
//                 //                     fontSize: 16.0),
//                 //               ),
//                 //               subtitle: Text(
//                 //                 'Target',
//                 //                 style: TextStyle(
//                 //                     fontWeight: FontWeight.bold,
//                 //                     fontSize: 12.0,
//                 //                     color: Colors.grey),
//                 //               ),
//                 //             ),
//                 //             ListTile(
//                 //               title: Text(
//                 //                 ' 0',
//                 //                 style: TextStyle(
//                 //                     fontWeight: FontWeight.w500,
//                 //                     fontSize: 16.0),
//                 //               ),
//                 //               subtitle: Text(
//                 //                 'Acheivement',
//                 //                 style: TextStyle(
//                 //                     fontWeight: FontWeight.bold,
//                 //                     fontSize: 12.0,
//                 //                     color: Colors.grey),
//                 //               ),
//                 //             )
//                 //           ],
//                 //         ),
//                 //       )
//                 //     ],
//                 //   ),
//                 // ),
//                 Column(
//                   children: [
//                     calls(text:  (Constants.value_increase ~/2).toString()),
//                     calls(text: "Call Made"),
//                   ],
//                 ),
//                 // Column(
//                 //   children: [
//                 //     calls(text: "0"),
//                 //     calls(text: "Time Spent"),
//                 //   ],
//                 // ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     ],
//   );
// }
//
// Widget activites({String text}) {
//   return Column(
//     children: [
//       Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Text(text),
//       ),
//     ],
//   );
// }
//
// Widget call() {
//   return Column(
//     children: [
//       Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   children: [
//                     calls(text: Get.find<OutletsController>().outletList.length.toString()),
//                     calls(
//                       text: "Total Call",
//                     ),
//                   ],
//                 ),
//                 Column(
//                   children: [
//                     calls(text:   (Constants.value_increase ~/2).toString(),
//                     ),
//                     calls(text: "Sucessfull Calls",ontap: (){
//                       Get.to(SalesReportPage());
//                     }),
//                   ],
//                 ),
//
//                 Column(
//                   children: [
//                     calls(text:  "${Get.find<OutletsController>().outletList.length -Constants.value_increase~/2}"
//                      ),
//                     calls(text: "Remaining Call"),
//                   ],
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     ],
//   );
//
//
// }


import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mobitrack_dv_flutter/controller/dashboard_Controller.dart';
import 'package:mobitrack_dv_flutter/controller/outlets_controller.dart';
import 'package:mobitrack_dv_flutter/controller/products_controller.dart';
import 'package:mobitrack_dv_flutter/controller/routes_controller.dart';
import 'package:mobitrack_dv_flutter/model/dashboard.dart';
import 'package:mobitrack_dv_flutter/view/attendance/show_attendance.dart';
import 'package:mobitrack_dv_flutter/view/dashboard.dart';
import 'package:mobitrack_dv_flutter/view/report/sales_report_page.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import '../../controller/auth_controller.dart';
import '../../controller/check_controller.dart';
import '../../controller/database_controller.dart';
import '../../controller/location_controller.dart';
import '../../controller/preference_controller.dart';
import '../../controller/sales_report_controller.dart';
import '../../model/check_in_out.dart';
import '../../model/routes.dart';
import '../../utils/constants.dart';
import '../../utils/pdf_api.dart';
import '../../utils/utilities.dart';
import '../report/sales_report_pdf_generator.dart';
import '../totalcostreport.dart';
import '../view_distributor.dart';
import 'package:flutter/material.dart';



class ScoreBoard extends StatefulWidget {

  @override
  State<ScoreBoard> createState() => _ScoreBoardState();
}

class _ScoreBoardState extends State<ScoreBoard> {
  var product =  Get.lazyPut<ProductsController>(() => ProductsController());
  var checkin = Get.lazyPut(()=>CheckController());

  var saleproduct = Get.lazyPut(()=>SalesReportController());

  List<Routes> route = [];

  var dashboard = Get.lazyPut(()=>DashBoard_Controller());

  var selectedRoute = Routes();
  //Double achivemednt = Get.find<>

  var user = Get.find<AuthController>().user;
  var outleresss =Get.lazyPut(()=>OutletsController());
  TimeOfDay noonTime = TimeOfDay(hour: 0, minute: 0); // 3:00 P
//  DateTime dt1 = DateTime.parse(Get.find<CheckController>().checkin.first.checkinDeviceTime. toString());
 // DateTime a = DataTime(Get.find<CheckController>().checkin.first.checkinDeviceTime);
  DateTime b = DateTime.now();
  bool _isLoading = true;
  List<Routes> _journals = [];
 // String Percentage = (double.parse(Get.find<DashBoard_Controller>().dashboard.first.achivement * 100 ) / double.parse(Get.find<DashBoard_Controller>().dashboard.first.target_value)).toString();

  String checkInId = "";
    DatabaseHelper? _databasehelper;

  @override
  void initState() {
    super.initState();

    _refreshJournals(); // Loading the diary when the app starts
  }

  void _refreshJournals() async {
    final data = await DatabaseHelper. getItemsm();
    setState(() {
      _journals = data;
      _isLoading = false;
    });
  }
  @override
  Widget build(BuildContext context) {

    //Duration difference =  dt1.difference(b);
    press() async{
      var location = Get.find<LocationController>();
      //  workManagerInitialization();
      var conn = await Utilities.isInternetWorking();
      if (conn) {
        // Test if location services are enabled.
        // serviceEnabled =
        // await Geolocator.isLocationServiceEnabled();
        // if (!serviceEnabled) {
        //   return Utilities.showInToast(
        //       'Location services are disabled.',
        //       toastType: ToastType.ERROR);
        // }
        // check for permission
        // permission = await Geolocator.checkPermission();
        // if (permission == LocationPermission.denied ||
        //     permission ==
        //         LocationPermission.deniedForever) {
        //   Utilities.showInToast(
        //       "Location permission is denied, Please enable permission for future use",
        //       toastType: ToastType.ERROR);
        //   // request permission
        //   permission = await Geolocator.requestPermission();
        //   if (permission == LocationPermission.denied ||
        //       permission ==
        //           LocationPermission.deniedForever) {
        // Permissions are denied,
        //     return Utilities.showInToast(
        //         "Location permission is denied, Please enable permission for future use",
        //         toastType: ToastType.ERROR);
        //   }
        // }
        await Get.find<LocationController>()
            .getCurrentPosition();
        if (location.userPosition != null) {
          var resp = await checkInAPI(
              location.userPosition!.latitude.toString(),
              location.userPosition!.longitude.toString());
          if (resp.success!) {
            //  location.startLocationService();
            Get.find<PreferenceController>()
                .setCheckInValue(true,
                checkInId: resp.response.toString());
            Constants.checkInOut = resp.response.toString();
            checkInId = resp.response.toString();
            print(location.userPosition!.latitude.toString());
            print(location.userPosition!.longitude.toString());
          //  Get.to(() => DashBoard());

          } else {
            Utilities.showInToast(resp.message!,
                toastType: ToastType.ERROR);
          }
        } else {
          Utilities.showInToast(
              "Could not get your location",
              toastType: ToastType.ERROR);
        }
      } else {
        Utilities.showInToast(
            'Please connect to the internet to check in!',
            toastType: ToastType.ERROR);
      }
    }
    showAlertDialog( BuildContext context ) {
      // set up the buttons
      Widget cancelButton = TextButton(
        child: Text("Cancel"),
        onPressed:  () {
          Get.back();
        },
      );
      Widget continueButton = TextButton(
        child: Text("Exit"),
        onPressed:  () async {
          SystemNavigator.pop();
        },
      );
      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: Text("Exit"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(" Are you sure to Exit ? "),
            ],
          ),
        ),
        actions: [
          cancelButton,
          continueButton,
        ],
      );
      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }
    // void getAllData() async  {
    //   var noteMapList = await DatabaseHelper.instance.getAllSalesData();
    //   //   note = Get.find<OutletsController>().outletLists.where((element) => element.id == item).first.name.toString();
    //   setState(() {
    //     sales = noteMapList;
    //   });
    // }
    return   WillPopScope(
      onWillPop: () async
      {
        showAlertDialog(context);
        //SystemNavigator.pop();
      //  Get.back();
        return true;
      },
      child: Scaffold(
          body:   Constants.selectmyRoute   == null?
          GetBuilder<Routecontroller>(
            builder: (routecontroller) {
              return Container(
                  child: Card(
                    child: InkWell(
                      onTap: (){},
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text('Please Select The Routes'),
                            ),
                            ElevatedButton(
                                style:  ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(Colors.black),
                                ),
                                onPressed: (){
                                  // setState(() {
                                   Get.to(()=> View_route());
                                    // Constants.selectedRoute =  Get.find<Routecontroller>().routeList.first;
                                    // press();
                            //      });
                                //  if(_journals.first.isNotEmpty){}
                                 // print(Constants.selectedRoute.id);
                                  //print( Get.find<Routecontroller>().routeList.first.id);
                                  // selectedRoute =  Get.find<Routecontroller>().routeList.first;
                                  //
                                  // Constants.selectedRoute =  Get.find<Routecontroller>().routeList.first;
                                  // Constants.salesoficer_id= user.id.toString();
                                  // // _selectedIndex.value = index;
                                  // Get.find<OutletsController>().fetchOutlets();
                                  // print(Constants.selectedDistributor);
                                  // Constants.selectmyRoute =  Get.find<Routecontroller>().routeList.first.routename;
                                  // Utilities.showInToast(
                                  //     "Route : ${selectedRoute.routename}");
                                  // Get.back() ;
                                    // if(_journals.first.day == Get.find<Routecontroller>().routeList.first.day){
                                    //   Get.to(()=> DashBoards());
                                    // //  print(_journals.first.routename);
                                    //   selectedRoute = _journals.first;
                                    //
                                    //   Constants.selectedRoute = _journals.first;
                                    //   Constants.salesoficer_id= user.id.toString();
                                    //   // _selectedIndex.value = index;
                                    //   Get.find<OutletsController>().fetchOutlets();
                                    //   print(Constants.selectedDistributor);
                                    //   Constants.selectmyRoute = _journals.first.routename ;
                                    //   Utilities.showInToast(
                                    //       "Route : ${selectedRoute.routename}");
                                    //   Get.back() ;
                                    // }else{
                                    //   Get.to(()=> View_route());
                                    //   DatabaseHelper.instance.deleteSyncedroute();
                                    // }
                                    print(DayPeriod.am);
                               //   setState(() {

                               //   });
                                  // Get.find<PreferenceController>()
                                  //     .setDistributor(jsonEncode(Constants.selectedDistributor));

                                 // Get.to(()=> View_route());
                                },child: Text("Route")),
                          ],
                        ),
                      ),
                    ),
                  )
                // Column(
                //   children: [
                //     Text("Select Route"),
                //     ElevatedButton(onPressed: (){
                //       setState(() {
                //         Get.to(()=> View_route());
                //       });
                //     }, child: Text("Route"))
                //   ],
                // ),
              );
            }
          ):
          RefreshIndicator(
            onRefresh:() async {
              await Future.delayed(Duration(seconds: 2));
              Get.find<DashBoard_Controller>().fetchdashboard();
            },
            child: SingleChildScrollView(
              child: GetBuilder<DashBoard_Controller>(
                builder: (context) {
                  return Get.find<DashBoard_Controller>().dashboard == null || Get.find<DashBoard_Controller>().dashboard.isEmpty ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Loading.."),
                    ],
                  ):
                    Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              side: BorderSide(color: Colors.black)
                          ),
                            elevation: 10,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        alignment: AlignmentDirectional.center,
                                        child:   Text(
                                          Constants.selectmyRoute!,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 30.0,
                                              color: Color.fromARGB(255, 80, 79, 79)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(color: Colors.black)
                          ),
                            elevation: 10,
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top:Get.size.height * 0.02,left:Get.size.height * 0.03 ),
                                  child: Container(
                                    alignment: AlignmentDirectional.topStart,
                                    child: const Text(
                                      'Calls',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15.0,
                                          color: Color.fromARGB(255, 80, 79, 79)),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 80,
                                  child: call(),
                                ),
                              ],
                            )),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Card(
                      //       elevation: 10,
                      //       child: Column(
                      //         children: [
                      //           Padding(
                      //             padding: const EdgeInsets.all(8.0),
                      //             child: Container(
                      //               alignment: AlignmentDirectional.topStart,
                      //               child: const Text(
                      //                 'ACTIVITY',
                      //                 style: TextStyle(
                      //                     fontWeight: FontWeight.w600,
                      //                     fontSize: 15.0,
                      //                     color: Color.fromARGB(255, 80, 79, 79)),
                      //               ),
                      //             ),
                      //           ),
                      //           SizedBox(
                      //             height: 90,
                      //             child: activity(),
                      //           ),
                      //         ],
                      //       )),
                      // ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(color: Colors.black)
                          ),
                          elevation: 10,
                          child: Column(
                            children: [
                              Container(
                                  height: Get.size.height * 0.4,
                                  width: 400,
                                  color: Colors.white,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          alignment: AlignmentDirectional.topStart,
                                          child: const Text('Productivity'),
                                        ),
                                      ),
                                      Container(
                                        height: 150,
                                        width: 300,
                                        child: Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: CircularPercentIndicator(
                                                radius: 130.0,
                                                lineWidth: 18.0,
                                                animation: true,
                                                animationDuration: 1200,
                                                percent: double.parse(Get.find<DashBoard_Controller>().dashboard.first.achivement.toString())/double.parse(Get.find<DashBoard_Controller>().dashboard.first.target_value!) > 1 ? 1 :
                                              double.parse(Get.find<DashBoard_Controller>().dashboard.first.achivement.toString())/double.parse(Get.find<DashBoard_Controller>().dashboard.first.target_value!) ,
                                                circularStrokeCap:
                                                CircularStrokeCap.butt,
                                                center:  Text((int.parse(Get.find<DashBoard_Controller>().dashboard.first.achivement.toString()) * 100  /
                                                    int.parse(Get.find<DashBoard_Controller>().dashboard.first.target_value!))
                                                    .toStringAsFixed(2) + "%",
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 20.0),
                                                ),
                                                backgroundColor: const Color.fromARGB(
                                                    255, 217, 221, 227),
                                                progressColor:
                                                Color.fromARGB(255, 15, 104, 131),
                                              ),
                                            ),
                                            Expanded(
                                              child: ListView(
                                                children:   [
                                                  ListTile(
                                                    title: Text(
                                              Get.find<DashBoard_Controller>().dashboard.first.target_value!.isNotEmpty
                                                  ? "0" :  Get.find<DashBoard_Controller>().dashboard.first.target_value!,
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.w500,
                                                          fontSize: 16.0),
                                                    ),
                                                    subtitle: Text(
                                                      'Target',
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 12.0,
                                                          color: Colors.grey),
                                                    ),
                                                  ),
                                                  ListTile(
                                                    title: Text(
                                                      Get.find<DashBoard_Controller>().dashboard.first.achivement.toString(),
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.w500,
                                                          fontSize: 16.0),
                                                    ),
                                                    subtitle: Text(
                                                      'Acheivement',
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 12.0,
                                                          color: Colors.grey),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      // Container(
                                      //   child: letters(),
                                      // )
                                    ],
                                  )),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(color: Colors.black)
                          ),
                          elevation: 10,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  alignment: AlignmentDirectional.topStart,
                                  child: const Text('ACTIVE OUTLET TARGET'),
                                ),
                              ),
                              SizedBox(
                                height: 190,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CircularPercentIndicator(
                                        radius: 130.0,
                                        lineWidth: 18.0,
                                        animation: true,
                                        animationDuration: 1200,
                                        percent:
                                        (double.parse(Get.find<DashBoard_Controller>().dashboard.first.productivityCall.toString())+
                                              double.parse(
                                            Get.find<DashBoard_Controller>().dashboard.first.unsuccessCall.toString()))
                                             /double.parse(Get.find<DashBoard_Controller>().dashboard.first.totalcall.toString()),
                                   //        > 1? 1:
                                        // double.parse(Get.find<DashBoard_Controller>().dashboard.first.productivityCall.toString())+
                                        //     (double.parse(
                                        //         Get.find<DashBoard_Controller>().dashboard.first.unsuccessCall.toString()))
                                        //   /double.parse(Get.find<DashBoard_Controller>().dashboard.first.totalcall.toString() ),
                                        // double.parse(Get.find<DashBoard_Controller>().dashboard.first.remainingcall.toString() +Get.find<DashBoard_Controller>().dashboard.first.remainingcall.toString())
                                        //     /double.parse(Get.find<DashBoard_Controller>().dashboard.first.totalcall.toString()) ,
                                        //100*100/double.parse( Get.find<DashBoard_Controller>().dashboard.first.target_value.toString()) ,
                                        circularStrokeCap: CircularStrokeCap.butt,
                                        center:   Text(
                                          "${((int.parse(Get.find<DashBoard_Controller>()
                                            .dashboard.first.productivityCall.toString())+ int.parse(  Get.find<DashBoard_Controller>().dashboard.first.unsuccessCall
                                            .toString()))*100/ int.parse(Get.find<DashBoard_Controller>().dashboard.first.totalcall.toString())).toStringAsFixed(2)} %",
                                            // Get.find<DashBoard_Controller>().dashboard.first.target_value
                                            //     == null ? "0" : (double.parse(Get.find<DashBoard_Controller>().dashboard.first.achivement.toString())~/double.parse(Get.find<DashBoard_Controller>()
                                            //     .dashboard.first.target_value)*100).toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.0),
                                        ),
                                        backgroundColor:
                                        const Color.fromARGB(255, 217, 221, 227),
                                        progressColor:
                                        Color.fromARGB(255, 15, 104, 131),
                                      ),
                                    ),
                                    Expanded(
                                      child: ListView(
                                        children:   [
                                          ListTile(
                                            title: Text(
                  ( Get.find<DashBoard_Controller>().dashboard.first.totalcall

                                                   == 0 ? 0 :  Get.find<DashBoard_Controller>().dashboard.first.totalcall).toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16.0),
                                            ),
                                            subtitle: Text(
                                              'Target',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12.0,
                                                  color: Colors.grey),
                                            ),
                                          ),
                                          ListTile(
                                            title: Text((int.parse(Get.find<DashBoard_Controller>().dashboard.first.unsuccessCall.toString()) + int.parse( Get.find<DashBoard_Controller>().dashboard.first.productivityCall.toString())).toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16.0),
                                            ),
                                            subtitle: Text(
                                              'Acheivement',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12.0,
                                                  color: Colors.grey),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                }
              ),
            ),
          )),
    )
    ;
  }

  Widget mycard({String? text}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(text!),
        ),
      ],
    );
  }
}

Widget calls({String? text,VoidCallback? ontap}) {
  return InkWell(
   onTap: ontap,
    child: Column(
      children: [

        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Text(text!,style: TextStyle(fontSize: 10),),
        ),
      ],
    ),
  );
}

// Widget activity() {
//   return Column(
//     children: [
//       Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   children: [
//                     calls(text: Get.find<DashBoard_Controller>().dashboard.first.unsuccessCall.toString()),
//
//                     calls(
//                       text: "Unsucessful Call",
//                     ),
//                   ],
//                 ),
//                 // Container(
//                 //   height: 80,
//                 //   width: 50,
//                 //   child: Row(
//                 //     crossAxisAlignment:
//                 //     CrossAxisAlignment.start,
//                 //     children: [
//                 //       Padding(
//                 //         padding: const EdgeInsets.all(8.0),
//                 //         child: CircularPercentIndicator(
//                 //           radius: 50.0,
//                 //           lineWidth: 8.0,
//                 //           animation: true,
//                 //           animationDuration: 1200,
//                 //           percent: 0.8,
//                 //           circularStrokeCap:
//                 //           CircularStrokeCap.butt,
//                 //           center: const Text(
//                 //             "0%",
//                 //             style: TextStyle(
//                 //                 fontWeight: FontWeight.bold,
//                 //                 fontSize: 20.0),
//                 //           ),
//                 //           backgroundColor: const Color.fromARGB(
//                 //               255, 217, 221, 227),
//                 //           progressColor:
//                 //           Color.fromARGB(255, 15, 104, 131),
//                 //         ),
//                 //       ),
//                 //       Expanded(
//                 //         child: ListView(
//                 //           children: const [
//                 //             ListTile(
//                 //               title: Text(
//                 //                 ' 0',
//                 //                 style: TextStyle(
//                 //                     fontWeight: FontWeight.w500,
//                 //                     fontSize: 16.0),
//                 //               ),
//                 //               subtitle: Text(
//                 //                 'Target',
//                 //                 style: TextStyle(
//                 //                     fontWeight: FontWeight.bold,
//                 //                     fontSize: 12.0,
//                 //                     color: Colors.grey),
//                 //               ),
//                 //             ),
//                 //             ListTile(
//                 //               title: Text(
//                 //                 ' 0',
//                 //                 style: TextStyle(
//                 //                     fontWeight: FontWeight.w500,
//                 //                     fontSize: 16.0),
//                 //               ),
//                 //               subtitle: Text(
//                 //                 'Acheivement',
//                 //                 style: TextStyle(
//                 //                     fontWeight: FontWeight.bold,
//                 //                     fontSize: 12.0,
//                 //                     color: Colors.grey),
//                 //               ),
//                 //             )
//                 //           ],
//                 //         ),
//                 //       )
//                 //     ],
//                 //   ),
//                 // ),
//                 Column(
//                   children: [
//                     calls(text:  (Constants.value_increase ~/2).toString()),
//                     calls(text: "Call Made"),
//                   ],
//                 ),
//                 // Column(
//                 //   children: [
//                 //     calls(text: "0"),
//                 //     calls(text: "Time Spent"),
//                 //   ],
//                 // ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     ],
//   );
// }

Widget activites({String? text}) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(text!),
      ),
    ],
  );
}

Widget call() {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    calls(text: Get.find<DashBoard_Controller>().dashboard.first.totalcall.toString()),
                    calls(
                      text: "Total Call",
                    ),
                  ],
                ),
                Column(
                  children: [
                    calls(text:   Get.find<DashBoard_Controller>().dashboard.first.productivityCall.toString(),
                      ontap: (){
                        Get.to(SalesReportPage());
                       // Get.to(()=> TotalCostReport());
                      }
                    ),
                    calls(text: "Sucessfull Calls",ontap: (){
                      Get.to(SalesReportPage());
                      //Get.to(()=> TotalCostReport());
                    }),
                  ],
                ),
                Column(
                  children: [
                    calls(text:   Get.find<DashBoard_Controller>().dashboard.first.unsuccessCall.toString(),
                    ),
                    calls(text: "Unsucessfull Calls",ontap: (){
                      Get.to(SalesReportPage());
                    }),
                  ],
                ),
                Column(
                  children: [
                    calls(text: Get.find<DashBoard_Controller>().dashboard.first.remainingcall.toString()
                    ),
                    calls(text: "Remaining Call",
                        ontap: (){
                          Get.to(SalesReportPage());
                        }),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}
