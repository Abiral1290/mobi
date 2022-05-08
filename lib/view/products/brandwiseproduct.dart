// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:mobitrack_dv_flutter/controller/products_controller.dart';
//
// import '../../model/products.dart';
//
// class BrandWiseProduct extends StatelessWidget{
//
//   var productCOntroller = Get.lazyPut(() => ProductsController());
//   @override
//   Widget build(BuildContext context) {
//
//
//     Widget listSegment(List<Product> productList) {
//       return ListView.builder(
//         itemCount: productList.length,
//         itemBuilder: (context, index) {
//           return Obx(
//                   () => ListTile(
//                 onTap: () {
//                   // Constants.selectedRoute  = routeList[index] ;
//                   // print(Constants.selectedRoute.id);
//                   // selectedRoute = routeList[index];
//                   // _selectedIndex.value = index;
//                   // Get.find<OutletsController>().fetchOutlets();
//                   // print(Constants.selectedDistributor);
//                   // Get.find<PreferenceController>()
//                   //     .setDistributor(jsonEncode(Constants.selectedDistributor));
//                   // Utilities.showInToast(
//                   //     "Route : ${selectedRoute.routename}");
//                   // Get.off(HomePage());
//                 },
//                // selected: index == _selectedIndex.value,
//                 title:    Card(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12.0),
//                   ),
//                   //   shape: BeveledRectangleBorder(
//                   //   borderRadius: BorderRadius.circular(5.0),
//                   // ),
//                   // shape: StadiumBorder(
//                   //     side: BorderSide(
//                   //       color: Colors.black,
//                   //       width: 1.5,
//                   //       borderRadius: BorderRadius.circular(10.0),
//                   //     ),),
//
//                   // outlet[index].selected ? Colors.grey
//                   elevation: 7.0,
//
//                   child: Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Row(
//                           mainAxisAlignment:  MainAxisAlignment.end,
//                           children: [
//
//                             // SizedBox(
//                             //   width: Get.size.width * 0.3,
//                             // ),
//                             // CircleAvatar(
//                             //     radius: (20),
//                             //     backgroundColor:  outlet[index].synced
//                             //         ? Colors.blueGrey
//                             //         : Colors.grey,
//                             //     child:  IconButton(onPressed:(){
//                             //      // showQuantityBottomSheet(outlet[index].id.toString());
//                             //        Get.bottomSheet(
//                             //         Container(
//                             //             child: Padding(
//                             //               padding: const EdgeInsets.all(10.0),
//                             //               child: Column(
//                             //                 mainAxisSize: MainAxisSize.min,
//                             //                 children: [
//                             //
//                             //                   Padding(
//                             //                     padding: const EdgeInsets.all(10.0),
//                             //                     child: GetBuilder<OutletsController>(
//                             //                       builder: (builder) {
//                             //                         return Get.find<OutletsController>().item.length == null
//                             //                             ? SizedBox()
//                             //                             : InputDecorator(
//                             //                           decoration: decoration("Select Remark"),
//                             //                           child: ButtonTheme(
//                             //                             alignedDropdown: true,
//                             //                             child: DropdownButton<String>(
//                             //                               // iconEnabledCo
//                             //                               // iconDisabledColor: Colors.red,
//                             //                               isDense: true,
//                             //                               isExpanded: true,
//                             //                               hint: Text(
//                             //                                   Get.find<OutletsController>().selectedDrowpdown),
//                             //                               items:
//                             //                               Get.find<OutletsController>().item.map((e) {
//                             //                                 return DropdownMenuItem<String>(
//                             //                                     value: e, child: Text(e));
//                             //                               }).toList(),
//                             //                               onChanged: (String district) {
//                             //                                 // setState(() {
//                             //                                 Get.find<OutletsController>().selectedDrowpdown = district;
//                             //                                 //  Get.find<OutletsController>().setitem(district );
//                             //                                 // });
//                             //
//                             //                                 // district = selectedDrowpdown;
//                             //                                 print(Get.find<OutletsController>().selectedDrowpdown);
//                             //                                 print(district);
//                             //                                 //   print(Get.find<OutletsController>().setitem(district ));
//                             //                                 //   district = Constants.item;
//                             //                                 //      print(selectedDrowpdown);
//                             //                                 //   district = Constants.selectedzone.zone;
//                             //                                 // Get.find<AddressController>().getAreaList(district);
//                             //                               },
//                             //                             ),
//                             //                           ),
//                             //                         );
//                             //                       },
//                             //                     ),
//                             //                   ),
//                             //                   // ElevatedButton(
//                             //                   //   onPressed: () async {
//                             //                   //     if ( Get.find<OutletsController>().selectedDrowpdown != null  ) {
//                             //                   //       // selectedProductList.add({
//                             //                   //       //
//                             //                   //       //   "remarks":  Get.find<OutletsController>().selectedDrowpdown,
//                             //                   //       //
//                             //                   //       // });
//                             //                   //       //
//                             //                   //       // if (selectedProductList.isEmpty) {
//                             //                   //       //   Utilities.showInToast("Please add a product",
//                             //                   //       //       toastType: ToastType.ERROR);
//                             //                   //       //   return;
//                             //                   //       // }
//                             //                   //
//                             //                   //       var sales = Sales(
//                             //                   //         orders: '[{ "product_id" :"2", "batch_id": "3", "quantity" : "30", "discount": "10"}]',
//                             //                   //         remark: jsonEncode(selectedProductList),
//                             //                   //         soldAt:  DateTime.now().toString(),
//                             //                   //         outletId: "12",
//                             //                   //            outletLatitude : "444444",
//                             //                   //        outletLongitude : "4343243423"
//                             //                   //       );
//                             //                   //       // sales.orders = "dd";
//                             //                   //       // // sales.distributorId = "12";
//                             //                   //       // sales.remark =jsonEncode(selectedProductList);
//                             //                   //       // sales.soldAt = DateTime.now().toString();
//                             //                   //       // sales.outletId = Get
//                             //                   //       //     .find<OutletsController>()
//                             //                   //       //     .outletList[index].id.toString();
//                             //                   //       // sales.outletLatitude = "444444";
//                             //                   //       // sales.outletLongitude = "4343243423";
//                             //                   //
//                             //                   //       //  var conn = await Utilities.isInternetWorking();
//                             //                   //
//                             //                   //
//                             //                   //
//                             //                   //       Get.find<OutletsController>().addoutletInList(outlet[index].id.toString()) ;
//                             //                   //       //else {
//                             //                   //       //   Get.find<ProductsController>().storeSalesOffline(sales);
//                             //                   //       // }
//                             //                   //       //
//                             //                   //       // Get.find<ProductsController>().removeAllProductFromList();
//                             //                   //   //    Get.find<ProductsController>().sellProducts(sales);
//                             //                   //           var conn = await Utilities.isInternetWorking();
//                             //                   //       if (conn) {
//                             //                   //         var response = await sellProductApi(sales);
//                             //                   //         print(sales);
//                             //                   //         // Get.back();
//                             //                   //         Utilities.showInToast(response.message,
//                             //                   //             toastType: response.success
//                             //                   //                 ? ToastType.SUCCESS
//                             //                   //                 : ToastType.ERROR);
//                             //                   //
//                             //                   //         //   if (response.success) {
//                             //                   //         //     outlet.synced = true;
//                             //                   //         //     Get.back();
//                             //                   //         //   }
//                             //                   //         // } else {
//                             //                   //         //   Get.back();
//                             //                   //         //   outlet.synced = false;
//                             //                   //         //
//                             //                   //         //   Utilities.showInToast('Storing Offline',
//                             //                   //         //       toastType: ToastType.INFO);
//                             //                   //         // }
//                             //                   //         // await DatabaseHelper.instance
//                             //                   //         //     .insertOutlet(outlet);
//                             //                   //         // Get.find<ProductsController>().addremark(sales);
//                             //                   //         Get.back();
//                             //                   //       } else {
//                             //                   //         Utilities.showInToast('Please complete the form',
//                             //                   //             toastType: ToastType.ERROR);
//                             //                   //       }
//                             //                   //     } else {
//                             //                   //       Utilities.showInToast("Please add quantity");
//                             //                   //     }
//                             //                   //     Get.back(
//                             //                   //
//                             //                   //     );
//                             //                   //   },
//                             //                   //   child: Text("Add"),
//                             //                   // )
//                             //                 ],
//                             //               ),
//                             //             )),
//                             //         shape: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
//                             //         backgroundColor: Colors.white,
//                             //         enableDrag: true,
//                             //       );
//                             //       // Get.bottomSheet(
//                             //       //   // ListView.builder(itemCount: Get.find<OutletsController>().item?.length != null ? Get.find<OutletsController>().item?.length  : "",
//                             //       //   //   itemBuilder: (context, index){
//                             //       //   //     return
//                             //       //   Container(
//                             //       //       child: Padding(
//                             //       //         padding: const EdgeInsets.all(10.0),
//                             //       //         child: Column(
//                             //       //           mainAxisSize: MainAxisSize.min,
//                             //       //           children: [
//                             //       //             Padding(
//                             //       //                 padding: const EdgeInsets.all(12.0),
//                             //       //                 child:
//                             //       //                 // DropdownButton(
//                             //       //                 //
//                             //       //                 //   // Initial Value
//                             //       //                 //     value: selectedDrowpdown,
//                             //       //                 //
//                             //       //                 //     // Down Arrow Icon
//                             //       //                 //     icon: const Icon(Icons.keyboard_arrow_down),
//                             //       //                 //
//                             //       //                 //     // Array list of items
//                             //       //                 //     items: item.map((String items) {
//                             //       //                 //       return DropdownMenuItem(
//                             //       //                 //         value: items,
//                             //       //                 //         child: Text(items),
//                             //       //                 //       );
//                             //       //                 //     }).toList(),
//                             //       //                 // After selecting the desired option,it will
//                             //       //                 // change button value to selected value
//                             //       //                 // onChanged: (String newValue) {
//                             //       //                 //   setState(() {
//                             //       //                 //     selectedDrowpdown = newValue;
//                             //       //                 //   });
//                             //       //                 //                 DropdownButton(
//                             //       //                 //                 hint: Text("Outlet Closed Image"), // Not necessary for Option 1
//                             //       //                 //   value:selectedDrowpdown,
//                             //       //                 //   onChanged: (newValue) {
//                             //       //                 //     selectedDrowpdown = newValue;
//                             //       //                 //   setState(() {
//                             //       //                 //   selectedDrowpdown = newValue;
//                             //       //                 // //  print(newValue);
//                             //       //                 //   //print(selectedDrowpdown);
//                             //       //                 //   });
//                             //       //                 //   },
//                             //       //                 //   items: item.map((location) {
//                             //       //                 //   return DropdownMenuItem(
//                             //       //                 //   child: new Text(location),
//                             //       //                 //   value: location,
//                             //       //                 //   );
//                             //       //                 //   }).toList(),
//                             //       //                 //   ),
//                             //       //                 Padding(
//                             //       //                   padding: const EdgeInsets.all(10.0),
//                             //       //                   child: GetBuilder<OutletsController>(
//                             //       //                     builder: (builder) {
//                             //       //                       return Get.find<OutletsController>().item.length == null
//                             //       //                           ? SizedBox()
//                             //       //                           : InputDecorator(
//                             //       //                         decoration: decoration("Select Remark"),
//                             //       //                         child: ButtonTheme(
//                             //       //                           alignedDropdown: true,
//                             //       //                           child: DropdownButton<String>(
//                             //       //                             // iconEnabledCo
//                             //       //                             // iconDisabledColor: Colors.red,
//                             //       //                             isDense: true,
//                             //       //                             isExpanded: true,
//                             //       //                             hint: Text(
//                             //       //                                 Get.find<OutletsController>().selectedDrowpdown),
//                             //       //                             items:
//                             //       //                             Get.find<OutletsController>().item.map((e) {
//                             //       //                               return DropdownMenuItem<String>(
//                             //       //                                   value: e, child: Text(e));
//                             //       //                             }).toList(),
//                             //       //                             onChanged: (String district) {
//                             //       //                               // setState(() {
//                             //       //                                 Get.find<OutletsController>().selectedDrowpdown = district;
//                             //       //                                 //  Get.find<OutletsController>().setitem(district );
//                             //       //                              // });
//                             //       //
//                             //       //                               // district = selectedDrowpdown;
//                             //       //                               print(Get.find<OutletsController>().selectedDrowpdown);
//                             //       //                               print(district);
//                             //       //                               //   print(Get.find<OutletsController>().setitem(district ));
//                             //       //                               //   district = Constants.item;
//                             //       //                               //      print(selectedDrowpdown);
//                             //       //                               //   district = Constants.selectedzone.zone;
//                             //       //                               // Get.find<AddressController>().getAreaList(district);
//                             //       //                             },
//                             //       //                           ),
//                             //       //                         ),
//                             //       //                       );
//                             //       //                     },
//                             //       //                   ),
//                             //       //                 )
//                             //       //               // DropdownButton<String>(
//                             //       //               //   hint: Text("Remark"),
//                             //       //               //   value:  selectedDrowpdown,
//                             //       //               //   items:
//                             //       //               //   //[for(var data in  Get.find<OutletsController>().item)])
//                             //       //               //   // [
//                             //       //               //   //   for (var data in Get.find<OutletsController>().item)
//                             //       //               //   //     DropdownMenuItem(
//                             //       //               //   //       child: new Text(
//                             //       //               //   //         data,
//                             //       //               //   //       ),
//                             //       //               //   //       value: data,
//                             //       //               //   //     )
//                             //       //               //   // ],
//                             //       //               //
//                             //       //               //   // Get.find<OutletsController>().item.map((e) {
//                             //       //               //   //   return DropdownMenuItem<String>(
//                             //       //               //   //           value: e,
//                             //       //               //   //           child: Text(e),
//                             //       //               //   //         );
//                             //       //               //   // }),
//                             //       //               //     item.map((  value) {
//                             //       //               //     return DropdownMenuItem<String>(
//                             //       //               //       value: value,
//                             //       //               //       child: Text(value),
//                             //       //               //     );
//                             //       //               //   }).toList(),
//                             //       //               //   onChanged: (newvalue) {
//                             //       //               //     setState(() {
//                             //       //               //      selectedDrowpdown = newvalue ;
//                             //       //               //     });
//                             //       //               //
//                             //       //               // //   Get.find<OutletsController>().setitem(newvalue);
//                             //       //               //
//                             //       //               //
//                             //       //               //    //_selectedvalue = newvalue;
//                             //       //               //   })
//                             //       //             ),
//                             //       //
//                             //       //             SizedBox(height: Get.size.height * 0.01),
//                             //       //             // Container(
//                             //       //             //   child: _imageFile == null
//                             //       //             //       ? Center(
//                             //       //             //     child: Text("No Image Selected"),
//                             //       //             //   )
//                             //       //             //       : Image.file(File(_imageFile.path)),
//                             //       //             // ),
//                             //       //             ElevatedButton(
//                             //       //               onPressed: () async {
//                             //       //                 // pickImage();
//                             //       //                 if (Get.find<OutletsController>().selectedDrowpdown.isNotEmpty) {
//                             //       //                   var conn = await Utilities.isInternetWorking();
//                             //       //                   showDialog(
//                             //       //                       barrierDismissible: false,
//                             //       //                       context: context,
//                             //       //                       builder: (context) {
//                             //       //                         return CupertinoAlertDialog(
//                             //       //                           title: Text('Please Wait'),
//                             //       //                           content: Column(
//                             //       //                             children: [
//                             //       //                               Divider(),
//                             //       //                               Padding(
//                             //       //                                 padding: const EdgeInsets.all(8.0),
//                             //       //                                 child: Text(conn
//                             //       //                                     ? 'Registering new Sales Outlet'
//                             //       //                                     : 'Saving offline'),
//                             //       //                               ),
//                             //       //                               CupertinoActivityIndicator(
//                             //       //                                 radius: 17,
//                             //       //                               )
//                             //       //                             ],
//                             //       //                           ),
//                             //       //                         );
//                             //       //                       });
//                             //       //                   // var sales = Sales(
//                             //       //                   //     outletId:  outlet[index].id.toString(),
//                             //       //                   //     remark:  Get.find<OutletsController>().selectedDrowpdown
//                             //       //                   // );
//                             //       //                   // selectedoutlet.add({
//                             //       //                   //   //"outlet_id": outletId,
//                             //       //                   //
//                             //       //                   //   "remark": selectedDrowpdown,
//                             //       //                   //
//                             //       //                   // });
//                             //       //                   if (conn) {
//                             //       //                     var response = await sellProductApi(sales);
//                             //       //                     print(sales);
//                             //       //                     // Get.back();
//                             //       //                     Utilities.showInToast(response.message,
//                             //       //                         toastType: response.success
//                             //       //                             ? ToastType.SUCCESS
//                             //       //                             : ToastType.ERROR);
//                             //       //
//                             //       //                     //   if (response.success) {
//                             //       //                     //     outlet.synced = true;
//                             //       //                     //     Get.back();
//                             //       //                     //   }
//                             //       //                     // } else {
//                             //       //                     //   Get.back();
//                             //       //                     //   outlet.synced = false;
//                             //       //                     //
//                             //       //                     //   Utilities.showInToast('Storing Offline',
//                             //       //                     //       toastType: ToastType.INFO);
//                             //       //                     // }
//                             //       //                     // await DatabaseHelper.instance
//                             //       //                     //     .insertOutlet(outlet);
//                             //       //                     // Get.find<ProductsController>().addremark(sales);
//                             //       //                     Get.back();
//                             //       //                   } else {
//                             //       //                     Utilities.showInToast('Please complete the form',
//                             //       //                         toastType: ToastType.ERROR);
//                             //       //                   }
//                             //       //                   // if (selectedDrowpdown != null) {
//                             //       //                   //   // selectedoutlet.add({
//                             //       //                   //   //   //"outlet_id": outletId,
//                             //       //                   //   //
//                             //       //                   //   //   "remark": selectedDrowpdown,
//                             //       //                   //   //
//                             //       //                   //   // });
//                             //       //                   //   sales.remark = jsonEncode(selectedoutlet);
//                             //       //                   //   Get.find<OutletsController>().addoutletInList(outletId);
//                             //       //                   //   //Get.find<ProductsController>().addremark(selectedoutlet);
//                             //       //                   //   Utilities.showInToast("Remark Noted");
//                             //       //                   //   print(selectedDrowpdown);
//                             //       //                   // } else {
//                             //       //                   //   Utilities.showInToast("Please add Remark");
//                             //       //                   // }
//                             //       //                   Get.back();}
//                             //       //               },
//                             //       //               child: Text("Add"),
//                             //       //             ),
//                             //       //           //  outlet.id..toString().isEmpty
//                             //       //           //       ? ElevatedButton(
//                             //       //           //     onPressed: () {
//                             //       //           //       showQuantityBottomSheet(null, products.id.toString());
//                             //       //           //     },
//                             //       //           //     child: Text("Sell"),
//                             //       //           //   )
//                             //       //           //       : ExpansionTile(
//                             //       //           //     title: Text("Batches"),
//                             //       //           //     children: products.batches.map((batch) {
//                             //       //           //       return buildBatchTile(batch, products);
//                             //       //           //     }).toList(),
//                             //       //           //   ),
//                             //       //           ],
//                             //       //         ),)),
//                             //       //
//                             //       //
//                             //       //
//                             //       //
//                             //       //   shape: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
//                             //       //   backgroundColor: Colors.white,
//                             //       //   enableDrag: true,
//                             //       // );
//                             //     } , icon: Icon(Icons.add))
//                             // )
//                           ],
//                         ),
//                         Container(
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       productList[index].brandname,
//                                       style: TextStyle(
//                                           fontSize: 18,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                     Text("  Outlets: ${productList[index].brandname.length.toString()}",style: TextStyle(
//                                         fontSize: 12,
//                                         fontWeight: FontWeight.normal),)
//                                   ],
//                                 )
//                                 // Padding(
//                                 //   padding: const EdgeInsets.only(top: 1),
//                                 //   child:
//
//                                 //    ),
//                                 // Container(
//                                 //   child:   Text(
//                                 //     "Number of Outlet: ${outlet.length.toString()}",
//                                 //     style: TextStyle(
//                                 //         fontSize: 10,
//                                 //         fontWeight: FontWeight.bold),
//                                 //   ),
//                                 // ),
//                                 // Text(
//                                 //   outlet[index].name,
//                                 //   style: TextStyle(
//                                 //       fontSize: 10,
//                                 //       fontWeight: FontWeight.bold),
//                                 // ),
//
//                               ],
//                             )
//                         ),
//
//
//                       ],
//                     ),
//                   ),
//                 ),
//               )
//             // Text(
//             //   routeList[index].routename,
//             // ),
//           );
//         },
//       );
//     }
//     Widget productList() {
//       return Expanded(
//         child: GetBuilder<ProductsController>(
//           init: ProductsController(),
//           builder: (productcontroller) {
//             return
//               productcontroller.searchProductList.isNotEmpty
//                 ?
//               listSegment(productcontroller.searchProductList)
//                 : productcontroller.productList != null
//                 ? productcontroller.productList.isEmpty
//                 ? Center(child: Text("No Brand"))
//                 : listSegment(productcontroller.productList)
//                 : Center(
//               child: CircularProgressIndicator(),
//             );
//           },
//         ),
//       );
//     }
//     // TODO: implement build
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         leading: IconButton(onPressed: (){Get.back();}, icon: Icon(Icons.arrow_back,color: Colors.black,)),
//         title: Text("Outlet",style: TextStyle(color: Colors.black),),
//       ),
//       body: Container(
//         color: Colors.black.withOpacity(0.1),
//         child: Padding(
//           padding: const EdgeInsets.all(15.0),
//           child: Column(
//             children: [
//               TextField(
//                 decoration: InputDecoration(
//                   fillColor: Colors.white,
//                   filled: true,
//                   border: OutlineInputBorder(
//                     borderSide: BorderSide(
//                       color: Colors.red, //this has no effect
//                     ),
//                     borderRadius: BorderRadius.circular(10.0),
//                   ),
//                   hintText: "Search Routes...",
//                 ),
//                 onChanged: (text) {
//                   //Get.find<Routecontroller>().searchDistributor(text);
//                 },
//               ),
//
//               productList(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobitrack_dv_flutter/controller/address_controller.dart';
import 'package:mobitrack_dv_flutter/controller/database_controller.dart';
import 'package:mobitrack_dv_flutter/controller/location_controller.dart';
import 'package:mobitrack_dv_flutter/controller/outlets_controller.dart';
import 'package:mobitrack_dv_flutter/controller/productbrand_controller.dart';
import 'package:mobitrack_dv_flutter/controller/products_controller.dart';
import 'package:mobitrack_dv_flutter/model/outlet.dart';
import 'package:mobitrack_dv_flutter/model/products.dart';
import 'package:mobitrack_dv_flutter/utils/constants.dart';
import 'package:mobitrack_dv_flutter/utils/utilities.dart';
import 'package:geocoding/geocoding.dart';
import 'package:mobitrack_dv_flutter/view/dashboard.dart';
import 'package:mobitrack_dv_flutter/view/outlets/view_outlets.dart';
import 'package:mobitrack_dv_flutter/view/products/detailsofproducts.dart';
import 'package:mobitrack_dv_flutter/view/products/sell_products.dart';
import 'package:mobitrack_dv_flutter/view/view_town.dart';

import '../outlets/remarks.dart';

class BrandWiseProduct extends StatelessWidget {

  final Outlet outlet;
  final List sales;
  BrandWiseProduct({ this.outlet, this.sales});

   bool selected = false;
 Outlet outss;

  var brand = Get.lazyPut(()=>ProductBrandController());
  var provinceLists = Get.find<ProductBrandController>().productList.obs;

  bool isProvinceSelected = false;
   var isSelected = false;
  Position position;
  var mycolor = Colors.white;

 //  @override
 //  void initState() {
 //    Get.find<ProductBrandController>().name= [];
 // //   Get.find<AddressController>().areaList = [];
 //    //determinePosition();
 //    super.initState();
 //  }




  InputDecoration decoration(String label) {
    return InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      labelText: label,
    );
  }



  @override
  Widget build(BuildContext context) {
    Widget _buildProvinceDropdown() {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: GetBuilder<ProductBrandController>(
          builder: (builder) {
            return Get.find<ProductBrandController>().productList.isEmpty
                ? SizedBox()
                : InputDecorator(
              decoration: decoration("Select Province"),
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButton<String>(
                  iconEnabledColor: Colors.green,
                  iconDisabledColor: Colors.red,
                  isDense: true,
                  isExpanded: true,
                  hint: Text(
                      Get.find<ProductBrandController>().selectedBrand),
                  items:
                  Get.find<ProductBrandController>().brandList.map((e) {
                    return DropdownMenuItem<String>(
                        value: e, child: Text(e));
                  }).toList(),
                  onChanged: (province) {
                    isProvinceSelected = true;
                    Get.find<ProductBrandController>()
                        .setSelectedBrand(province);
                    // Get.find<ProductBrandController>()
                    //     .getNameList(province);
                  },
                ),
              ),
            );
          },
        ),
      );
    }

    Widget _buildDistrictDropdown() {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: GetBuilder<ProductBrandController>(
          builder: (builder) {
            return Get.find<ProductBrandController>().name.isEmpty
                ? SizedBox()
                : InputDecorator(
              decoration: decoration("Select District"),
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButton<String>(
                  iconEnabledColor: Colors.green,
                  iconDisabledColor: Colors.red,
                  isDense: true,
                  isExpanded: true,
                  hint: Text(
                      Get.find<ProductBrandController>().selectedName),
                  items:
                  Get.find<ProductBrandController>().name.map((e) {
                    return DropdownMenuItem<String>(
                        value: e, child: Text(e));
                  }).toList(),
                  onChanged: (district) {
                    Get.find<ProductBrandController>()
                        .setSelectedName(district);
                  //  Get.find<AddressController>().getAreaList(district);
                  },
                ),
              ),
            );
          },
        ),
      );
    }

    // Widget _buildAreaDropdown() {
    //   return Padding(
    //     padding: const EdgeInsets.all(10.0),
    //     child: GetBuilder<AddressController>(
    //       builder: (builder) {
    //         return Get.find<AddressController>().areaList.isEmpty
    //             ? SizedBox()
    //             : InputDecorator(
    //           decoration: decoration("Select Area"),
    //           child: ButtonTheme(
    //             alignedDropdown: true,
    //             child: DropdownButton<String>(
    //               iconEnabledColor: Colors.green,
    //               iconDisabledColor: Colors.red,
    //               isDense: true,
    //               isExpanded: true,
    //               hint: Text(Get.find<AddressController>().selectedArea),
    //               items: Get.find<AddressController>().areaList.map((e) {
    //                 return DropdownMenuItem<String>(
    //                     value: e, child: Text(e));
    //               }).toList(),
    //               onChanged: (area) {
    //                 Get.find<AddressController>().setSelectedArea(area);
    //               },
    //             ),
    //           ),
    //         );
    //       },
    //     ),
    //   );
    // }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(onPressed: (){Get.to(() => DashBoard());}, icon: Icon(Icons.arrow_back,color: Colors.black,)),
          title: Text(outlet.name,style: TextStyle(color: Colors.black),),
        ),
        floatingActionButton:  FloatingActionButton.extended(
          backgroundColor: Colors.black,
          onPressed: () async {
            if (sales == null) {
            //  print( Constants.selectedbrand );
              Get.to(() => Remark(outlet: outlet,));
              print(outlet.name);
            //  Constants.increase++;
            //  Constants.selectedbrand = outlet.id.toString();
              // Utilities.showInToast("Please add a product",
              //     toastType: ToastType.ERROR);
              return;
            }else{
              //   sales.orders = jsonEncode(selectedProductList);
              // // sales.distributorId = "11";
              //   sales.soldAt = DateTime.now().toString();
              //   sales.outletId = outlet.outid.toString();
              //   sales.outletLatitude = "3343";
              //   sales.outletLongitude = "3211";
              var conn = await Utilities.isInternetWorking();
              if (conn) {
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
                                  ? 'Adding new Product'
                                  : 'Saving offline'),
                            ),
                            CupertinoActivityIndicator(
                              radius: 17,
                            )
                          ],
                        ),
                      );
                    });
                var saless = Sales(
                  route: Constants.selectedRoute.toString(),
                    orders: jsonEncode(sales),
                    remark:"",
                latitude: "27.45354",
                longitude: "86.524354",
                //   "[{ \"product_id\" :\"2\", \"batch_id\": \"3\", \"quantity\" : \"30\", \"discount\": \"10\"}]",
                    soldAt:
                    DateTime.now().toString(),
                    outletId: outlet.id.toString(),
                    //remark_image: "",
                );
                var response = await sellProductApi(saless);
              //  Constants.increase ++;
              //  selected = true ? Constants.increase +1 : selected =false;
                Get.find<ProductsController>().storeSalesOffline(saless);
                Get.to(ViewOutletstPage());
                Utilities.showInToast(response.message,
                    toastType: response.success
                        ? ToastType.SUCCESS
                        : ToastType.ERROR);

                //  Get.find<ProductsController>().sellProducts(sales);
              } else {
               //  Get.find<ProductsController>().storeSalesOffline(saless);
              }
              print(sales);
              print(outlet.outid);
              print(Get.find<ProductBrandController>().selectedAreaId);
              print(Constants.selectedRoute.id.toString());
            }
          //  Get.find<ProductsController>().removeAllProductFromList();

            // Get.back();
          },
          label: Row(
            children: [
              Icon(Icons.check_circle),
              Text("No Order Remarks"),
            ],
          ),
        ),
        body: GetBuilder<ProductBrandController>(
          builder: (BrandController) {
            return Get.find<ProductBrandController>().productList.isEmpty
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
            ListView.builder(
              itemCount: Get.find<ProductBrandController>().brandList.length,
                itemBuilder: (context,index){
                var item = Get.find<ProductBrandController>().brandList[index];
           //     Get.find<ProductBrandController>().brandList[index] =Get.find<ProductBrandController>().selectedName;
                return    Card(
                 color: item != null ? Colors.white : Colors.white54,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  //   shape: BeveledRectangleBorder(
                  //   borderRadius: BorderRadius.circular(5.0),
                  // ),
                  // shape: StadiumBorder(
                  //     side: BorderSide(
                  //       color: Colors.black,
                  //       width: 1.5,
                  //       borderRadius: BorderRadius.circular(10.0),
                  //     ),),
                  // outlet[index].selected ? Colors.grey
                  elevation: 7.0,
                  child: ListTile(
                    selected: isSelected,
                    onLongPress: selection,
                    title: InkWell(
                      onTap: (){

                        // OutletInfoPages(
                        //   outlet : Get
                        //         .find<OutletsController>()
                        //         .outletList[index],
                        // ));
                     //  Get.to(SellProductPage(outlet:outlet  ));
                        Get.to(DetailsProduct(
                          outlet: outlet,product: Get.find<ProductBrandController>().getNameList(item)
                       ));
                       // print(outlet.name);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment:  MainAxisAlignment.end,
                              children: [
                                // SizedBox(
                                //   width: Get.size.width * 0.3,
                                // ),
                                // CircleAvatar(
                                //     radius: (20),
                                //     backgroundColor:  outlet[index].synced
                                //         ? Colors.blueGrey
                                //         : Colors.grey,
                                //     child:  IconButton(onPressed:(){
                                //      // showQuantityBottomSheet(outlet[index].id.toString());
                                //        Get.bottomSheet(
                                //         Container(
                                //             child: Padding(
                                //               padding: const EdgeInsets.all(10.0),
                                //               child: Column(
                                //                 mainAxisSize: MainAxisSize.min,
                                //                 children: [
                                //
                                //                   Padding(
                                //                     padding: const EdgeInsets.all(10.0),
                                //                     child: GetBuilder<OutletsController>(
                                //                       builder: (builder) {
                                //                         return Get.find<OutletsController>().item.length == null
                                //                             ? SizedBox()
                                //                             : InputDecorator(
                                //                           decoration: decoration("Select Remark"),
                                //                           child: ButtonTheme(
                                //                             alignedDropdown: true,
                                //                             child: DropdownButton<String>(
                                //                               // iconEnabledCo
                                //                               // iconDisabledColor: Colors.red,
                                //                               isDense: true,
                                //                               isExpanded: true,
                                //                               hint: Text(
                                //                                   Get.find<OutletsController>().selectedDrowpdown),
                                //                               items:
                                //                               Get.find<OutletsController>().item.map((e) {
                                //                                 return DropdownMenuItem<String>(
                                //                                     value: e, child: Text(e));
                                //                               }).toList(),
                                //                               onChanged: (String district) {
                                //                                 // setState(() {
                                //                                 Get.find<OutletsController>().selectedDrowpdown = district;
                                //                                 //  Get.find<OutletsController>().setitem(district );
                                //                                 // });
                                //
                                //                                 // district = selectedDrowpdown;
                                //                                 print(Get.find<OutletsController>().selectedDrowpdown);
                                //                                 print(district);
                                //                                 //   print(Get.find<OutletsController>().setitem(district ));
                                //                                 //   district = Constants.item;
                                //                                 //      print(selectedDrowpdown);
                                //                                 //   district = Constants.selectedzone.zone;
                                //                                 // Get.find<AddressController>().getAreaList(district);
                                //                               },
                                //                             ),
                                //                           ),
                                //                         );
                                //                       },
                                //                     ),
                                //                   ),
                                //                   // ElevatedButton(
                                //                   //   onPressed: () async {
                                //                   //     if ( Get.find<OutletsController>().selectedDrowpdown != null  ) {
                                //                   //       // selectedProductList.add({
                                //                   //       //
                                //                   //       //   "remarks":  Get.find<OutletsController>().selectedDrowpdown,
                                //                   //       //
                                //                   //       // });
                                //                   //       //
                                //                   //       // if (selectedProductList.isEmpty) {
                                //                   //       //   Utilities.showInToast("Please add a product",
                                //                   //       //       toastType: ToastType.ERROR);
                                //                   //       //   return;
                                //                   //       // }
                                //                   //
                                //                   //       var sales = Sales(
                                //                   //         orders: '[{ "product_id" :"2", "batch_id": "3", "quantity" : "30", "discount": "10"}]',
                                //                   //         remark: jsonEncode(selectedProductList),
                                //                   //         soldAt:  DateTime.now().toString(),
                                //                   //         outletId: "12",
                                //                   //            outletLatitude : "444444",
                                //                   //        outletLongitude : "4343243423"
                                //                   //       );
                                //                   //       // sales.orders = "dd";
                                //                   //       // // sales.distributorId = "12";
                                //                   //       // sales.remark =jsonEncode(selectedProductList);
                                //                   //       // sales.soldAt = DateTime.now().toString();
                                //                   //       // sales.outletId = Get
                                //                   //       //     .find<OutletsController>()
                                //                   //       //     .outletList[index].id.toString();
                                //                   //       // sales.outletLatitude = "444444";
                                //                   //       // sales.outletLongitude = "4343243423";
                                //                   //
                                //                   //       //  var conn = await Utilities.isInternetWorking();
                                //                   //
                                //                   //
                                //                   //
                                //                   //       Get.find<OutletsController>().addoutletInList(outlet[index].id.toString()) ;
                                //                   //       //else {
                                //                   //       //   Get.find<ProductsController>().storeSalesOffline(sales);
                                //                   //       // }
                                //                   //       //
                                //                   //       // Get.find<ProductsController>().removeAllProductFromList();
                                //                   //   //    Get.find<ProductsController>().sellProducts(sales);
                                //                   //           var conn = await Utilities.isInternetWorking();
                                //                   //       if (conn) {
                                //                   //         var response = await sellProductApi(sales);
                                //                   //         print(sales);
                                //                   //         // Get.back();
                                //                   //         Utilities.showInToast(response.message,
                                //                   //             toastType: response.success
                                //                   //                 ? ToastType.SUCCESS
                                //                   //                 : ToastType.ERROR);
                                //                   //
                                //                   //         //   if (response.success) {
                                //                   //         //     outlet.synced = true;
                                //                   //         //     Get.back();
                                //                   //         //   }
                                //                   //         // } else {
                                //                   //         //   Get.back();
                                //                   //         //   outlet.synced = false;
                                //                   //         //
                                //                   //         //   Utilities.showInToast('Storing Offline',
                                //                   //         //       toastType: ToastType.INFO);
                                //                   //         // }
                                //                   //         // await DatabaseHelper.instance
                                //                   //         //     .insertOutlet(outlet);
                                //                   //         // Get.find<ProductsController>().addremark(sales);
                                //                   //         Get.back();
                                //                   //       } else {
                                //                   //         Utilities.showInToast('Please complete the form',
                                //                   //             toastType: ToastType.ERROR);
                                //                   //       }
                                //                   //     } else {
                                //                   //       Utilities.showInToast("Please add quantity");
                                //                   //     }
                                //                   //     Get.back(
                                //                   //
                                //                   //     );
                                //                   //   },
                                //                   //   child: Text("Add"),
                                //                   // )
                                //                 ],
                                //               ),
                                //             )),
                                //         shape: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                                //         backgroundColor: Colors.white,
                                //         enableDrag: true,
                                //       );
                                //       // Get.bottomSheet(
                                //       //   // ListView.builder(itemCount: Get.find<OutletsController>().item?.length != null ? Get.find<OutletsController>().item?.length  : "",
                                //       //   //   itemBuilder: (context, index){
                                //       //   //     return
                                //       //   Container(
                                //       //       child: Padding(
                                //       //         padding: const EdgeInsets.all(10.0),
                                //       //         child: Column(
                                //       //           mainAxisSize: MainAxisSize.min,
                                //       //           children: [
                                //       //             Padding(
                                //       //                 padding: const EdgeInsets.all(12.0),
                                //       //                 child:
                                //       //                 // DropdownButton(
                                //       //                 //
                                //       //                 //   // Initial Value
                                //       //                 //     value: selectedDrowpdown,
                                //       //                 //
                                //       //                 //     // Down Arrow Icon
                                //       //                 //     icon: const Icon(Icons.keyboard_arrow_down),
                                //       //                 //
                                //       //                 //     // Array list of items
                                //       //                 //     items: item.map((String items) {
                                //       //                 //       return DropdownMenuItem(
                                //       //                 //         value: items,
                                //       //                 //         child: Text(items),
                                //       //                 //       );
                                //       //                 //     }).toList(),
                                //       //                 // After selecting the desired option,it will
                                //       //                 // change button value to selected value
                                //       //                 // onChanged: (String newValue) {
                                //       //                 //   setState(() {
                                //       //                 //     selectedDrowpdown = newValue;
                                //       //                 //   });
                                //       //                 //                 DropdownButton(
                                //       //                 //                 hint: Text("Outlet Closed Image"), // Not necessary for Option 1
                                //       //                 //   value:selectedDrowpdown,
                                //       //                 //   onChanged: (newValue) {
                                //       //                 //     selectedDrowpdown = newValue;
                                //       //                 //   setState(() {
                                //       //                 //   selectedDrowpdown = newValue;
                                //       //                 // //  print(newValue);
                                //       //                 //   //print(selectedDrowpdown);
                                //       //                 //   });
                                //       //                 //   },
                                //       //                 //   items: item.map((location) {
                                //       //                 //   return DropdownMenuItem(
                                //       //                 //   child: new Text(location),
                                //       //                 //   value: location,
                                //       //                 //   );
                                //       //                 //   }).toList(),
                                //       //                 //   ),
                                //       //                 Padding(
                                //       //                   padding: const EdgeInsets.all(10.0),
                                //       //                   child: GetBuilder<OutletsController>(
                                //       //                     builder: (builder) {
                                //       //                       return Get.find<OutletsController>().item.length == null
                                //       //                           ? SizedBox()
                                //       //                           : InputDecorator(
                                //       //                         decoration: decoration("Select Remark"),
                                //       //                         child: ButtonTheme(
                                //       //                           alignedDropdown: true,
                                //       //                           child: DropdownButton<String>(
                                //       //                             // iconEnabledCo
                                //       //                             // iconDisabledColor: Colors.red,
                                //       //                             isDense: true,
                                //       //                             isExpanded: true,
                                //       //                             hint: Text(
                                //       //                                 Get.find<OutletsController>().selectedDrowpdown),
                                //       //                             items:
                                //       //                             Get.find<OutletsController>().item.map((e) {
                                //       //                               return DropdownMenuItem<String>(
                                //       //                                   value: e, child: Text(e));
                                //       //                             }).toList(),
                                //       //                             onChanged: (String district) {
                                //       //                               // setState(() {
                                //       //                                 Get.find<OutletsController>().selectedDrowpdown = district;
                                //       //                                 //  Get.find<OutletsController>().setitem(district );
                                //       //                              // });
                                //       //
                                //       //                               // district = selectedDrowpdown;
                                //       //                               print(Get.find<OutletsController>().selectedDrowpdown);
                                //       //                               print(district);
                                //       //                               //   print(Get.find<OutletsController>().setitem(district ));
                                //       //                               //   district = Constants.item;
                                //       //                               //      print(selectedDrowpdown);
                                //       //                               //   district = Constants.selectedzone.zone;
                                //       //                               // Get.find<AddressController>().getAreaList(district);
                                //       //                             },
                                //       //                           ),
                                //       //                         ),
                                //       //                       );
                                //       //                     },
                                //       //                   ),
                                //       //                 )
                                //       //               // DropdownButton<String>(
                                //       //               //   hint: Text("Remark"),
                                //       //               //   value:  selectedDrowpdown,
                                //       //               //   items:
                                //       //               //   //[for(var data in  Get.find<OutletsController>().item)])
                                //       //               //   // [
                                //       //               //   //   for (var data in Get.find<OutletsController>().item)
                                //       //               //   //     DropdownMenuItem(
                                //       //               //   //       child: new Text(
                                //       //               //   //         data,
                                //       //               //   //       ),
                                //       //               //   //       value: data,
                                //       //               //   //     )
                                //       //               //   // ],
                                //       //               //
                                //       //               //   // Get.find<OutletsController>().item.map((e) {
                                //       //               //   //   return DropdownMenuItem<String>(
                                //       //               //   //           value: e,
                                //       //               //   //           child: Text(e),
                                //       //               //   //         );
                                //       //               //   // }),
                                //       //               //     item.map((  value) {
                                //       //               //     return DropdownMenuItem<String>(
                                //       //               //       value: value,
                                //       //               //       child: Text(value),
                                //       //               //     );
                                //       //               //   }).toList(),
                                //       //               //   onChanged: (newvalue) {
                                //       //               //     setState(() {
                                //       //               //      selectedDrowpdown = newvalue ;
                                //       //               //     });
                                //       //               //
                                //       //               // //   Get.find<OutletsController>().setitem(newvalue);
                                //       //               //
                                //       //               //
                                //       //               //    //_selectedvalue = newvalue;
                                //       //               //   })
                                //       //             ),
                                //       //
                                //       //             SizedBox(height: Get.size.height * 0.01),
                                //       //             // Container(
                                //       //             //   child: _imageFile == null
                                //       //             //       ? Center(
                                //       //             //     child: Text("No Image Selected"),
                                //       //             //   )
                                //       //             //       : Image.file(File(_imageFile.path)),
                                //       //             // ),
                                //       //             ElevatedButton(
                                //       //               onPressed: () async {
                                //       //                 // pickImage();
                                //       //                 if (Get.find<OutletsController>().selectedDrowpdown.isNotEmpty) {
                                //       //                   var conn = await Utilities.isInternetWorking();
                                //       //                   showDialog(
                                //       //                       barrierDismissible: false,
                                //       //                       context: context,
                                //       //                       builder: (context) {
                                //       //                         return CupertinoAlertDialog(
                                //       //                           title: Text('Please Wait'),
                                //       //                           content: Column(
                                //       //                             children: [
                                //       //                               Divider(),
                                //       //                               Padding(
                                //       //                                 padding: const EdgeInsets.all(8.0),
                                //       //                                 child: Text(conn
                                //       //                                     ? 'Registering new Sales Outlet'
                                //       //                                     : 'Saving offline'),
                                //       //                               ),
                                //       //                               CupertinoActivityIndicator(
                                //       //                                 radius: 17,
                                //       //                               )
                                //       //                             ],
                                //       //                           ),
                                //       //                         );
                                //       //                       });
                                //       //                   // var sales = Sales(
                                //       //                   //     outletId:  outlet[index].id.toString(),
                                //       //                   //     remark:  Get.find<OutletsController>().selectedDrowpdown
                                //       //                   // );
                                //       //                   // selectedoutlet.add({
                                //       //                   //   //"outlet_id": outletId,
                                //       //                   //
                                //       //                   //   "remark": selectedDrowpdown,
                                //       //                   //
                                //       //                   // });
                                //       //                   if (conn) {
                                //       //                     var response = await sellProductApi(sales);
                                //       //                     print(sales);
                                //       //                     // Get.back();
                                //       //                     Utilities.showInToast(response.message,
                                //       //                         toastType: response.success
                                //       //                             ? ToastType.SUCCESS
                                //       //                             : ToastType.ERROR);
                                //       //
                                //       //                     //   if (response.success) {
                                //       //                     //     outlet.synced = true;
                                //       //                     //     Get.back();
                                //       //                     //   }
                                //       //                     // } else {
                                //       //                     //   Get.back();
                                //       //                     //   outlet.synced = false;
                                //       //                     //
                                //       //                     //   Utilities.showInToast('Storing Offline',
                                //       //                     //       toastType: ToastType.INFO);
                                //       //                     // }
                                //       //                     // await DatabaseHelper.instance
                                //       //                     //     .insertOutlet(outlet);
                                //       //                     // Get.find<ProductsController>().addremark(sales);
                                //       //                     Get.back();
                                //       //                   } else {
                                //       //                     Utilities.showInToast('Please complete the form',
                                //       //                         toastType: ToastType.ERROR);
                                //       //                   }
                                //       //                   // if (selectedDrowpdown != null) {
                                //       //                   //   // selectedoutlet.add({
                                //       //                   //   //   //"outlet_id": outletId,
                                //       //                   //   //
                                //       //                   //   //   "remark": selectedDrowpdown,
                                //       //                   //   //
                                //       //                   //   // });
                                //       //                   //   sales.remark = jsonEncode(selectedoutlet);
                                //       //                   //   Get.find<OutletsController>().addoutletInList(outletId);
                                //       //                   //   //Get.find<ProductsController>().addremark(selectedoutlet);
                                //       //                   //   Utilities.showInToast("Remark Noted");
                                //       //                   //   print(selectedDrowpdown);
                                //       //                   // } else {
                                //       //                   //   Utilities.showInToast("Please add Remark");
                                //       //                   // }
                                //       //                   Get.back();}
                                //       //               },
                                //       //               child: Text("Add"),
                                //       //             ),
                                //       //           //  outlet.id..toString().isEmpty
                                //       //           //       ? ElevatedButton(
                                //       //           //     onPressed: () {
                                //       //           //       showQuantityBottomSheet(null, products.id.toString());
                                //       //           //     },
                                //       //           //     child: Text("Sell"),
                                //       //           //   )
                                //       //           //       : ExpansionTile(
                                //       //           //     title: Text("Batches"),
                                //       //           //     children: products.batches.map((batch) {
                                //       //           //       return buildBatchTile(batch, products);
                                //       //           //     }).toList(),
                                //       //           //   ),
                                //       //           ],
                                //       //         ),)),
                                //       //
                                //       //
                                //       //
                                //       //
                                //       //   shape: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                                //       //   backgroundColor: Colors.white,
                                //       //   enableDrag: true,
                                //       // );
                                //     } , icon: Icon(Icons.add))
                                // )
                              ],
                            ),
                            Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(  padding: const EdgeInsets.all(10.0),
                                        child:   Row(
                                          children: [
                                            Text(
                                              item,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),

                                          ],
                                        )

                                    ),

                                    // Padding(
                                    //   padding: const EdgeInsets.only(top: 1),
                                    //   child:
                                    // Text(
                                    //   outlet[index].name,
                                    //   style: TextStyle(
                                    //       fontSize: 18,
                                    //       fontWeight: FontWeight.bold),
                                    // ),
                                    // //    ),
                                    // Container(
                                    //   child:   Text(
                                    //     "Number of Outlet: ${outlet.length.toString()}",
                                    //     style: TextStyle(
                                    //         fontSize: 10,
                                    //         fontWeight: FontWeight.bold),
                                    //   ),
                                    // ),
                                    // Text(
                                    //   outlet[index].name,
                                    //   style: TextStyle(
                                    //       fontSize: 10,
                                    //       fontWeight: FontWeight.bold),
                                    // ),

                                  ],
                                )
                            ),

                            // MaterialButton(
                            //   onPressed: () {
                            //     Get.to(() =>
                            //         SellProductPage(
                            //           outlet: Get
                            //               .find<OutletsController>()
                            //               .outletList[index],
                            //         ));
                            //
                            //   },
                            //   color: Colors.green[900],
                            //   minWidth: Get.size.width,
                            //   textColor: Colors.white,
                            //   padding: EdgeInsets.all(10.0),
                            //   child: Text("Sell Product"),
                            // ),

                          ],
                        ),
                      ),
                    ),
                  ),
                );
                //   ListTile(
                //   onTap: (){
                //     Get.find<ProductBrandController>().setSelectedBrand(item);
                //
                //     Get.to(DetailsProduct(
                //       product: Get.find<ProductBrandController>().getNameList(item)),
                //
                //     );
                //   },
                //   title: Text(item),
                // );
                });
          },
        ),
      ),
    );
  }
  void selection(){
    if(isSelected){
      mycolor = Colors.white;
      isSelected = false;
    }else{
      mycolor = Colors.grey[300];
      isSelected = true;
    }
  }
}