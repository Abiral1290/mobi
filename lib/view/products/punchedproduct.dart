

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobitrack_dv_flutter/controller/database_controller.dart';
import 'package:mobitrack_dv_flutter/controller/preference_controller.dart';
import 'package:mobitrack_dv_flutter/controller/productbrand_controller.dart';
import 'package:mobitrack_dv_flutter/model/products.dart';
import 'package:mobitrack_dv_flutter/model/punched.dart';
import 'package:mobitrack_dv_flutter/utils/constants.dart';

import '../../controller/location_controller.dart';
import 'package:collection/collection.dart';

import '../../model/outlet.dart';
import '../../utils/utilities.dart';

class PunchedProduct extends StatefulWidget{
 // List<String> punched;
  Outlet outlet;
  List<String> brand;
  PunchedProduct ({Key key,this.outlet,this.brand}) : super(key: key);

  @override
  State<PunchedProduct> createState() => _PunchedProductState();
}

class _PunchedProductState extends State<PunchedProduct> {
  var selectedProduct = [].obs;

  int calculator = 0;


  @override
  void initState() {
    // TODO: implement initState
    setState(() {
    //  calculate.obs;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    Widget buildBatchTile( ) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(


            children: [   Card(
              child: Container(

                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                     ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child:   Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Gross Total:  ${Get.find<ProductBrandController>().punched_product.fold(0, (previousValue, element) => previousValue + element.Cost)}"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Total with VAT: ${Get.find<ProductBrandController>().punched_product.fold(0, (previousValue, element) => ((previousValue + element.Cost* 13) ~/100)+ previousValue + element.Cost)}"),
                      ),

                    ],
                  ),
                ),
              ),
              margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0),
            ),
              // Row(
              //   children: [
              //     Text("Gross Total:  ${Get.find<ProductBrandController>().punched_product.fold(0, (previousValue, element) => previousValue + element.Cost)}"),
              //     Spacer(),
              //     // Text(
              //     //   DateFormat.yMEd()
              //     //       .format(DateTime.parse(batches.manufacturedAt)),
              //     //   style: contentStyle
              //     // ),
              //   ],
              // ),
              // Row(
              //   children: [
              //     Text("Total with VAT ${Get.find<ProductBrandController>().punched_product.fold(0, (previousValue, element) => ((previousValue + element.Cost* 13) ~/100)+ previousValue + element.Cost)}"),
              //     Spacer(),
              //     // Text(
              //     //   DateFormat.yMEd().format(DateTime.parse(batches.expiredAt)),
              //     //   style: contentStyle,
              //     // ),
              //   ],
              // ),
              // ElevatedButton(
              //   onPressed: () {
              //     showQuantityBottomSheet(
              //       batches.id.toString(), );
              //   },
              //   child: Text("Sell"),
              // ),
            ],
          ),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () async {
          selectedProduct.add({
            "product_id": Get.find<ProductBrandController>().selectedunits,
            "batch_id": "",
            "quantity": Get.find<ProductBrandController>().quantity,
            "discount": "0"
          });
          print(selectedProduct);
          var conn = await Utilities.isInternetWorking();
          if(conn){
            showDialog(
                barrierDismissible: true,context: context,
                builder: (context) {
                  return CupertinoAlertDialog(
                    title: Text('Please Wait'),
                    content: Column(
                      children: [
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Adding new Product'
                          ),
                        ),
                        CupertinoActivityIndicator(
                          radius: 17,
                        )
                      ],
                    ),
                  );
                });
            var location = Get.find<LocationController>();
            var sales = Sales(
              route: Constants.selectedRoute.id.toString(),
              orders: jsonEncode(selectedProduct),
              soldAt:
              DateTime.now().toString(),
              remark: "",
              outletId: widget.outlet.id.toString(),
              latitude:  location.userPosition.latitude.toString(),
              longitude:   location.userPosition.longitude.toString(),
            );
            print(sales);
            var response = await sellProductApi(sales);
            Utilities.showInToast(response.message,
                toastType: response.success
                    ? ToastType.SUCCESS
                    : ToastType.ERROR);
            Get.find<ProductBrandController>().punched_product.clear();
         //   Get.find<ProductBrandController>().selectedAreaId.clear();
            Get.find<ProductBrandController>().quantity.clear();
            Get.find<ProductBrandController>().selectedunits.clear();
            selectedProduct.clear();
            Get.back();Get.back();
          }else{
            if(selectedProduct == null){
              Utilities.showInToast("No Product");
            }
          }
         // punched.remove();
          },
        child:  Icon(Icons.arrow_forward),
      ),
      body:  Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
      //    ElevatedButton(onPressed: (){print(Get.find<ProductBrandController>().calculate);}, child: Text("press")),

          Card(
            child: Container(

              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: GetBuilder<ProductBrandController>(builder: (builder){
                  return   ListView.builder(
                      shrinkWrap: true,
                      itemCount: Get.find<ProductBrandController>().punched_product.length,
                      itemBuilder: (context, index) {
                        var item =  Get.find<ProductBrandController>().punched_product[index];
                        var sum = Get.find<ProductBrandController>().punched_product.fold(0, (previousValue, element) => previousValue + element.Cost);
                        return ListTile(
                            title: Text(item.Name),
                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Pcs: ${item.quantity.toString()}"),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Total cost: ${item.Cost}"),
                                )
                              ],
                            )
                        );
                      });
                }),
              ),
            ),
            margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0),
          ),
          // Container(
          //   child: GetBuilder<ProductBrandController>(builder: (builder){
          //     return   ListView.builder(
          //         shrinkWrap: true,
          //         itemCount: Get.find<ProductBrandController>().punched_product.length,
          //         itemBuilder: (context, index) {
          //           var item =  Get.find<ProductBrandController>().punched_product[index];
          //            var sum = Get.find<ProductBrandController>().punched_product.fold(0, (previousValue, element) => previousValue + element.Cost);
          //           return ListTile(
          //             title: Text(item.Name),
          //             subtitle: Row(
          //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //               children: [
          //                 Text(item.quantity.toString()),
          //                 Text("Total cost ${item.Cost}")
          //               ],
          //             )
          //           );
          //         });
          //   }),
          //
          //
          //   ),
          Container(
            child: buildBatchTile(),
          )
        ],
      ),
      );
      // ListView.builder(
      //   itemCount:  role.length,
      //     itemBuilder: (context, index) {
      //     return ListTile(
      //       title:  role[index],
      //     );
      // })
  }
}