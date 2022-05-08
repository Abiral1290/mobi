import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mobitrack_dv_flutter/controller/outlets_controller.dart';
import 'package:mobitrack_dv_flutter/controller/products_controller.dart';
import 'package:mobitrack_dv_flutter/view/attendance/show_attendance.dart';
import 'package:mobitrack_dv_flutter/view/report/sales_report_page.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../../controller/sales_report_controller.dart';
import '../../utils/constants.dart';
import '../../utils/pdf_api.dart';
import '../report/sales_report_pdf_generator.dart';
import '../view_distributor.dart';



class ScoreBoard extends StatelessWidget {
  var product =  Get.lazyPut<ProductsController>(() => ProductsController());
  var saleproduct = Get.lazyPut(()=>SalesReportController());
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
          body:   Constants.selectmyRoute == null?
          Container(
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

                                Get.to(()=> View_route());

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
          ):
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
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
                                    Constants.selectmyRoute,
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
                      elevation: 10,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
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
                            height: 90,
                            child: call(),
                          ),
                        ],
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                      elevation: 10,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              alignment: AlignmentDirectional.topStart,
                              child: const Text(
                                'ACTIVITY',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15.0,
                                    color: Color.fromARGB(255, 80, 79, 79)),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 90,
                            child: activity(),
                          ),
                        ],
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 10,
                    child: Column(
                      children: [
                        Container(
                            height: 280,
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
                                          percent: 0.8,
                                          circularStrokeCap:
                                          CircularStrokeCap.butt,
                                          center:  Text(
                                          (Get.find<OutletsController>().outletList.length / Constants.value_increase).toString(),
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
                                          children: const [
                                            ListTile(
                                              title: Text(
                                                ' 0',
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
                                                ' 0',
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
                                Container(
                                  child: letters(),
                                )
                              ],
                            )),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
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
                                  percent: 0.3,
                                  circularStrokeCap: CircularStrokeCap.butt,
                                  center:   Text(
    (Constants.value_increase ~/2).toString(),
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
                                        Get.find<OutletsController>().outletList.length.toString(),
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
                                        '0',
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
                              MaterialButton(
                                onPressed: () async {
                                  print(Get.find<SalesReportController>().formattedSalesReportList.length);
                                  print(Constants.selectedRoute.routename);
                                  final pdfFile = await PdfParagraphApi.generate(
                                      Get.find<SalesReportController>().formattedSalesReportList ,
                                      distributor: Constants.selectedRoute);
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
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ))
    ;
  }

  Widget mycard({String text}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(text),
        ),
      ],
    );
  }

  Widget letters() {
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
                      mycard(text: "0"),
                      mycard(
                        text: "Total orders",
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      mycard(text: "0"),
                      mycard(text: "Total invoiced"),
                    ],
                  ),
                  Column(
                    children: [
                      mycard(text: "0"),
                      mycard(text: "Total returns"),
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
}

Widget calls({String text,VoidCallback ontap}) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(text),
      ),
    ],
  );
}

Widget activity() {
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
                    calls(text: Constants.increase_unsucessfulcall.toString()),
                    calls(
                      text: "Remaining Calls",
                    ),
                  ],
                ),
                // Container(
                //   height: 80,
                //   width: 50,
                //   child: Row(
                //     crossAxisAlignment:
                //     CrossAxisAlignment.start,
                //     children: [
                //       Padding(
                //         padding: const EdgeInsets.all(8.0),
                //         child: CircularPercentIndicator(
                //           radius: 50.0,
                //           lineWidth: 8.0,
                //           animation: true,
                //           animationDuration: 1200,
                //           percent: 0.8,
                //           circularStrokeCap:
                //           CircularStrokeCap.butt,
                //           center: const Text(
                //             "0%",
                //             style: TextStyle(
                //                 fontWeight: FontWeight.bold,
                //                 fontSize: 20.0),
                //           ),
                //           backgroundColor: const Color.fromARGB(
                //               255, 217, 221, 227),
                //           progressColor:
                //           Color.fromARGB(255, 15, 104, 131),
                //         ),
                //       ),
                //       Expanded(
                //         child: ListView(
                //           children: const [
                //             ListTile(
                //               title: Text(
                //                 ' 0',
                //                 style: TextStyle(
                //                     fontWeight: FontWeight.w500,
                //                     fontSize: 16.0),
                //               ),
                //               subtitle: Text(
                //                 'Target',
                //                 style: TextStyle(
                //                     fontWeight: FontWeight.bold,
                //                     fontSize: 12.0,
                //                     color: Colors.grey),
                //               ),
                //             ),
                //             ListTile(
                //               title: Text(
                //                 ' 0',
                //                 style: TextStyle(
                //                     fontWeight: FontWeight.w500,
                //                     fontSize: 16.0),
                //               ),
                //               subtitle: Text(
                //                 'Acheivement',
                //                 style: TextStyle(
                //                     fontWeight: FontWeight.bold,
                //                     fontSize: 12.0,
                //                     color: Colors.grey),
                //               ),
                //             )
                //           ],
                //         ),
                //       )
                //     ],
                //   ),
                // ),
                Column(
                  children: [
                    calls(text:  (Constants.value_increase ~/2).toString()),
                    calls(text: "Call Made"),
                  ],
                ),
                // Column(
                //   children: [
                //     calls(text: "0"),
                //     calls(text: "Time Spent"),
                //   ],
                // ),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

Widget activites({String text}) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(text),
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
                    calls(text: Get.find<OutletsController>().outletList.length.toString()),
                    calls(
                      text: "Total Call",
                    ),
                  ],
                ),
                Column(
                  children: [
                    calls(text:   (Constants.value_increase ~/2).toString(),
                    ),
                    calls(text: "Sucessfull Calls",ontap: (){
                      Get.to(SalesReportPage());
                    }),
                  ],
                ),

                Column(
                  children: [
                    calls(text:  "${Get.find<OutletsController>().outletList.length -Constants.value_increase~/2}"
                     ),
                    calls(text: "Remaining Call"),
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
