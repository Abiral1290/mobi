import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mobitrack_dv_flutter/controller/database_controller.dart';
import 'package:mobitrack_dv_flutter/controller/outlets_controller.dart';
import 'package:mobitrack_dv_flutter/controller/productbrand_controller.dart';

import '../model/products.dart';
import '../model/routes.dart';

class TotalCostReport extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _totalCost();
  }
}

class _totalCost extends State<TotalCostReport>{

  var productcontroller = Get.lazyPut(()=>ProductBrandController());
  List<Routes> sales = [];
  DatabaseHelper databaseHelper;
  var item ;
  var note;

  // void getAllData() async  {
  //   var noteMapList = await DatabaseHelper.instance.getAllSalesData();
  //  //   note = Get.find<OutletsController>().outletLists.where((element) => element.id == item).first.name.toString();
  //   setState(() {
  //     sales = noteMapList;
  //   });
  // }
  void getAllData() async  {
    var noteMapList = await DatabaseHelper.instance.getroute();
    //   note = Get.find<OutletsController>().outletLists.where((element) => element.id == item).first.name.toString();
    setState(() {
      sales = noteMapList;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllData();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: ElevatedButton(
          onPressed: (){
            print(sales.length);
          },
        ),
      ),
      body:
      // FutureBuilder(
      //   future: Get.find<ProductBrandController>().getAlltotalproduct(),
      //   builder: (context, AsyncSnapshot snapshot){
      //     return snapshot.data ?
      //       ListView.builder(
      //       itemCount: snapshot.data.length,
      //         itemBuilder: (context, index) {
      //       return ListTile(
      //         title: Text(snapshot.data[index].toString()),
      //       );
      //     }): Center(child: CircularProgressIndicator(),);
      //   },
      // )
          SingleChildScrollView(
            child: Container(
              height: Get.size.height,
              width: Get.size.width,
              child:  Column(
                children: [
                  Table(
                    border:  TableBorder.symmetric(inside: BorderSide(width: 1, color: Colors.blue), outside: BorderSide(width: 1)),
                    columnWidths: {
                      0: FractionColumnWidth(0.34),
                      1: FractionColumnWidth(0.28),
                    },
                    children: [
                      TableRow(
                          children: [
                            //'Product', 'Outlet', 'Quantity', 'Discount %',"Remark",
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Outlet',textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Total Cost',textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold)),
                            ),
                          ]
                      )
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: sales.length == null ? 0: sales.length ,
                        itemBuilder: (context, index) {
                          var item = sales[index].routename;
                      return
                        Column(
                          children: [
                            Table (
                              border:   TableBorder.symmetric(inside: BorderSide(width: 1, color: Colors.blue), outside: BorderSide(width: 1)),
                              columnWidths: {
                                0: FractionColumnWidth(0.34),
                                1: FractionColumnWidth(0.28),

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
                                        child: Text(  sales[index].id.toString()
                          ),),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(sales[index].routename.toString()),
                                      ),
                                      // Padding(
                                      //   padding: const EdgeInsets.all(8.0),
                                      //   child: Text( sales[index].orders.toString(),textAlign: TextAlign.center),
                                      // ),

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
                    //    Text(note ),
                    //         Text(sales[index].orders.toString() ),
                    //         Text(sales[index].route.toString()),
                          ],
                        );
                        //title: Text(sales[index].outletId.toString() ));
                    }),
                  ),
                ],
              )),
          )
      );
  }

}