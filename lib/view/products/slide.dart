// import 'package:flutter/cupertino.dart';
//
// import 'package:pdf/widgets.dart';
//
// class Slide extends StatelessWidget{
//   // String names;
//   // String title;
//
//   // Slide({
//   //   this.names, this.title
//   // });
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controller/productbrand_controller.dart';
import 'detailsofproducts.dart';


class Slide extends StatelessWidget{
  // String names;
  String title;
  ListView names;

  Slide({
    this.names, this.title
  });
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return Container(
     padding: EdgeInsets.all(20),
     child: GetBuilder<ProductBrandController>(
       builder: (BrandController)
   {
     return Get
         .find<ProductBrandController>()
         .productList
         .isEmpty
         ? Center(
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           CupertinoActivityIndicator(),
         ],
       ),
     ) :
     names;
   }));
         //     ElevatedButton(onPressed: (){
         //       print(Get.find<ProductBrandController>().productList.length);
         // }, child: Text("press"));
        //  ListView.builder(
        //    itemCount: Get.find<ProductBrandController>().brandList.length,
        //      itemBuilder: (context,index){
        //      var item = Get.find<ProductBrandController>().brandList[index];
        // //     Get.find<ProductBrandController>().brandList[index] =Get.find<ProductBrandController>().selectedName;
        //      return    Card(
        //       color: item != null ? Colors.white : Colors.white54,
        //        shape: RoundedRectangleBorder(
        //          borderRadius: BorderRadius.circular(12.0),
        //        ),
        //        //   shape: BeveledRectangleBorder(
        //        //   borderRadius: BorderRadius.circular(5.0),
        //        // ),
        //        // shape: StadiumBorder(
        //        //     side: BorderSide(
        //        //       color: Colors.black,
        //        //       width: 1.5,
        //        //       borderRadius: BorderRadius.circular(10.0),
        //        //     ),),
        //        // outlet[index].selected ? Colors.grey
        //        elevation: 7.0,
        //        child: ListTile(
        //          // selected: isSelected,
        //          // onLongPress: selection,
        //          title: InkWell(
        //            onTap: (){
        //
        //              // OutletInfoPages(
        //              //   outlet : Get
        //              //         .find<OutletsController>()
        //              //         .outletList[index],
        //              // ));
        //           //  Get.to(SellProductPage(outlet:outlet  ));
        //           //    Get.to(DetailsProduct(
        //           //      outlet: outlet,product: Get.find<ProductBrandController>().getNameList(item)
        //           //   ));
        //             // print(outlet.name);
        //            },
        //            child: Padding(
        //              padding: const EdgeInsets.all(10.0),
        //              child: Column(
        //                crossAxisAlignment: CrossAxisAlignment.start,
        //                mainAxisSize: MainAxisSize.min,
        //                children: [
        //                  Row(
        //                    mainAxisAlignment:  MainAxisAlignment.end,
        //                    children: [
        //                      // SizedBox(
        //                      //   width: Get.size.width * 0.3,
        //                      // ),
        //                      // CircleAvatar(
        //                      //     radius: (20),
        //                      //     backgroundColor:  outlet[index].synced
        //                      //         ? Colors.blueGrey
        //                      //         : Colors.grey,
        //                      //     child:  IconButton(onPressed:(){
        //                      //      // showQuantityBottomSheet(outlet[index].id.toString());
        //                      //        Get.bottomSheet(
        //                      //         Container(
        //                      //             child: Padding(
        //                      //               padding: const EdgeInsets.all(10.0),
        //                      //               child: Column(
        //                      //                 mainAxisSize: MainAxisSize.min,
        //                      //                 children: [
        //                      //
        //                      //                   Padding(
        //                      //                     padding: const EdgeInsets.all(10.0),
        //                      //                     child: GetBuilder<OutletsController>(
        //                      //                       builder: (builder) {
        //                      //                         return Get.find<OutletsController>().item.length == null
        //                      //                             ? SizedBox()
        //                      //                             : InputDecorator(
        //                      //                           decoration: decoration("Select Remark"),
        //                      //                           child: ButtonTheme(
        //                      //                             alignedDropdown: true,
        //                      //                             child: DropdownButton<String>(
        //                      //                               // iconEnabledCo
        //                      //                               // iconDisabledColor: Colors.red,
        //                      //                               isDense: true,
        //                      //                               isExpanded: true,
        //                      //                               hint: Text(
        //                      //                                   Get.find<OutletsController>().selectedDrowpdown),
        //                      //                               items:
        //                      //                               Get.find<OutletsController>().item.map((e) {
        //                      //                                 return DropdownMenuItem<String>(
        //                      //                                     value: e, child: Text(e));
        //                      //                               }).toList(),
        //                      //                               onChanged: (String district) {
        //                      //                                 // setState(() {
        //                      //                                 Get.find<OutletsController>().selectedDrowpdown = district;
        //                      //                                 //  Get.find<OutletsController>().setitem(district );
        //                      //                                 // });
        //                      //
        //                      //                                 // district = selectedDrowpdown;
        //                      //                                 print(Get.find<OutletsController>().selectedDrowpdown);
        //                      //                                 print(district);
        //                      //                                 //   print(Get.find<OutletsController>().setitem(district ));
        //                      //                                 //   district = Constants.item;
        //                      //                                 //      print(selectedDrowpdown);
        //                      //                                 //   district = Constants.selectedzone.zone;
        //                      //                                 // Get.find<AddressController>().getAreaList(district);
        //                      //                               },
        //                      //                             ),
        //                      //                           ),
        //                      //                         );
        //                      //                       },
        //                      //                     ),
        //                      //                   ),
        //                      //                   // ElevatedButton(
        //                      //                   //   onPressed: () async {
        //                      //                   //     if ( Get.find<OutletsController>().selectedDrowpdown != null  ) {
        //                      //                   //       // selectedProductList.add({
        //                      //                   //       //
        //                      //                   //       //   "remarks":  Get.find<OutletsController>().selectedDrowpdown,
        //                      //                   //       //
        //                      //                   //       // });
        //                      //                   //       //
        //                      //                   //       // if (selectedProductList.isEmpty) {
        //                      //                   //       //   Utilities.showInToast("Please add a product",
        //                      //                   //       //       toastType: ToastType.ERROR);
        //                      //                   //       //   return;
        //                      //                   //       // }
        //                      //                   //
        //                      //                   //       var sales = Sales(
        //                      //                   //         orders: '[{ "product_id" :"2", "batch_id": "3", "quantity" : "30", "discount": "10"}]',
        //                      //                   //         remark: jsonEncode(selectedProductList),
        //                      //                   //         soldAt:  DateTime.now().toString(),
        //                      //                   //         outletId: "12",
        //                      //                   //            outletLatitude : "444444",
        //                      //                   //        outletLongitude : "4343243423"
        //                      //                   //       );
        //                      //                   //       // sales.orders = "dd";
        //                      //                   //       // // sales.distributorId = "12";
        //                      //                   //       // sales.remark =jsonEncode(selectedProductList);
        //                      //                   //       // sales.soldAt = DateTime.now().toString();
        //                      //                   //       // sales.outletId = Get
        //                      //                   //       //     .find<OutletsController>()
        //                      //                   //       //     .outletList[index].id.toString();
        //                      //                   //       // sales.outletLatitude = "444444";
        //                      //                   //       // sales.outletLongitude = "4343243423";
        //                      //                   //
        //                      //                   //       //  var conn = await Utilities.isInternetWorking();
        //                      //                   //
        //                      //                   //
        //                      //                   //
        //                      //                   //       Get.find<OutletsController>().addoutletInList(outlet[index].id.toString()) ;
        //                      //                   //       //else {
        //                      //                   //       //   Get.find<ProductsController>().storeSalesOffline(sales);
        //                      //                   //       // }
        //                      //                   //       //
        //                      //                   //       // Get.find<ProductsController>().removeAllProductFromList();
        //                      //                   //   //    Get.find<ProductsController>().sellProducts(sales);
        //                      //                   //           var conn = await Utilities.isInternetWorking();
        //                      //                   //       if (conn) {
        //                      //                   //         var response = await sellProductApi(sales);
        //                      //                   //         print(sales);
        //                      //                   //         // Get.back();
        //                      //                   //         Utilities.showInToast(response.message,
        //                      //                   //             toastType: response.success
        //                      //                   //                 ? ToastType.SUCCESS
        //                      //                   //                 : ToastType.ERROR);
        //                      //                   //
        //                      //                   //         //   if (response.success) {
        //                      //                   //         //     outlet.synced = true;
        //                      //                   //         //     Get.back();
        //                      //                   //         //   }
        //                      //                   //         // } else {
        //                      //                   //         //   Get.back();
        //                      //                   //         //   outlet.synced = false;
        //                      //                   //         //
        //                      //                   //         //   Utilities.showInToast('Storing Offline',
        //                      //                   //         //       toastType: ToastType.INFO);
        //                      //                   //         // }
        //                      //                   //         // await DatabaseHelper.instance
        //                      //                   //         //     .insertOutlet(outlet);
        //                      //                   //         // Get.find<ProductsController>().addremark(sales);
        //                      //                   //         Get.back();
        //                      //                   //       } else {
        //                      //                   //         Utilities.showInToast('Please complete the form',
        //                      //                   //             toastType: ToastType.ERROR);
        //                      //                   //       }
        //                      //                   //     } else {
        //                      //                   //       Utilities.showInToast("Please add quantity");
        //                      //                   //     }
        //                      //                   //     Get.back(
        //                      //                   //
        //                      //                   //     );
        //                      //                   //   },
        //                      //                   //   child: Text("Add"),
        //                      //                   // )
        //                      //                 ],
        //                      //               ),
        //                      //             )),
        //                      //         shape: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        //                      //         backgroundColor: Colors.white,
        //                      //         enableDrag: true,
        //                      //       );
        //                      //       // Get.bottomSheet(
        //                      //       //   // ListView.builder(itemCount: Get.find<OutletsController>().item?.length != null ? Get.find<OutletsController>().item?.length  : "",
        //                      //       //   //   itemBuilder: (context, index){
        //                      //       //   //     return
        //                      //       //   Container(
        //                      //       //       child: Padding(
        //                      //       //         padding: const EdgeInsets.all(10.0),
        //                      //       //         child: Column(
        //                      //       //           mainAxisSize: MainAxisSize.min,
        //                      //       //           children: [
        //                      //       //             Padding(
        //                      //       //                 padding: const EdgeInsets.all(12.0),
        //                      //       //                 child:
        //                      //       //                 // DropdownButton(
        //                      //       //                 //
        //                      //       //                 //   // Initial Value
        //                      //       //                 //     value: selectedDrowpdown,
        //                      //       //                 //
        //                      //       //                 //     // Down Arrow Icon
        //                      //       //                 //     icon: const Icon(Icons.keyboard_arrow_down),
        //                      //       //                 //
        //                      //       //                 //     // Array list of items
        //                      //       //                 //     items: item.map((String items) {
        //                      //       //                 //       return DropdownMenuItem(
        //                      //       //                 //         value: items,
        //                      //       //                 //         child: Text(items),
        //                      //       //                 //       );
        //                      //       //                 //     }).toList(),
        //                      //       //                 // After selecting the desired option,it will
        //                      //       //                 // change button value to selected value
        //                      //       //                 // onChanged: (String newValue) {
        //                      //       //                 //   setState(() {
        //                      //       //                 //     selectedDrowpdown = newValue;
        //                      //       //                 //   });
        //                      //       //                 //                 DropdownButton(
        //                      //       //                 //                 hint: Text("Outlet Closed Image"), // Not necessary for Option 1
        //                      //       //                 //   value:selectedDrowpdown,
        //                      //       //                 //   onChanged: (newValue) {
        //                      //       //                 //     selectedDrowpdown = newValue;
        //                      //       //                 //   setState(() {
        //                      //       //                 //   selectedDrowpdown = newValue;
        //                      //       //                 // //  print(newValue);
        //                      //       //                 //   //print(selectedDrowpdown);
        //                      //       //                 //   });
        //                      //       //                 //   },
        //                      //       //                 //   items: item.map((location) {
        //                      //       //                 //   return DropdownMenuItem(
        //                      //       //                 //   child: new Text(location),
        //                      //       //                 //   value: location,
        //                      //       //                 //   );
        //                      //       //                 //   }).toList(),
        //                      //       //                 //   ),
        //                      //       //                 Padding(
        //                      //       //                   padding: const EdgeInsets.all(10.0),
        //                      //       //                   child: GetBuilder<OutletsController>(
        //                      //       //                     builder: (builder) {
        //                      //       //                       return Get.find<OutletsController>().item.length == null
        //                      //       //                           ? SizedBox()
        //                      //       //                           : InputDecorator(
        //                      //       //                         decoration: decoration("Select Remark"),
        //                      //       //                         child: ButtonTheme(
        //                      //       //                           alignedDropdown: true,
        //                      //       //                           child: DropdownButton<String>(
        //                      //       //                             // iconEnabledCo
        //                      //       //                             // iconDisabledColor: Colors.red,
        //                      //       //                             isDense: true,
        //                      //       //                             isExpanded: true,
        //                      //       //                             hint: Text(
        //                      //       //                                 Get.find<OutletsController>().selectedDrowpdown),
        //                      //       //                             items:
        //                      //       //                             Get.find<OutletsController>().item.map((e) {
        //                      //       //                               return DropdownMenuItem<String>(
        //                      //       //                                   value: e, child: Text(e));
        //                      //       //                             }).toList(),
        //                      //       //                             onChanged: (String district) {
        //                      //       //                               // setState(() {
        //                      //       //                                 Get.find<OutletsController>().selectedDrowpdown = district;
        //                      //       //                                 //  Get.find<OutletsController>().setitem(district );
        //                      //       //                              // });
        //                      //       //
        //                      //       //                               // district = selectedDrowpdown;
        //                      //       //                               print(Get.find<OutletsController>().selectedDrowpdown);
        //                      //       //                               print(district);
        //                      //       //                               //   print(Get.find<OutletsController>().setitem(district ));
        //                      //       //                               //   district = Constants.item;
        //                      //       //                               //      print(selectedDrowpdown);
        //                      //       //                               //   district = Constants.selectedzone.zone;
        //                      //       //                               // Get.find<AddressController>().getAreaList(district);
        //                      //       //                             },
        //                      //       //                           ),
        //                      //       //                         ),
        //                      //       //                       );
        //                      //       //                     },
        //                      //       //                   ),
        //                      //       //                 )
        //                      //       //               // DropdownButton<String>(
        //                      //       //               //   hint: Text("Remark"),
        //                      //       //               //   value:  selectedDrowpdown,
        //                      //       //               //   items:
        //                      //       //               //   //[for(var data in  Get.find<OutletsController>().item)])
        //                      //       //               //   // [
        //                      //       //               //   //   for (var data in Get.find<OutletsController>().item)
        //                      //       //               //   //     DropdownMenuItem(
        //                      //       //               //   //       child: new Text(
        //                      //       //               //   //         data,
        //                      //       //               //   //       ),
        //                      //       //               //   //       value: data,
        //                      //       //               //   //     )
        //                      //       //               //   // ],
        //                      //       //               //
        //                      //       //               //   // Get.find<OutletsController>().item.map((e) {
        //                      //       //               //   //   return DropdownMenuItem<String>(
        //                      //       //               //   //           value: e,
        //                      //       //               //   //           child: Text(e),
        //                      //       //               //   //         );
        //                      //       //               //   // }),
        //                      //       //               //     item.map((  value) {
        //                      //       //               //     return DropdownMenuItem<String>(
        //                      //       //               //       value: value,
        //                      //       //               //       child: Text(value),
        //                      //       //               //     );
        //                      //       //               //   }).toList(),
        //                      //       //               //   onChanged: (newvalue) {
        //                      //       //               //     setState(() {
        //                      //       //               //      selectedDrowpdown = newvalue ;
        //                      //       //               //     });
        //                      //       //               //
        //                      //       //               // //   Get.find<OutletsController>().setitem(newvalue);
        //                      //       //               //
        //                      //       //               //
        //                      //       //               //    //_selectedvalue = newvalue;
        //                      //       //               //   })
        //                      //       //             ),
        //                      //       //
        //                      //       //             SizedBox(height: Get.size.height * 0.01),
        //                      //       //             // Container(
        //                      //       //             //   child: _imageFile == null
        //                      //       //             //       ? Center(
        //                      //       //             //     child: Text("No Image Selected"),
        //                      //       //             //   )
        //                      //       //             //       : Image.file(File(_imageFile.path)),
        //                      //       //             // ),
        //                      //       //             ElevatedButton(
        //                      //       //               onPressed: () async {
        //                      //       //                 // pickImage();
        //                      //       //                 if (Get.find<OutletsController>().selectedDrowpdown.isNotEmpty) {
        //                      //       //                   var conn = await Utilities.isInternetWorking();
        //                      //       //                   showDialog(
        //                      //       //                       barrierDismissible: false,
        //                      //       //                       context: context,
        //                      //       //                       builder: (context) {
        //                      //       //                         return CupertinoAlertDialog(
        //                      //       //                           title: Text('Please Wait'),
        //                      //       //                           content: Column(
        //                      //       //                             children: [
        //                      //       //                               Divider(),
        //                      //       //                               Padding(
        //                      //       //                                 padding: const EdgeInsets.all(8.0),
        //                      //       //                                 child: Text(conn
        //                      //       //                                     ? 'Registering new Sales Outlet'
        //                      //       //                                     : 'Saving offline'),
        //                      //       //                               ),
        //                      //       //                               CupertinoActivityIndicator(
        //                      //       //                                 radius: 17,
        //                      //       //                               )
        //                      //       //                             ],
        //                      //       //                           ),
        //                      //       //                         );
        //                      //       //                       });
        //                      //       //                   // var sales = Sales(
        //                      //       //                   //     outletId:  outlet[index].id.toString(),
        //                      //       //                   //     remark:  Get.find<OutletsController>().selectedDrowpdown
        //                      //       //                   // );
        //                      //       //                   // selectedoutlet.add({
        //                      //       //                   //   //"outlet_id": outletId,
        //                      //       //                   //
        //                      //       //                   //   "remark": selectedDrowpdown,
        //                      //       //                   //
        //                      //       //                   // });
        //                      //       //                   if (conn) {
        //                      //       //                     var response = await sellProductApi(sales);
        //                      //       //                     print(sales);
        //                      //       //                     // Get.back();
        //                      //       //                     Utilities.showInToast(response.message,
        //                      //       //                         toastType: response.success
        //                      //       //                             ? ToastType.SUCCESS
        //                      //       //                             : ToastType.ERROR);
        //                      //       //
        //                      //       //                     //   if (response.success) {
        //                      //       //                     //     outlet.synced = true;
        //                      //       //                     //     Get.back();
        //                      //       //                     //   }
        //                      //       //                     // } else {
        //                      //       //                     //   Get.back();
        //                      //       //                     //   outlet.synced = false;
        //                      //       //                     //
        //                      //       //                     //   Utilities.showInToast('Storing Offline',
        //                      //       //                     //       toastType: ToastType.INFO);
        //                      //       //                     // }
        //                      //       //                     // await DatabaseHelper.instance
        //                      //       //                     //     .insertOutlet(outlet);
        //                      //       //                     // Get.find<ProductsController>().addremark(sales);
        //                      //       //                     Get.back();
        //                      //       //                   } else {
        //                      //       //                     Utilities.showInToast('Please complete the form',
        //                      //       //                         toastType: ToastType.ERROR);
        //                      //       //                   }
        //                      //       //                   // if (selectedDrowpdown != null) {
        //                      //       //                   //   // selectedoutlet.add({
        //                      //       //                   //   //   //"outlet_id": outletId,
        //                      //       //                   //   //
        //                      //       //                   //   //   "remark": selectedDrowpdown,
        //                      //       //                   //   //
        //                      //       //                   //   // });
        //                      //       //                   //   sales.remark = jsonEncode(selectedoutlet);
        //                      //       //                   //   Get.find<OutletsController>().addoutletInList(outletId);
        //                      //       //                   //   //Get.find<ProductsController>().addremark(selectedoutlet);
        //                      //       //                   //   Utilities.showInToast("Remark Noted");
        //                      //       //                   //   print(selectedDrowpdown);
        //                      //       //                   // } else {
        //                      //       //                   //   Utilities.showInToast("Please add Remark");
        //                      //       //                   // }
        //                      //       //                   Get.back();}
        //                      //       //               },
        //                      //       //               child: Text("Add"),
        //                      //       //             ),
        //                      //       //           //  outlet.id..toString().isEmpty
        //                      //       //           //       ? ElevatedButton(
        //                      //       //           //     onPressed: () {
        //                      //       //           //       showQuantityBottomSheet(null, products.id.toString());
        //                      //       //           //     },
        //                      //       //           //     child: Text("Sell"),
        //                      //       //           //   )
        //                      //       //           //       : ExpansionTile(
        //                      //       //           //     title: Text("Batches"),
        //                      //       //           //     children: products.batches.map((batch) {
        //                      //       //           //       return buildBatchTile(batch, products);
        //                      //       //           //     }).toList(),
        //                      //       //           //   ),
        //                      //       //           ],
        //                      //       //         ),)),
        //                      //       //
        //                      //       //
        //                      //       //
        //                      //       //
        //                      //       //   shape: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        //                      //       //   backgroundColor: Colors.white,
        //                      //       //   enableDrag: true,
        //                      //       // );
        //                      //     } , icon: Icon(Icons.add))
        //                      // )
        //                    ],
        //                  ),
        //                  Container(
        //                      child: Column(
        //                        mainAxisAlignment: MainAxisAlignment.start,
        //                        children: [
        //                          Padding(  padding: const EdgeInsets.all(10.0),
        //                              child:   Row(
        //                                children: [
        //                                  Text(
        //                                    item,
        //                                    style: TextStyle(
        //                                        fontSize: 15,
        //                                        fontWeight: FontWeight.bold),
        //                                  ),
        //
        //                                ],
        //                              )
        //
        //                          ),
        //
        //                          // Padding(
        //                          //   padding: const EdgeInsets.only(top: 1),
        //                          //   child:
        //                          // Text(
        //                          //   outlet[index].name,
        //                          //   style: TextStyle(
        //                          //       fontSize: 18,
        //                          //       fontWeight: FontWeight.bold),
        //                          // ),
        //                          // //    ),
        //                          // Container(
        //                          //   child:   Text(
        //                          //     "Number of Outlet: ${outlet.length.toString()}",
        //                          //     style: TextStyle(
        //                          //         fontSize: 10,
        //                          //         fontWeight: FontWeight.bold),
        //                          //   ),
        //                          // ),
        //                          // Text(
        //                          //   outlet[index].name,
        //                          //   style: TextStyle(
        //                          //       fontSize: 10,
        //                          //       fontWeight: FontWeight.bold),
        //                          // ),
        //
        //                        ],
        //                      )
        //                  ),
        //
        //                  // MaterialButton(
        //                  //   onPressed: () {
        //                  //     Get.to(() =>
        //                  //         SellProductPage(
        //                  //           outlet: Get
        //                  //               .find<OutletsController>()
        //                  //               .outletList[index],
        //                  //         ));
        //                  //
        //                  //   },
        //                  //   color: Colors.green[900],
        //                  //   minWidth: Get.size.width,
        //                  //   textColor: Colors.white,
        //                  //   padding: EdgeInsets.all(10.0),
        //                  //   child: Text("Sell Product"),
        //                  // ),
        //
        //                ],
        //              ),
        //            ),
        //          ),
        //        ),
        //      );
        //      //   ListTile(
        //      //   onTap: (){
        //      //     Get.find<ProductBrandController>().setSelectedBrand(item);
        //      //
        //      //     Get.to(DetailsProduct(
        //      //       product: Get.find<ProductBrandController>().getNameList(item)),
        //      // // GetBuilder<ProductBrandController>(
        //      //   builder: (BrandController) {
        //      //     return Get.find<ProductBrandController>().productList.isEmpty
        //      //         ? Center(
        //      //       child: Column(
        //      //         mainAxisAlignment: MainAxisAlignment.center,
        //      //         children: [
        //      //           CupertinoActivityIndicator(),
        //      //         ],
        //      //       ),
        //      //     )
        //      //          :
        //      //     //     ElevatedButton(onPressed: (){
        //      //     //       print(Get.find<ProductBrandController>().productList.length);
        //      //     // }, child: Text("press"));
        //      //     ListView.builder(
        //      //       itemCount: Get.find<ProductBrandController>().brandList.length,
        //      //         itemBuilder: (context,index){
        //      //         var item = Get.find<ProductBrandController>().brandList[index];
        //      //    //     Get.find<ProductBrandController>().brandList[index] =Get.find<ProductBrandController>().selectedName;
        //      //         return    Card(
        //      //          color: item != null ? Colors.white : Colors.white54,
        //      //           shape: RoundedRectangleBorder(
        //      //             borderRadius: BorderRadius.circular(12.0),
        //      //           ),
        //      //           //   shape: BeveledRectangleBorder(
        //      //           //   borderRadius: BorderRadius.circular(5.0),
        //      //           // ),
        //      //           // shape: StadiumBorder(
        //      //           //     side: BorderSide(
        //      //           //       color: Colors.black,
        //      //           //       width: 1.5,
        //      //           //       borderRadius: BorderRadius.circular(10.0),
        //      //           //     ),),
        //      //           // outlet[index].selected ? Colors.grey
        //      //           elevation: 7.0,
        //      //           child: ListTile(
        //      //             selected: isSelected,
        //      //             onLongPress: selection,
        //      //             title: InkWell(
        //      //               onTap: (){
        //      //
        //      //                 // OutletInfoPages(
        //      //                 //   outlet : Get
        //      //                 //         .find<OutletsController>()
        //      //                 //         .outletList[index],
        //      //                 // ));
        //      //              //  Get.to(SellProductPage(outlet:outlet  ));
        //      //                 Get.to(DetailsProduct(
        //      //                   outlet: outlet,product: Get.find<ProductBrandController>().getNameList(item)
        //      //                ));
        //      //                // print(outlet.name);
        //      //               },
        //      //               child: Padding(
        //      //                 padding: const EdgeInsets.all(10.0),
        //      //                 child: Column(
        //      //                   crossAxisAlignment: CrossAxisAlignment.start,
        //      //                   mainAxisSize: MainAxisSize.min,
        //      //                   children: [
        //      //                     Row(
        //      //                       mainAxisAlignment:  MainAxisAlignment.end,
        //      //                       children: [
        //      //                         // SizedBox(
        //      //                         //   width: Get.size.width * 0.3,
        //      //                         // ),
        //      //                         // CircleAvatar(
        //      //                         //     radius: (20),
        //      //                         //     backgroundColor:  outlet[index].synced
        //      //                         //         ? Colors.blueGrey
        //      //                         //         : Colors.grey,
        //      //                         //     child:  IconButton(onPressed:(){
        //      //                         //      // showQuantityBottomSheet(outlet[index].id.toString());
        //      //                         //        Get.bottomSheet(
        //      //                         //         Container(
        //      //                         //             child: Padding(
        //      //                         //               padding: const EdgeInsets.all(10.0),
        //      //                         //               child: Column(
        //      //                         //                 mainAxisSize: MainAxisSize.min,
        //      //                         //                 children: [
        //      //                         //
        //      //                         //                   Padding(
        //      //                         //                     padding: const EdgeInsets.all(10.0),
        //      //                         //                     child: GetBuilder<OutletsController>(
        //      //                         //                       builder: (builder) {
        //      //                         //                         return Get.find<OutletsController>().item.length == null
        //      //                         //                             ? SizedBox()
        //      //                         //                             : InputDecorator(
        //      //                         //                           decoration: decoration("Select Remark"),
        //      //                         //                           child: ButtonTheme(
        //      //                         //                             alignedDropdown: true,
        //      //                         //                             child: DropdownButton<String>(
        //      //                         //                               // iconEnabledCo
        //      //                         //                               // iconDisabledColor: Colors.red,
        //      //                         //                               isDense: true,
        //      //                         //                               isExpanded: true,
        //      //                         //                               hint: Text(
        //      //                         //                                   Get.find<OutletsController>().selectedDrowpdown),
        //      //                         //                               items:
        //      //                         //                               Get.find<OutletsController>().item.map((e) {
        //      //                         //                                 return DropdownMenuItem<String>(
        //      //                         //                                     value: e, child: Text(e));
        //      //                         //                               }).toList(),
        //      //                         //                               onChanged: (String district) {
        //      //                         //                                 // setState(() {
        //      //                         //                                 Get.find<OutletsController>().selectedDrowpdown = district;
        //      //                         //                                 //  Get.find<OutletsController>().setitem(district );
        //      //                         //                                 // });
        //      //                         //
        //      //                         //                                 // district = selectedDrowpdown;
        //      //                         //                                 print(Get.find<OutletsController>().selectedDrowpdown);
        //      //                         //                                 print(district);
        //      //                         //                                 //   print(Get.find<OutletsController>().setitem(district ));
        //      //                         //                                 //   district = Constants.item;
        //      //                         //                                 //      print(selectedDrowpdown);
        //      //                         //                                 //   district = Constants.selectedzone.zone;
        //      //                         //                                 // Get.find<AddressController>().getAreaList(district);
        //      //                         //                               },
        //      //                         //                             ),
        //      //                         //                           ),
        //      //                         //                         );
        //      //                         //                       },
        //      //                         //                     ),
        //      //                         //                   ),
        //      //                         //                   // ElevatedButton(
        //      //                         //                   //   onPressed: () async {
        //      //                         //                   //     if ( Get.find<OutletsController>().selectedDrowpdown != null  ) {
        //      //                         //                   //       // selectedProductList.add({
        //      //                         //                   //       //
        //      //                         //                   //       //   "remarks":  Get.find<OutletsController>().selectedDrowpdown,
        //      //                         //                   //       //
        //      //                         //                   //       // });
        //      //                         //                   //       //
        //      //                         //                   //       // if (selectedProductList.isEmpty) {
        //      //                         //                   //       //   Utilities.showInToast("Please add a product",
        //      //                         //                   //       //       toastType: ToastType.ERROR);
        //      //                         //                   //       //   return;
        //      //                         //                   //       // }
        //      //                         //                   //
        //      //                         //                   //       var sales = Sales(
        //      //                         //                   //         orders: '[{ "product_id" :"2", "batch_id": "3", "quantity" : "30", "discount": "10"}]',
        //      //                         //                   //         remark: jsonEncode(selectedProductList),
        //      //                         //                   //         soldAt:  DateTime.now().toString(),
        //      //                         //                   //         outletId: "12",
        //      //                         //                   //            outletLatitude : "444444",
        //      //                         //                   //        outletLongitude : "4343243423"
        //      //                         //                   //       );
        //      //                         //                   //       // sales.orders = "dd";
        //      //                         //                   //       // // sales.distributorId = "12";
        //      //                         //                   //       // sales.remark =jsonEncode(selectedProductList);
        //      //                         //                   //       // sales.soldAt = DateTime.now().toString();
        //      //                         //                   //       // sales.outletId = Get
        //      //                         //                   //       //     .find<OutletsController>()
        //      //                         //                   //       //     .outletList[index].id.toString();
        //      //                         //                   //       // sales.outletLatitude = "444444";
        //      //                         //                   //       // sales.outletLongitude = "4343243423";
        //      //                         //                   //
        //      //                         //                   //       //  var conn = await Utilities.isInternetWorking();
        //      //                         //                   //
        //      //                         //                   //
        //      //                         //                   //
        //      //                         //                   //       Get.find<OutletsController>().addoutletInList(outlet[index].id.toString()) ;
        //      //                         //                   //       //else {
        //      //                         //                   //       //   Get.find<ProductsController>().storeSalesOffline(sales);
        //      //                         //                   //       // }
        //      //                         //                   //       //
        //      //                         //                   //       // Get.find<ProductsController>().removeAllProductFromList();
        //      //                         //                   //   //    Get.find<ProductsController>().sellProducts(sales);
        //      //                         //                   //           var conn = await Utilities.isInternetWorking();
        //      //                         //                   //       if (conn) {
        //      //                         //                   //         var response = await sellProductApi(sales);
        //      //                         //                   //         print(sales);
        //      //                         //                   //         // Get.back();
        //      //                         //                   //         Utilities.showInToast(response.message,
        //      //                         //                   //             toastType: response.success
        //      //                         //                   //                 ? ToastType.SUCCESS
        //      //                         //                   //                 : ToastType.ERROR);
        //      //                         //                   //
        //      //                         //                   //         //   if (response.success) {
        //      //                         //                   //         //     outlet.synced = true;
        //      //                         //                   //         //     Get.back();
        //      //                         //                   //         //   }
        //      //                         //                   //         // } else {
        //      //                         //                   //         //   Get.back();
        //      //                         //                   //         //   outlet.synced = false;
        //      //                         //                   //         //
        //      //                         //                   //         //   Utilities.showInToast('Storing Offline',
        //      //                         //                   //         //       toastType: ToastType.INFO);
        //      //                         //                   //         // }
        //      //                         //                   //         // await DatabaseHelper.instance
        //      //                         //                   //         //     .insertOutlet(outlet);
        //      //                         //                   //         // Get.find<ProductsController>().addremark(sales);
        //      //                         //                   //         Get.back();
        //      //                         //                   //       } else {
        //      //                         //                   //         Utilities.showInToast('Please complete the form',
        //      //                         //                   //             toastType: ToastType.ERROR);
        //      //                         //                   //       }
        //      //                         //                   //     } else {
        //      //                         //                   //       Utilities.showInToast("Please add quantity");
        //      //                         //                   //     }
        //      //                         //                   //     Get.back(
        //      //                         //                   //
        //      //                         //                   //     );
        //      //                         //                   //   },
        //      //                         //                   //   child: Text("Add"),
        //      //                         //                   // )
        //      //                         //                 ],
        //      //                         //               ),
        //      //                         //             )),
        //      //                         //         shape: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        //      //                         //         backgroundColor: Colors.white,
        //      //                         //         enableDrag: true,
        //      //                         //       );
        //      //                         //       // Get.bottomSheet(
        //      //                         //       //   // ListView.builder(itemCount: Get.find<OutletsController>().item?.length != null ? Get.find<OutletsController>().item?.length  : "",
        //      //                         //       //   //   itemBuilder: (context, index){
        //      //                         //       //   //     return
        //      //                         //       //   Container(
        //      //                         //       //       child: Padding(
        //      //                         //       //         padding: const EdgeInsets.all(10.0),
        //      //                         //       //         child: Column(
        //      //                         //       //           mainAxisSize: MainAxisSize.min,
        //      //                         //       //           children: [
        //      //                         //       //             Padding(
        //      //                         //       //                 padding: const EdgeInsets.all(12.0),
        //      //                         //       //                 child:
        //      //                         //       //                 // DropdownButton(
        //      //                         //       //                 //
        //      //                         //       //                 //   // Initial Value
        //      //                         //       //                 //     value: selectedDrowpdown,
        //      //                         //       //                 //
        //      //                         //       //                 //     // Down Arrow Icon
        //      //                         //       //                 //     icon: const Icon(Icons.keyboard_arrow_down),
        //      //                         //       //                 //
        //      //                         //       //                 //     // Array list of items
        //      //                         //       //                 //     items: item.map((String items) {
        //      //                         //       //                 //       return DropdownMenuItem(
        //      //                         //       //                 //         value: items,
        //      //                         //       //                 //         child: Text(items),
        //      //                         //       //                 //       );
        //      //                         //       //                 //     }).toList(),
        //      //                         //       //                 // After selecting the desired option,it will
        //      //                         //       //                 // change button value to selected value
        //      //                         //       //                 // onChanged: (String newValue) {
        //      //                         //       //                 //   setState(() {
        //      //                         //       //                 //     selectedDrowpdown = newValue;
        //      //                         //       //                 //   });
        //      //                         //       //                 //                 DropdownButton(
        //      //                         //       //                 //                 hint: Text("Outlet Closed Image"), // Not necessary for Option 1
        //      //                         //       //                 //   value:selectedDrowpdown,
        //      //                         //       //                 //   onChanged: (newValue) {
        //      //                         //       //                 //     selectedDrowpdown = newValue;
        //      //                         //       //                 //   setState(() {
        //      //                         //       //                 //   selectedDrowpdown = newValue;
        //      //                         //       //                 // //  print(newValue);
        //      //                         //       //                 //   //print(selectedDrowpdown);
        //      //                         //       //                 //   });
        //      //                         //       //                 //   },
        //      //                         //       //                 //   items: item.map((location) {
        //      //                         //       //                 //   return DropdownMenuItem(
        //      //                         //       //                 //   child: new Text(location),
        //      //                         //       //                 //   value: location,
        //      //                         //       //                 //   );
        //      //                         //       //                 //   }).toList(),
        //      //                         //       //                 //   ),
        //      //                         //       //                 Padding(
        //      //                         //       //                   padding: const EdgeInsets.all(10.0),
        //      //                         //       //                   child: GetBuilder<OutletsController>(
        //      //                         //       //                     builder: (builder) {
        //      //                         //       //                       return Get.find<OutletsController>().item.length == null
        //      //                         //       //                           ? SizedBox()
        //      //                         //       //                           : InputDecorator(
        //      //                         //       //                         decoration: decoration("Select Remark"),
        //      //                         //       //                         child: ButtonTheme(
        //      //                         //       //                           alignedDropdown: true,
        //      //                         //       //                           child: DropdownButton<String>(
        //      //                         //       //                             // iconEnabledCo
        //      //                         //       //                             // iconDisabledColor: Colors.red,
        //      //                         //       //                             isDense: true,
        //      //                         //       //                             isExpanded: true,
        //      //                         //       //                             hint: Text(
        //      //                         //       //                                 Get.find<OutletsController>().selectedDrowpdown),
        //      //                         //       //                             items:
        //      //                         //       //                             Get.find<OutletsController>().item.map((e) {
        //      //                         //       //                               return DropdownMenuItem<String>(
        //      //                         //       //                                   value: e, child: Text(e));
        //      //                         //       //                             }).toList(),
        //      //                         //       //                             onChanged: (String district) {
        //      //                         //       //                               // setState(() {
        //      //                         //       //                                 Get.find<OutletsController>().selectedDrowpdown = district;
        //      //                         //       //                                 //  Get.find<OutletsController>().setitem(district );
        //      //                         //       //                              // });
        //      //                         //       //
        //      //                         //       //                               // district = selectedDrowpdown;
        //      //                         //       //                               print(Get.find<OutletsController>().selectedDrowpdown);
        //      //                         //       //                               print(district);
        //      //                         //       //                               //   print(Get.find<OutletsController>().setitem(district ));
        //      //                         //       //                               //   district = Constants.item;
        //      //                         //       //                               //      print(selectedDrowpdown);
        //      //                         //       //                               //   district = Constants.selectedzone.zone;
        //      //                         //       //                               // Get.find<AddressController>().getAreaList(district);
        //      //                         //       //                             },
        //      //                         //       //                           ),
        //      //                         //       //                         ),
        //      //                         //       //                       );
        //      //                         //       //                     },
        //      //                         //       //                   ),
        //      //                         //       //                 )
        //      //                         //       //               // DropdownButton<String>(
        //      //                         //       //               //   hint: Text("Remark"),
        //      //                         //       //               //   value:  selectedDrowpdown,
        //      //                         //       //               //   items:
        //      //                         //       //               //   //[for(var data in  Get.find<OutletsController>().item)])
        //      //                         //       //               //   // [
        //      //                         //       //               //   //   for (var data in Get.find<OutletsController>().item)
        //      //                         //       //               //   //     DropdownMenuItem(
        //      //                         //       //               //   //       child: new Text(
        //      //                         //       //               //   //         data,
        //      //                         //       //               //   //       ),
        //      //                         //       //               //   //       value: data,
        //      //                         //       //               //   //     )
        //      //                         //       //               //   // ],
        //      //                         //       //               //
        //      //                         //       //               //   // Get.find<OutletsController>().item.map((e) {
        //      //                         //       //               //   //   return DropdownMenuItem<String>(
        //      //                         //       //               //   //           value: e,
        //      //                         //       //               //   //           child: Text(e),
        //      //                         //       //               //   //         );
        //      //                         //       //               //   // }),
        //      //                         //       //               //     item.map((  value) {
        //      //                         //       //               //     return DropdownMenuItem<String>(
        //      //                         //       //               //       value: value,
        //      //                         //       //               //       child: Text(value),
        //      //                         //       //               //     );
        //      //                         //       //               //   }).toList(),
        //      //                         //       //               //   onChanged: (newvalue) {
        //      //                         //       //               //     setState(() {
        //      //                         //       //               //      selectedDrowpdown = newvalue ;
        //      //                         //       //               //     });
        //      //                         //       //               //
        //      //                         //       //               // //   Get.find<OutletsController>().setitem(newvalue);
        //      //                         //       //               //
        //      //                         //       //               //
        //      //                         //       //               //    //_selectedvalue = newvalue;
        //      //                         //       //               //   })
        //      //                         //       //             ),
        //      //                         //       //
        //      //                         //       //             SizedBox(height: Get.size.height * 0.01),
        //      //                         //       //             // Container(
        //      //                         //       //             //   child: _imageFile == null
        //      //                         //       //             //       ? Center(
        //      //                         //       //             //     child: Text("No Image Selected"),
        //      //                         //       //             //   )
        //      //                         //       //             //       : Image.file(File(_imageFile.path)),
        //      //                         //       //             // ),
        //      //                         //       //             ElevatedButton(
        //      //                         //       //               onPressed: () async {
        //      //                         //       //                 // pickImage();
        //      //                         //       //                 if (Get.find<OutletsController>().selectedDrowpdown.isNotEmpty) {
        //      //                         //       //                   var conn = await Utilities.isInternetWorking();
        //      //                         //       //                   showDialog(
        //      //                         //       //                       barrierDismissible: false,
        //      //                         //       //                       context: context,
        //      //                         //       //                       builder: (context) {
        //      //                         //       //                         return CupertinoAlertDialog(
        //      //                         //       //                           title: Text('Please Wait'),
        //      //                         //       //                           content: Column(
        //      //                         //       //                             children: [
        //      //                         //       //                               Divider(),
        //      //                         //       //                               Padding(
        //      //                         //       //                                 padding: const EdgeInsets.all(8.0),
        //      //                         //       //                                 child: Text(conn
        //      //                         //       //                                     ? 'Registering new Sales Outlet'
        //      //                         //       //                                     : 'Saving offline'),
        //      //                         //       //                               ),
        //      //                         //       //                               CupertinoActivityIndicator(
        //      //                         //       //                                 radius: 17,
        //      //                         //       //                               )
        //      //                         //       //                             ],
        //      //                         //       //                           ),
        //      //                         //       //                         );
        //      //                         //       //                       });
        //      //                         //       //                   // var sales = Sales(
        //      //                         //       //                   //     outletId:  outlet[index].id.toString(),
        //      //                         //       //                   //     remark:  Get.find<OutletsController>().selectedDrowpdown
        //      //                         //       //                   // );
        //      //                         //       //                   // selectedoutlet.add({
        //      //                         //       //                   //   //"outlet_id": outletId,
        //      //                         //       //                   //
        //      //                         //       //                   //   "remark": selectedDrowpdown,
        //      //                         //       //                   //
        //      //                         //       //                   // });
        //      //                         //       //                   if (conn) {
        //      //                         //       //                     var response = await sellProductApi(sales);
        //      //                         //       //                     print(sales);
        //      //                         //       //                     // Get.back();
        //      //                         //       //                     Utilities.showInToast(response.message,
        //      //                         //       //                         toastType: response.success
        //      //                         //       //                             ? ToastType.SUCCESS
        //      //                         //       //                             : ToastType.ERROR);
        //      //                         //       //
        //      //                         //       //                     //   if (response.success) {
        //      //                         //       //                     //     outlet.synced = true;
        //      //                         //       //                     //     Get.back();
        //      //                         //       //                     //   }
        //      //                         //       //                     // } else {
        //      //                         //       //                     //   Get.back();
        //      //                         //       //                     //   outlet.synced = false;
        //      //                         //       //                     //
        //      //                         //       //                     //   Utilities.showInToast('Storing Offline',
        //      //                         //       //                     //       toastType: ToastType.INFO);
        //      //                         //       //                     // }
        //      //                         //       //                     // await DatabaseHelper.instance
        //      //                         //       //                     //     .insertOutlet(outlet);
        //      //                         //       //                     // Get.find<ProductsController>().addremark(sales);
        //      //                         //       //                     Get.back();
        //      //                         //       //                   } else {
        //      //                         //       //                     Utilities.showInToast('Please complete the form',
        //      //                         //       //                         toastType: ToastType.ERROR);
        //      //                         //       //                   }
        //      //                         //       //                   // if (selectedDrowpdown != null) {
        //      //                         //       //                   //   // selectedoutlet.add({
        //      //                         //       //                   //   //   //"outlet_id": outletId,
        //      //                         //       //                   //   //
        //      //                         //       //                   //   //   "remark": selectedDrowpdown,
        //      //                         //       //                   //   //
        //      //                         //       //                   //   // });
        //      //                         //       //                   //   sales.remark = jsonEncode(selectedoutlet);
        //      //                         //       //                   //   Get.find<OutletsController>().addoutletInList(outletId);
        //      //                         //       //                   //   //Get.find<ProductsController>().addremark(selectedoutlet);
        //      //                         //       //                   //   Utilities.showInToast("Remark Noted");
        //      //                         //       //                   //   print(selectedDrowpdown);
        //      //                         //       //                   // } else {
        //      //                         //       //                   //   Utilities.showInToast("Please add Remark");
        //      //                         //       //                   // }
        //      //                         //       //                   Get.back();}
        //      //                         //       //               },
        //      //                         //       //               child: Text("Add"),
        //      //                         //       //             ),
        //      //                         //       //           //  outlet.id..toString().isEmpty
        //      //                         //       //           //       ? ElevatedButton(
        //      //                         //       //           //     onPressed: () {
        //      //                         //       //           //       showQuantityBottomSheet(null, products.id.toString());
        //      //                         //       //           //     },
        //      //                         //       //           //     child: Text("Sell"),
        //      //                         //       //           //   )
        //      //                         //       //           //       : ExpansionTile(
        //      //                         //       //           //     title: Text("Batches"),
        //      //                         //       //           //     children: products.batches.map((batch) {
        //      //                         //       //           //       return buildBatchTile(batch, products);
        //      //                         //       //           //     }).toList(),
        //      //                         //       //           //   ),
        //      //                         //       //           ],
        //      //                         //       //         ),)),
        //      //                         //       //
        //      //                         //       //
        //      //                         //       //
        //      //                         //       //
        //      //                         //       //   shape: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        //      //                         //       //   backgroundColor: Colors.white,
        //      //                         //       //   enableDrag: true,
        //      //                         //       // );
        //      //                         //     } , icon: Icon(Icons.add))
        //      //                         // )
        //      //                       ],
        //      //                     ),
        //      //                     Container(
        //      //                         child: Column(
        //      //                           mainAxisAlignment: MainAxisAlignment.start,
        //      //                           children: [
        //      //                             Padding(  padding: const EdgeInsets.all(10.0),
        //      //                                 child:   Row(
        //      //                                   children: [
        //      //                                     Text(
        //      //                                       item,
        //      //                                       style: TextStyle(
        //      //                                           fontSize: 15,
        //      //                                           fontWeight: FontWeight.bold),
        //      //                                     ),
        //      //
        //      //                                   ],
        //      //                                 )
        //      //
        //      //                             ),
        //      //
        //      //                             // Padding(
        //      //                             //   padding: const EdgeInsets.only(top: 1),
        //      //                             //   child:
        //      //                             // Text(
        //      //                             //   outlet[index].name,
        //      //                             //   style: TextStyle(
        //      //                             //       fontSize: 18,
        //      //                             //       fontWeight: FontWeight.bold),
        //      //                             // ),
        //      //                             // //    ),
        //      //                             // Container(
        //      //                             //   child:   Text(
        //      //                             //     "Number of Outlet: ${outlet.length.toString()}",
        //      //                             //     style: TextStyle(
        //      //                             //         fontSize: 10,
        //      //                             //         fontWeight: FontWeight.bold),
        //      //                             //   ),
        //      //                             // ),
        //      //                             // Text(
        //      //                             //   outlet[index].name,
        //      //                             //   style: TextStyle(
        //      //                             //       fontSize: 10,
        //      //                             //       fontWeight: FontWeight.bold),
        //      //                             // ),
        //      //
        //      //                           ],
        //      //                         )
        //      //                     ),
        //      //
        //      //                     // MaterialButton(
        //      //                     //   onPressed: () {
        //      //                     //     Get.to(() =>
        //      //                     //         SellProductPage(
        //      //                     //           outlet: Get
        //      //                     //               .find<OutletsController>()
        //      //                     //               .outletList[index],
        //      //                     //         ));
        //      //                     //
        //      //                     //   },
        //      //                     //   color: Colors.green[900],
        //      //                     //   minWidth: Get.size.width,
        //      //                     //   textColor: Colors.white,
        //      //                     //   padding: EdgeInsets.all(10.0),
        //      //                     //   child: Text("Sell Product"),
        //      //                     // ),
        //      //
        //      //                   ],
        //      //                 ),
        //      //               ),
        //      //             ),
        //      //           ),
        //      //         );
        //      //         //   ListTile(
        //      //         //   onTap: (){
        //      //         //     Get.find<ProductBrandController>().setSelectedBrand(item);
        //      //         //
        //      //         //     Get.to(DetailsProduct(
        //      //         //       product: Get.find<ProductBrandController>().getNameList(item)),
        //      //         //
        //      //         //     );
        //      //         //   },
        //      //         //   title: Text(item),
        //      //         // );
        //      //         });
        //      //   },
        //      // ),
        //      //     );
        //      //   },
        //      //   title: Text(item),
        //      // );
        //      });


     // Column(
     //   children: [
     //     Text(title, textAlign: TextAlign.center,style: TextStyle(
     //         fontWeight: FontWeight.w500,
     //         fontSize: 20
     //     ),),
     //     SizedBox(
     //       height: 20,
     //     ),
     //     Text(names, textAlign: TextAlign.center,style: TextStyle(
     //         fontWeight: FontWeight.w500,
     //         fontSize: 14))
     //   ],
     // ),

  }

}