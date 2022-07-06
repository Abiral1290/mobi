import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mobitrack_dv_flutter/controller/outlets_controller.dart';
import 'package:mobitrack_dv_flutter/controller/products_controller.dart';
import 'package:mobitrack_dv_flutter/model/outlet.dart';
import 'package:mobitrack_dv_flutter/model/products.dart';
import 'package:mobitrack_dv_flutter/utils/constants.dart';
import 'package:mobitrack_dv_flutter/utils/utilities.dart';

import '../products/sell_products.dart';

class RemarkPage extends StatelessWidget {
//  final Outlet outlet;


  RemarkPage();

  TextEditingController outletTextController = TextEditingController();
  TextEditingController quantityTextController = TextEditingController();

  Sales sales = Sales();
  var product  = Get.lazyPut(()=>ProductsController());

  var selectedOutletlist = [].obs; //List<Map<String, String>>
  Map<String, String> selectedProducts = {};

  final TextStyle titleStyle = TextStyle(
    fontSize: 18,
  );
  final TextStyle contentStyle = TextStyle(
    fontSize: 17,
  );

  InputDecoration decoration(String labelText) {
    return InputDecoration(
      labelText: labelText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }

  String? validateDiscount(int value) {
    if (!(value >= 0) && !(value <= 100)) {
      return "Discount should be less than or equal to 100%";
    }
    return null;
  }

  void showQuantityBottomSheet(  String outletid) {
    String? addedremark;
    //String discountPercent = "0";
    Get.bottomSheet(
      Container(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: decoration("Add Quantity"),
                  onChanged: (quantity) {
                    addedremark= quantity;
                  },
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: Get.size.height * 0.01),

                ElevatedButton(
                  onPressed: () {
                    if (addedremark != null  ) {
                      selectedOutletlist.add({
                        "outlet_id": outletid,
                        "remarks": addedremark,
                      });
                      Get.find<OutletsController>().addoutletInList(outletid);
                    } else {
                      Utilities.showInToast("Please Provide your review");
                    }
                    Get.back();
                  },
                  child: Text("Add"),
                )
              ],
            ),
          )),
      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
      backgroundColor: Colors.white,
      enableDrag: true,
    );
  }

  void showInfoBottomSheet() {
    Get.bottomSheet(
      Container(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Selected Products",
                    style:
                    TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  IconButton(
                      icon: Icon(Icons.close), onPressed: () => Get.back()),
                ],
              ),
              selectedOutletlist.isEmpty
                  ? Center(
                child: Text("No Products"),
              )
                  : Obx(
                    () => Expanded(
                  child: ListView.builder(
                    itemCount: selectedOutletlist.length,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                selectedOutletlist
                                    .remove(selectedOutletlist[index]);
                              },
                              icon: Icon(Icons.delete)),
                          Expanded(
                            child: Text(
                              Get.find<OutletsController>()
                                  .outletList!
                                  .where((element) =>
                              element.id ==
                                  int.parse(selectedOutletlist[index]
                                      .values
                                      .elementAt(0)))
                                  .toList()
                                  .first
                                  .name!,
                              overflow: TextOverflow.visible,
                            ),
                          ),
                          Column(
                            children: [
                              Text(selectedOutletlist[index]
                                  .values
                                  .elementAt(2)),
                              Text(selectedOutletlist[index]
                                  .values
                                  .elementAt(3) +
                                  "%"),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      enableDrag: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Widget buildBatchTile(Outlet outlet, Product products) {
    //   return Card(
    //     child: Padding(
    //       padding: const EdgeInsets.all(5.0),
    //       child: Column(
    //         children: [
    //
    //           Row(
    //             children: [
    //               Text("Expire:", style: contentStyle),
    //               Spacer(),
    //               Text(
    //                 DateFormat.yMEd().format(DateTime.parse(batches.expiredAt)),
    //                 style: contentStyle,
    //               ),
    //             ],
    //           ),
    //           ElevatedButton(
    //             onPressed: () {
    //               showQuantityBottomSheet(
    //                   batches.id.toString(), );
    //             },
    //             child: Text("Sell"),
    //           ),
    //         ],
    //       ),
    //     ),
    //   );
    // }

    Widget buildMainTile(Outlet outlet) {
      return Card(
        elevation: 7,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: CircleAvatar(
                    backgroundColor:  outlet.synced!
                        ? Colors.green
                        : Colors.grey,
                    child: Icon(
                      outlet.synced!
                          ? Icons.cloud_off_outlined
                          : Icons.shopping_bag_outlined,
                      color: Colors.white,
                    ),
                  )),
            ),
            Center(
              child: Text(
                outlet.name!,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
            ElevatedButton(onPressed: (){
              showQuantityBottomSheet(outlet.id.toString());

              // print( Get.find<OutletsController>()
              //     .outletList.length
              //    );
              //print(Get.find<Routecontroller>().routeList.length);
              //print(Get.find<ChannelController>().channelList.length);
            }, child: Text("Press")),
            // Padding(
            //   padding: const EdgeInsets.all(4.0),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment
            //         .start,
            //     children: [
            //       // Icon(
            //       //   Icons.person,
            //       //   size: 16,
            //       // ),
            //       SizedBox(
            //         width: 5,
            //       ),
            //       //   Image(image: item.image)
            //
            //     ],
            //   ),
            // ),
            // Divider(),
            // Padding(
            //   padding: const EdgeInsets.all(4.0),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment
            //         .start,
            //     children: [
            //       // Icon(
            //       //   Icons.person,
            //       //   size: 16,
            //       // ),
            //       SizedBox(
            //         width: 5,
            //       ),
            //       //Text(item.ownerName),
            //     ],
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.all(4.0),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment
            //         .start,
            //     children: [
            //       Icon(
            //         Icons.phone,
            //         size: 16,
            //       ),
            //       SizedBox(
            //         width: 5,
            //       ),
            //       //Text(item.contact),
            //     ],
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.all(4.0),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment
            //         .start,
            //     children: [
            //       Icon(
            //         Icons.location_on,
            //         size: 16,
            //       ),
            //       SizedBox(
            //         width: 5,
            //       ),
            //       // Expanded(
            //       //   child: Text(
            //       //     province +
            //       //         ", " +
            //       //         district +
            //       //         ", " +
            //       //         area +
            //       //         ", " +
            //       //         (item.street ?? ""),
            //       //     overflow: TextOverflow.visible,
            //       //     style: TextStyle(fontSize: 12),
            //       //   ),
            //       // ),
            //     ],
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.all(4.0),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment
            //         .start,
            //     children: [
            //       Icon(
            //         Icons.category,
            //         size: 16,
            //       ),
            //       SizedBox(
            //         width: 5,
            //       ),
            //       //Text(item.type),
            //     ],
            //   ),
            // ),
            // MaterialButton(
            //   onPressed: () {
            //     Get.to(() =>
            //         SellProductPage(
            //           outlet: Get
            //               .find<OutletsController>()
            //               .outletList.first,
            //         ));
            //   },
            //   color: Colors.green[900],
            //   minWidth: Get.size.width,
            //   textColor: Colors.white,
            //   padding: EdgeInsets.all(10.0),
            //   child: Text("Sell Product"),
            // ),
          ],
        ));
    }

    Widget _buildListViewWidget(List<Outlet> outlerList) {
      return ListView.builder(
          shrinkWrap: false,
         // physics: NeverScrollableScrollPhysics(),
          itemCount: outlerList.length,
          itemBuilder: (context, index) {
            return buildMainTile(outlerList[index]);
          });
    }

    return WillPopScope(
      onWillPop: () async {
     //   Get.find<OutletsController>().removeAllProductFromList();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Sell"),
        ),
        // floatingActionButton: FloatingActionButton.extended(
        //   onPressed: () async {
        //     if (selectedOutletlist.isEmpty) {
        //       Utilities.showInToast("Please add a product",
        //           toastType: ToastType.ERROR);
        //       return;
        //     }
        //
        //     sales.orders = jsonEncode(selectedOutletlist);
        //     sales.distributorId = Constants.selectedRoute.id.toString();
        //     sales.soldAt = DateTime.now().toString();
        //     sales.outletId = outlet.outid.toString();
        //     sales.outletLatitude = outlet.latitude.toString();
        //     sales.outletLongitude = outlet.longitude.toString();
        //
        //     var conn = await Utilities.isInternetWorking();
        //     if (conn) {
        //       Get.find<ProductsController>().sellProducts(sales);
        //     } else {
        //       Get.find<ProductsController>().storeSalesOffline(sales);
        //     }
        //
        //     Get.find<ProductsController>().removeAllProductFromList();
        //
        //     // Get.back();
        //   },
        //   label: Row(
        //     children: [
        //       Icon(Icons.check_circle),
        //       Text("Save"),
        //     ],
        //   ),
        // ),
        body: Scrollbar(
          isAlwaysShown: true,
          interactive: true,
          thickness: 6.0,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Text(
                        //  // outlet.name,
                        //   style: TextStyle(fontSize: 20.0),
                        // ),

                    // ElevatedButton(onPressed: (){
                    //   print(Get.find<ProductsController>()
                    //       .productList.length);
                    // }, child: Text('sry')),
                    SizedBox(
                      height: Get.size.height * 0.03,
                    ),

                       Column(
                        children: [

                          GetBuilder<OutletsController>(
                            init: OutletsController(),
                            builder: (outletController) {
                              return
                                // Get.find<OutletsController>()
                                //     .searchList!=
                                //     null
                                //     ? Get.find<OutletsController>()
                                //     .searchList
                                //     .isNotEmpty
                                //     ? _buildListViewWidget(
                                //     Get.find<OutletsController>()
                                //         .searchList)
                                //     : Center(child: Text("No Pr ucts"))
                                //     : Get.find<OutletsController>().outletList==
                                //     null
                                //     ? Center(
                                //   child: CircularProgressIndicator(),
                                // )
                                     Get.find<OutletsController>()
                                    .outletList!
                                    .isEmpty
                                    ? Center(child: Text("No cts"))
                                    : _buildListViewWidget(
                                    Get.find<OutletsController>()
                                        .outletList!);
                            },
                          ),
                        ],
                      ),

                    SizedBox(height: Get.size.height * 0.02),
                  ],
                ),
              ]),
            ),
          ),
        ),
      ),
    ));
  }
}
