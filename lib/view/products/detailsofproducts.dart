import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:intl/intl.dart';
import 'package:mobitrack_dv_flutter/controller/outlets_controller.dart';
import 'package:mobitrack_dv_flutter/controller/preference_controller.dart';
import 'package:mobitrack_dv_flutter/view/outlets/view_outlets.dart';
import 'package:mobitrack_dv_flutter/view/products/brandwiseproduct.dart';
import 'package:mobitrack_dv_flutter/view/products/sendproduct.dart';

import '../../controller/location_controller.dart';
import '../../controller/productbrand_controller.dart';
import '../../controller/products_controller.dart';
import '../../model/outlet.dart';
import '../../model/products.dart';
import '../../utils/constants.dart';
import '../../utils/utilities.dart';

class DetailsProduct extends StatefulWidget{

  final List product;
  final Outlet outlet;

  DetailsProduct({this.product,this.outlet});

  @override
  State<DetailsProduct> createState() => _DetailsProductState();
}

class _DetailsProductState extends State<DetailsProduct> {


  var productController = Get.lazyPut(()=>ProductsController());

  var selectedProductList = [].obs;

  TextEditingController editingController = TextEditingController();

  Position position;
  String query;
  Sales sales = Sales();
  List<String> searchResult = [];
  String text = '';

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



  Product products = Product();

  Outlet _outlet = Outlet();

   List<Product> newDataList = List.from(Get.find<ProductBrandController>().productList);
  onItemChanged(String value) {
    setState(() {
      newDataList = Get.find<ProductBrandController>().productList
          .where((string) => string.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }


  void showQuantityBottomSheet( String productId, BuildContext context) {
    String addedQuantity;
    String discountPercent = "0";
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
                    addedQuantity = quantity;
                  },
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: Get.size.height * 0.01),
                TextField(
                  controller: TextEditingController()..text = '0',
                  decoration: InputDecoration(
                    labelText: "Discount",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    suffixText: "%",
                    suffixStyle: TextStyle(fontSize: 20.0),
                  ),
                  onChanged: (discount) {
                    discountPercent = discount;
                  },
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black)
                  ),
                  onPressed: () async {
                    if (selectedProductList != null && addedQuantity != null) {
                      selectedProductList.add({
                        "product_id": Get.find<ProductBrandController>().selectedAreaId,
                        "batch_id": "",
                        "quantity": addedQuantity,
                        "discount": discountPercent
                      });
                 //     Get.to(BrandWiseProduct(sales: selectedProductList , outlet: outlet,));
                      print(Get.find<ProductBrandController>().selectedAreaId);
                      // print(position.latitude);
                      // print(position.longitude);
                      var conn = await Utilities.isInternetWorking();
                      if (conn) {
                        print(widget.outlet.id);
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
                        var saless = Sales(
                          route: Constants.selectedRoute.toString(),
                          orders: jsonEncode(selectedProductList),
                          remark:"",
                          //   "[{ \"product_id\" :\"2\", \"batch_id\": \"3\", \"quantity\" : \"30\", \"discount\": \"10\"}]",
                          soldAt:
                          DateTime.now().toString(),
                          outletId: widget.outlet.id.toString(),
                          latitude:  location.userPosition.latitude.toString(),
                          longitude:   location.userPosition.longitude.toString(),
                          //remark_image: "",
                        );
                        print(widget.outlet.id.toString());
                        print(location.userPosition.latitude.toString());
                        print(location.userPosition.longitude.toString());
                        print(widget.outlet.id);
                        // var register = Outlet(
                        //   outid:  outlet.id,
                        //   route_id: Constants.selectedRoute.toString(),
                        //   name:  outlet.name,
                        //   contact: outlet.contact,
                        //   latitude: outlet.latitude,
                        //   longitude: outlet.longitude
                        // );
                        var response = await sellProductApi(saless);
                        Constants.value_increase++;
                        Get.find<PreferenceController>().saveCall(widget.outlet.id.toString());
                      //  Get.find<ProductBrandController>().value.add(saless);
                        print(Constants.value_increase++);
                        //  Constants.increase ++;
                        //  selected = true ? Constants.increase +1 : selected =false;
                        //Get.find<ProductsController>().storeSalesOffline(saless);
                  //    Get.to(DetailsProduct());
                        Get.back();
                        Get.back();
                        Utilities.showInToast(response.message,
                            toastType: response.success
                                ? ToastType.SUCCESS
                                : ToastType.ERROR);
                        //  Get.find<ProductsController>().sellProducts(sales);
                      }
                      // else {
                      //   //  Get.find<ProductsController>().storeSalesOffline(saless);
                      // }
                   //   Get.find<ProductsController>().addProductInList(productId);
                    } else {
                      if(selectedProductList == null || addedQuantity == null){
                        Utilities.showInToast("Please add quantity");
                      }
                    }
                  //   if (selectedProductList.isEmpty) {
                  //     Utilities.showInToast("Please add a product",
                  //         toastType: ToastType.ERROR);
                  //     return;
                  //   }
                  //   var sales = Sales(
                  //     orders:  selectedProductList.toString(),
                  //     soldAt: DateTime.now().toString(),
                  //     outletId: outlet.outid.toString()
                  //   );
                  //   sales.orders = jsonEncode(selectedProductList);
                  // // sales.distributorId = "11";
                  //   sales.soldAt = DateTime.now().toString();
                  //   sales.outletId = outlet.outid.toString();
                  //   // sales.outletLatitude = "3343";
                  //   // sales.outletLongitude = "3211";
                  //   var conn = await Utilities.isInternetWorking();
                  //   if (conn) {
                  //     var response = await sellProductApi(sales);
                  //     Utilities.showInToast(response.message,
                  //         toastType: response.success
                  //             ? ToastType.SUCCESS
                  //             : ToastType.ERROR);
                  //     Get.back();
                  //   //  Get.find<ProductsController>().sellProducts(sales);
                  //   } else {
                  //   //  Get.find<ProductsController>().storeSalesOffline(sales);
                  //   }
                  //   print(outlet.outid);
                    //Get.back();
                  },
                  child: Text("Sell"),
                )
              ],
            ),
          )),
      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
      backgroundColor: Colors.white,
      enableDrag: true,
    );
  }

  @override
  void initState() {
    super.initState();

    searchResult =  Get.find<ProductBrandController>().name;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Widget buildMainTile(String productes ) {
      return Card(
     //   color: produce.selected ? Colors.grey : Colors.white,
        elevation: 7.0,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Name:",
                    style: titleStyle,
                  ),
                  Spacer(),
                  Expanded(
                    child: Text(
                      productes,
                      overflow: TextOverflow.visible,
                      maxLines: null,
                      style: contentStyle,
                    ),
                  ),
                ],
              ),
                    ElevatedButton(
                onPressed: () {
                  showQuantityBottomSheet(productes, context);
                },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.black)
                      ),
                child: Text("Sell"),
              )
              //     : ExpansionTile(
              //   title: Text("Batches"),
              //   children: products.batches.map((batch) {
              //     return buildBatchTile(batch, products);
              //   }).toList(),
              // ),
            ],
          ),
        ),
      );
    }



    searchDistributor(String text) {
      searchResult = Get.find<ProductBrandController>().name;
      if (Get.find<ProductBrandController>().name.isNotEmpty) {
        final searc = Get.find<ProductBrandController>().name
            .where((element){
          final title = element.toLowerCase();
          final sea = text.toLowerCase();
          return title.contains(sea);
        }
        ).toList();
     setState(() {
       //this.searchResult = Get.find<ProductBrandController>().name;
       this.text = text;
        this.searchResult = searc;
     });
      }
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: (){
          Get.to(ViewOutletstPage());

            //BrandWiseProduct(outlet: _outlet )
        }, icon: Icon(Icons.arrow_back,color: Colors.black,)),
        title: Text("Products",style: TextStyle(color: Colors.black),),
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   backgroundColor: Colors.black,
      //   onPressed: () async {
      //     if (selectedProductList.isEmpty) {
      //       Utilities.showInToast("Please add a product",
      //           toastType: ToastType.ERROR);
      //       return;
      //     }
      //     _outlet= outlet;
      //     sales.orders = jsonEncode(selectedProductList);
      //     //sales.distributorId = Constants.selectedDistributor.id.toString();
      //     sales.soldAt = DateTime.now().toString();
      //     sales.outletId = outlet.id.toString();
      //     // sales.outletLatitude = outlet.latitude.toString();
      //     // sales.outletLongitude = outlet.longitude.toString();
      //
      //     var conn = await Utilities.isInternetWorking();
      //     if (conn) {
      //       Get.find<ProductsController>().sellProducts(sales);
      //     } else {
      //      // Get.find<ProductsController>().storeSalesOffline(sales);
      //     }
      //
      //     //Get.find<ProductsController>().removeAllProductFromList();
      //     Get.to(SendProduct());
      //     // Get.back();
      //   },
      //   label: Row(
      //     children: [
      //       Icon(Icons.check_circle),
      //       Text("Save"),
      //     ],
      //   ),
      // ),
      body:
      GetBuilder<ProductBrandController>(
        builder: (BrandController) {
          return Get.find<ProductBrandController>().productList == null
              ? Center(

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CupertinoActivityIndicator(),
              ],
            ),
          )
              :
          //     ElevatedButton(onPressed: (){
          //       print(Get.find<ProductBrandController>().productList.length);
          // }, child: Text("press"));
          Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.red, //this has no effect
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  hintText: "Search Routes...",
                ),
                onChanged: searchDistributor,

                    // (text){setState(() {
                    //   Get.find<ProductBrandController>().searchDist ributor(text);
                    // });

                  //onItemChanged(text);
          //      },
          //       {
          //         setState(() {
          //
          //         });
          //
          // }
                  // setState(() {
                  // });
              ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: TextField(
              //     autofocus: false,
              //     keyboardType: TextInputType.text,
              //
              //     decoration: InputDecoration(
              //
              //         labelText: "Search Product",
              //         prefixIcon: Icon(Icons.search)),
              //      onChanged: (text){
              //       Get.find<ProductBrandController>().searchout(text);
              //      },
              //     // onTap: (){
              //     //    Constants.selectid.ownerName;
              //     //    },
              //   ),
              // ),
              Expanded(
                child: Container(
                  child: ListView.builder(
                    shrinkWrap: true,
                      itemCount:  searchResult.length  ,
                      itemBuilder: (context,index){
                        var item = Get.find<ProductBrandController>().name[index];
                        return Card(
                           //   color: produce.selected ? Colors.grey : Colors.white,
                          elevation: 7.0,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Name:",
                                      style: titleStyle,
                                    ),
                                    Spacer(),
                                    Expanded(
                                      child: Text(
                                        searchResult[index],
                                        overflow: TextOverflow.visible,
                                        maxLines: null,
                                        style: contentStyle,
                                      ),
                                    ),
                                  ],
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    showQuantityBottomSheet(    searchResult[index] , context);
                                  },
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(Colors.black)
                                  ),
                                  child: Text("Sell"),
                                )
                                //     : ExpansionTile(
                                //   title: Text("Batches"),
                                //   children: products.batches.map((batch) {
                                //     return buildBatchTile(batch, products);
                                //   }).toList(),
                                // ),
                              ],
                            ),
                          ),
                        );
                        //   buildMainTile(item
                      //   // );
                      //     ListTile(
                      //     onTap: (){
                      // //      Get.find<ProductBrandController>().select;
                      //     },
                      //     title: Text(item),
                      //   );
                      }),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}