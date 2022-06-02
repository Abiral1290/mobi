

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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
  Map<String, dynamic> maps;

  int calculator = 0;
  var item;
  DatabaseHelper databaseHelper;


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
    showAlertDialog( BuildContext context ) {

      // set up the buttons
      Widget cancelButton = TextButton(
        child: Text("Cancel"),
        onPressed:  () {
          Get.back();
        },
      );
      Widget continueButton = TextButton(
        child: Text("Continue"),
        onPressed:  () async {
          var conn = await Utilities.isInternetWorking();
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return CupertinoAlertDialog(
                  title: Text('Please Wait'),
                  content: Column(
                    children: [
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(conn
                            ? 'Registering new Sales Outlet'
                            : 'Saving offline'),
                      ),
                      CupertinoActivityIndicator(
                        radius: 17,
                      )
                    ],
                  ),
                );
              });
          Get.find<ProductBrandController>().punched_product.removeWhere((e)=> e = item);
        },
      );

      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: Text("Delete"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(" Are you sure on deleting ? "),
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () async {

          for(int i = 0 ; i < Get.find<ProductBrandController>().selectedunits.length; i++){
            selectedProduct.add({
              "product_id": Get.find<ProductBrandController>().selectedunits[i],
              "batch_id": "",
              "quantity": Get.find<ProductBrandController>().quantity[i],
              "discount": "2"
            });
          }

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
              outlet_name: widget.outlet.name.toString(),
              orders: jsonEncode(selectedProduct),
              total_cost :item.Cost.toString(),
              soldAt:
              DateTime.now().toString(),
              remark: "",
              outletId: widget.outlet.id.toString(),
              latitude:  location.userPosition.latitude.toString(),
              longitude:   location.userPosition.longitude.toString(),
            );
            // var sell = Sales(
            //   soldAt: DateTime.now().toString(),
            //   orders: "0",
            //   outletId: widget.outlet.id.toString(),
            //   total_cost: item.Cost,
            //   //id:  int.parse(DateTime.now().toString()),
            //   remark: "0",
            //   latitude:  location.userPosition.latitude.toString(),
            //   longitude:   location.userPosition.longitude.toString(),
            //   route:  Constants.selectedRoute.id.toString()
            // );
            print(sales);
            print(item.Cost);
            var conn = await Utilities.isInternetWorking();
            if(conn){
              var response = await sellProductApi(sales);
              Utilities.showInToast(response.message,
                  toastType: response.success
                      ? ToastType.SUCCESS
                      : ToastType.ERROR);
            //  Get.find<ProductBrandController>().selectedunits.clear();
            }else{
              Get.find<ProductBrandController>().storeSalesOffline(sales);
              Utilities.showInToast('Storing Offline',
                  toastType: ToastType.INFO);
            }
           // var response = await sellProductApi(sales);
           // databaseHelper.insertSales(sales);
            // Get.find<ProductBrandController>().storeSalesOffline(sales);
            Get.find<ProductBrandController>().punched_product.clear();
            Get.find<ProductBrandController>().selectedAreaId.clear();
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
            child: Slidable(
              startActionPane: ActionPane(
                // A motion is a widget used to control how the pane animates.
                motion: const ScrollMotion(),

                // A pane can dismiss the Slidable.
                dismissible: DismissiblePane(onDismissed: () {
                //  showAlertDialog(context,item.id);
                }),
                // All actions are defined in the children parameter.
                children: [
                  // A SlidableAction can have an icon and/or a label.
                  SlidableAction(
                    onPressed:(text){
                      showAlertDialog(context);
                    },
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: 'Delete ',
                  ),

                ],
              ),
               endActionPane: const ActionPane(
                 motion: ScrollMotion(),
                children: [
                   SlidableAction(
                     onPressed: null,
                     backgroundColor: Color(0xFF21B7CA),
                     foregroundColor: Colors.white,
                     icon: Icons.edit,
                     label: 'Edit',
                   ),
                   // SlidableAction(
                   //   onPressed: null,
                   //   backgroundColor: Color(0xFF0392CF),
                   //   foregroundColor: Colors.white,
                   //   icon: Icons.save,
                   //   label: 'Save',
                   // ),
                 ],
               ),
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
                           item =  Get.find<ProductBrandController>().punched_product[index];
                          var sum = Get.find<ProductBrandController>().punched_product.fold(0, (previousValue, element) => previousValue + element.Cost);
                          return Slidable(
                            startActionPane: ActionPane(
                              // A motion is a widget used to control how the pane animates.
                              motion: const ScrollMotion(),

                              // A pane can dismiss the Slidable.
                              dismissible: DismissiblePane(onDismissed: () {
                                //  showAlertDialog(context,item.id);
                              }),
                              // All actions are defined in the children parameter.
                              children: [
                                // A SlidableAction can have an icon and/or a label.
                                SlidableAction(
                                  onPressed:(text){setState(() {
                                    Get.find<ProductBrandController>().punched_product.removeAt(index);
                                  });
                                  //  showAlertDialog(context);
                                  },
                                  backgroundColor: Colors.black,
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete,
                                  label: 'Delete ',
                                ),

                              ],
                            ),
                            endActionPane:   ActionPane(
                              motion: ScrollMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (text){
                                    showAlertDialog(context);
                                  },
                                  backgroundColor: Color(0xFF21B7CA),
                                  foregroundColor: Colors.white,
                                  icon: Icons.edit,
                                  label: 'Edit',
                                ),

                                // SlidableAction(
                                //   onPressed: null,
                                //   backgroundColor: Color(0xFF0392CF),
                                //   foregroundColor: Colors.white,
                                //   icon: Icons.save,
                                //   label: 'Save',
                                // ),
                              ],
                            ),
                            child: ListTile(
                              onLongPress: (){
                                // Widget cancelButton = TextButton(
                                //   child: Text("Cancel"),
                                //   onPressed:  () {
                                //     Get.back();
                                //   },
                                // );
                                // Widget continueButton = TextButton(
                                //   child: Text("Continue"),
                                //   onPressed:  () async {
                                //     var conn = await Utilities.isInternetWorking();
                                //     showDialog(
                                //         barrierDismissible: false,
                                //         context: context,
                                //         builder: (context) {
                                //           return CupertinoAlertDialog(
                                //             title: Text('Please Wait'),
                                //             content: Column(
                                //               children: [
                                //                 Divider(),
                                //                 Padding(
                                //                   padding: const EdgeInsets.all(8.0),
                                //                   child: Text(conn
                                //                       ? 'Registering new Sales Outlet'
                                //                       : 'Saving offline'),
                                //                 ),
                                //                 CupertinoActivityIndicator(
                                //                   radius: 17,
                                //                 )
                                //               ],
                                //             ),
                                //           );
                                //         });
                                //     Get.find<ProductBrandController>().punched_product.removeWhere((e)=> e = item);
                                //   },
                                // );
                                // setState(() {
                                //   AlertDialog alert = AlertDialog(
                                //     title: Text("Delete"),
                                //     content: SingleChildScrollView(
                                //       child: Column(
                                //         mainAxisAlignment: MainAxisAlignment.start,
                                //         children: [
                                //           Text(" Are you sure on Editing ? "),
                                //           TextField(),
                                //           TextField(),
                                //         ],
                                //       ),
                                //     ),
                                //     actions: [
                                //       cancelButton,
                                //       continueButton,
                                //     ],
                                //   );
                                // });

              //                 setState(() {
              //
              // Get.find<ProductBrandController>().punched_product.removeAt(index);
              //
              //                 });
                                // AlertDialog alert = AlertDialog(
                                //   title: Text("Delete"),
                                //   content: SingleChildScrollView(
                                //     child: Column(
                                //       mainAxisAlignment: MainAxisAlignment.start,
                                //       children: [
                                //         Text(" Are you sure on deleting ? "),
                                //
                                //       ],
                                //     ),
                                //   ),
                                //   actions: [
                                //     // cancelButton,
                                //     // continueButton,
                                //   ],
                                // );
                                showAlertDialog( ) {
                                  // set up the buttons
                                  // Widget cancelButton = TextButton(
                                  //   child: Text("Cancel"),
                                  //   onPressed:  () {
                                  //     Get.back();
                                  //   },
                                  // );
                                  // Widget continueButton = TextButton(
                                  //   child: Text("Continue"),
                                  //   onPressed:  () async {
                                  //     var conn = await Utilities.isInternetWorking();
                                  //     showDialog(
                                  //         barrierDismissible: false,
                                  //         context: context,
                                  //         builder: (context) {
                                  //           return CupertinoAlertDialog(
                                  //             title: Text('Please Wait'),
                                  //             content: Column(
                                  //               children: [
                                  //                 Divider(),
                                  //                 Padding(
                                  //                   padding: const EdgeInsets.all(8.0),
                                  //                   child: Text(conn
                                  //                       ? 'Registering new Sales Outlet'
                                  //                       : 'Saving offline'),
                                  //                 ),
                                  //                 CupertinoActivityIndicator(
                                  //                   radius: 17,
                                  //                 )
                                  //               ],
                                  //             ),
                                  //           );
                                  //         });
                                  //     setState(() {
                                  //       Get.find<ProductBrandController>().punched_product.removeAt(index);
                                  //     });
                                  //    // Get.find<ProductBrandController>().punched_product.removeWhere((e)=> e = item);
                                  //   },
                                  // );

                                  // set up the AlertDialog
                                //   AlertDialog alert = AlertDialog(
                                //     title: Text("Delete"),
                                //     content: SingleChildScrollView(
                                //       child: Column(
                                //         mainAxisAlignment: MainAxisAlignment.start,
                                //         children: [
                                //           Text(" Are you sure on deleting ? "),
                                //
                                //         ],
                                //       ),
                                //     ),
                                //     actions: [
                                //       // cancelButton,
                                //       // continueButton,
                                //     ],
                                //   );
                                //
                                //   // show the dialog
                                //   showDialog(
                                //     context: context,
                                //     builder: (BuildContext context) {
                                //       return alert;
                                //     },
                                //   );
                                 }
                              },
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
                            ),
                          );
                        });
                  }),
                ),
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