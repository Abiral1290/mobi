import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mobitrack_dv_flutter/controller/check_controller.dart';
import 'package:mobitrack_dv_flutter/controller/database_controller.dart';
import 'package:mobitrack_dv_flutter/controller/outlets_controller.dart';
import 'package:mobitrack_dv_flutter/controller/productbrand_controller.dart';
import 'package:mobitrack_dv_flutter/controller/sales_report_controller.dart';
import 'package:mobitrack_dv_flutter/model/outlet.dart';

import '../controller/routes_controller.dart';
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
  List<Sales> sales = [];
  DatabaseHelper? databaseHelper;
  bool _isLoading = true;
  List<Routes> _journals = [];
  var outletcontroller = Get.lazyPut(()=>OutletsController());
  var salescontroller = Get.lazyPut(()=>SalesReportController());

  @override
  void initState() {
    // TODO: implement initState
    _refreshJournals();
    setState(() {
      Get.find<OutletsController>().outletList!.length;

      //  print(  Get.find<ProductBrandController>().productList.elementAt().name);
      print(Get.find<SalesReportController>(). formattedSalesReportList!.length);
    });
    super.initState();
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
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(),
      body:

            // Column(
            //   children: [
            //     ElevatedButton(onPressed: (){
            //       var route = Routes(
            //         id: 3,
            //         routename: "sad"
            //       );
            //       DatabaseHelper.instance.insertroutes(route);
            //     //  print( _journals.length);
            //     }, child: Text("press")),
            //     ElevatedButton(onPressed: (){
            //
            //        print( _journals.length);
            //     }, child: Text("press")),

          //       ListView.builder(
          //         shrinkWrap: true,
          //       itemCount: _journals.length,
          //         itemBuilder: (context, index) {
          //       return ListTile(
          //         title: Text(_journals[index].routename.toString()),
          //       );
          // }),
                GetBuilder<SalesReportController>(builder: (context){
                  return ListView.builder(
                    itemCount:  Get.find<SalesReportController>().formattedSalesReportList!.length,
                      itemBuilder:(context, index) {
                      var items = Get.find<SalesReportController>().formattedSalesReportList![index];
                    return Text(Get.find<OutletsController>().outletList!.where((element) => element.id == items.outletId).toList().first.name!
                    );
                  });
                })
            //   ],
            // )
    );


      // GetBuilder<ProductBrandController>(
      //   builder: (context) {
      //     return Container(
      //       child:  ListView.builder(
      //         itemCount: Get.find<ProductBrandController>().localSalesList.length,
      //           itemBuilder: (context, index) {
      //             var item =Get.find<ProductBrandController>().localSalesList[index];
      //         return ListTile(
      //
      //
      //           title: Text(item.total_cost.toString() == null ? "32": item.total_cost.toString()));
      //
      //
      //       }));
      //   }
      // ),

  }


}