// import 'dart:convert';
// import 'dart:io';
//
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:mobitrack_dv_flutter/controller/address_controller.dart';
// import 'package:mobitrack_dv_flutter/controller/outlets_controller.dart';
// import 'package:mobitrack_dv_flutter/controller/products_controller.dart';
// import 'package:mobitrack_dv_flutter/model/outlet.dart';
// import 'package:mobitrack_dv_flutter/model/products.dart';
// import 'package:mobitrack_dv_flutter/utils/constants.dart';
// import 'package:mobitrack_dv_flutter/utils/utilities.dart';
// import 'package:mobitrack_dv_flutter/view/products/sell_products.dart';
//
// import '../../controller/database_controller.dart';
// import 'package:equatable/equatable.dart';
//
//
// class ViewOutletPage extends StatefulWidget{
//   @override
//   State<StatefulWidget> createState() {
//     // TODO: implement createState
//     return ViewOutletsPages();
//   }
//
// }
// class ViewOutletsPages extends State<ViewOutletPage> {
//   var outlet = Get.lazyPut(() => OutletsController());
//
//   bool _lock = false;
//   List<Outlet> outlets = Get.find<OutletsController>().outletList;
//   DatabaseHelper databaseHelper;
//   TextEditingController textEditingController ;
//   TextEditingController remarkEditingController = new TextEditingController();
//   var selectedOutlet = Outlet();
//   var selectedoutlet = []
//       .obs;
//   var _selectedIndex = 0 .obs;
//   String selectedDrowpdown = 'Outlet Closed Image';
//   var item = ["Outlet Closed Image","Stock Availabe Image","margin Issue","Owner not in shop","Credit limit Issue"];
//
//   String base64Image;
//   XFile _imageFile;
//   final ImagePicker _picker = ImagePicker();
//
//   // final outlet = createoutlet();
//
//   @override
//   Widget build(BuildContext context) {
//
//     bool validateInputremark(){
//       return remarkEditingController.text.isNotEmpty;
//     }
//
//     // Widget listoutlet(List<Outlet> outletlist){
//     //   return ListView.builder(
//     //       itemCount:
//     //       //Constants.outletLlist.length,
//     //       Get.find<OutletsController>().outletList.length,
//     //       itemBuilder: (context, index) {
//     //         var list = Get
//     //             .find<OutletsController>()
//     //             .outletList;
//     //         print(list);
//     //         var item =
//     //         //Constants.outletLlist[index];
//     //         Get
//     //             .find<OutletsController>()
//     //             .outletList[index];
//     //         // print(Get
//     //         //     .find<AddressController>()
//     //         //     .addressList);
//     //         // if (item.route == Constants.outletLlist) {
//     //         // String province = Get.find<AddressController>()
//     //         //     .addressList
//     //         //     .where((element) =>
//     //         // element.id ==
//     //         //     int.parse(item.addressId.toString()))
//     //         //     .toList()
//     //         //     .first
//     //         //     .province;
//     //         // String district = Get.find<AddressController>()
//     //         //     .addressList
//     //         //     .where((element) =>
//     //         // element.id ==
//     //         //     int.parse(item.addressId.toString()))
//     //         //     .toList()
//     //         //     .first
//     //         //     .district;
//     //         // String area = Get.find<AddressController>()
//     //         //     .addressList
//     //         //     .where((element) =>
//     //         // element.id ==
//     //         //     int.parse(item.addressId.toString()))
//     //         //     .toList()
//     //         //     .first
//     //         //     .localLevelEn;
//     //
//     //         return
//     //           // item.longitude != null ?
//     //
//     //           Container(
//     //             child: Card(
//     //               elevation: 7,
//     //               child: Column(
//     //                 crossAxisAlignment: CrossAxisAlignment.start,
//     //                 mainAxisSize: MainAxisSize.min,
//     //                 children: [
//     //                   Padding(
//     //                     padding: const EdgeInsets.all(8.0),
//     //                     child: Center(
//     //                         child: CircleAvatar(
//     //                           backgroundColor: item.synced
//     //                               ? Colors.green
//     //                               : Colors.grey,
//     //                           child: Icon(
//     //                             !item.synced
//     //                                 ? Icons.cloud_off_outlined
//     //                                 : Icons.shopping_bag_outlined,
//     //                             color: Colors.white,
//     //                           ),
//     //                         )),
//     //                   ),
//     //                   Center(
//     //                     child: Text(
//     //
//     //                       item.name,
//     //                       style: TextStyle(
//     //                           fontSize: 18,
//     //                           fontWeight: FontWeight.bold),
//     //                     ),
//     //                   ),
//     //                   Padding(
//     //                     padding: const EdgeInsets.all(4.0),
//     //                     child: Row(
//     //                       mainAxisAlignment: MainAxisAlignment
//     //                           .start,
//     //                       children: [
//     //                         // Icon(
//     //                         //   Icons.person,
//     //                         //   size: 16,
//     //                         // ),
//     //                         SizedBox(
//     //                           width: 5,
//     //                         ),
//     //                         //   Image(image: item.image)
//     //
//     //                       ],
//     //                     ),
//     //                   ),
//     //                   Divider(),
//     //                   Padding(
//     //                     padding: const EdgeInsets.all(4.0),
//     //                     child: Row(
//     //                       mainAxisAlignment: MainAxisAlignment
//     //                           .start,
//     //                       children: [
//     //                         // Icon(
//     //                         //   Icons.person,
//     //                         //   size: 16,
//     //                         // ),
//     //                         SizedBox(
//     //                           width: 5,
//     //                         ),
//     //                         //Text(item.ownerName),
//     //                       ],
//     //                     ),
//     //                   ),
//     //                   Padding(
//     //                     padding: const EdgeInsets.all(4.0),
//     //                     child: Row(
//     //                       mainAxisAlignment: MainAxisAlignment
//     //                           .start,
//     //                       children: [
//     //                         Icon(
//     //                           Icons.phone,
//     //                           size: 16,
//     //                         ),
//     //                         SizedBox(
//     //                           width: 5,
//     //                         ),
//     //                         //Text(item.contact),
//     //                       ],
//     //                     ),
//     //                   ),
//     //                   Padding(
//     //                     padding: const EdgeInsets.all(4.0),
//     //                     child: Row(
//     //                       mainAxisAlignment: MainAxisAlignment
//     //                           .start,
//     //                       children: [
//     //                         Icon(
//     //                           Icons.location_on,
//     //                           size: 16,
//     //                         ),
//     //                         SizedBox(
//     //                           width: 5,
//     //                         ),
//     //                         // Expanded(
//     //                         //   child: Text(
//     //                         //     province +
//     //                         //         ", " +
//     //                         //         district +
//     //                         //         ", " +
//     //                         //         area +
//     //                         //         ", " +
//     //                         //         (item.street ?? ""),
//     //                         //     overflow: TextOverflow.visible,
//     //                         //     style: TextStyle(fontSize: 12),
//     //                         //   ),
//     //                         // ),
//     //                       ],
//     //                     ),
//     //                   ),
//     //
//     //                   Padding(
//     //                     padding: const EdgeInsets.all(4.0),
//     //                     child: Row(
//     //                       mainAxisAlignment: MainAxisAlignment
//     //                           .start,
//     //                       children: [
//     //                         Icon(
//     //                           Icons.category,
//     //                           size: 16,
//     //                         ),
//     //                         SizedBox(
//     //                           width: 5,
//     //                         ),
//     //                         //Text(item.type),
//     //                       ],
//     //                     ),
//     //                   ),
//     //                   MaterialButton(
//     //                     onPressed: () {
//     //                       Get.to(() =>
//     //                           SellProductPage(
//     //                               outlet: Get
//     //                                   .find<OutletsController>()
//     //                                   .outletList[index]));
//     //                     },
//     //                     color: Colors.green[900],
//     //                     minWidth: Get.size.width,
//     //                     textColor: Colors.white,
//     //                     padding: EdgeInsets.all(10.0),
//     //                     child: Text("Sell Product"),
//     //                   ),
//     //                 ],
//     //               ),
//     //             ),
//     //           );
//     //       }
//     //
//     //   );
//     // }
//
//     // List item = ["Outlet Closed Image","Stock Availabe Image","margin Issue","Owner not in shop","Credit limit Issue"];
//     // String _selectedvalue= "Outlet Closed Image".obs;
//
//     void pickImage() async {
//       try {
//         final pickedFile = await _picker.pickImage(
//           source: ImageSource.camera,
//           imageQuality: 25,
//         );
//         if (pickedFile != null) {
//           setState(() {
//             _imageFile = pickedFile;
//
//           });
//           List<int> imageBytes = await pickedFile.readAsBytes();
//           base64Image = base64Encode(imageBytes);
//
//           print(base64Image);
//         }
//       } catch (e) {
//         Utilities.showInToast(e.message);
//       }
//     }
//     void showQuantityBottomSheet( String outletId) {
//       String addedQuantity;
//       String discountPercent = "0";
//       Get.bottomSheet(
//         Container(
//             child: Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(12.0),
//                     child:
//                     DropdownButton(
//
//                       // Initial Value
//                         value: selectedDrowpdown,
//
//                         // Down Arrow Icon
//                         icon: const Icon(Icons.keyboard_arrow_down),
//
//                         // Array list of items
//                         items: item.map((String items) {
//                           return DropdownMenuItem(
//                             value: items,
//                             child: Text(items),
//                           );
//                         }).toList(),
//                         // After selecting the desired option,it will
//                         // change button value to selected value
//                         onChanged: (String newValue) {
//                           setState(() {
//                             selectedDrowpdown = newValue;
//                           });
//
//                           // DropdownButton<String>(
//                           //   hint: Text("Remark"),
//                           //   value:  selectedDrowpdown,
//                           //   items:
//                           //   //[for(var data in  Get.find<OutletsController>().item)])
//                           //   // [
//                           //   //   for (var data in Get.find<OutletsController>().item)
//                           //   //     DropdownMenuItem(
//                           //   //       child: new Text(
//                           //   //         data,
//                           //   //       ),
//                           //   //       value: data,
//                           //   //     )
//                           //   // ],
//                           //
//                           //   // Get.find<OutletsController>().item.map((e) {
//                           //   //   return DropdownMenuItem<String>(
//                           //   //           value: e,
//                           //   //           child: Text(e),
//                           //   //         );
//                           //   // }),
//                           //     item.map((  value) {
//                           //     return DropdownMenuItem<String>(
//                           //       value: value,
//                           //       child: Text(value),
//                           //     );
//                           //   }).toList(),
//                           //   onChanged: (newvalue) {
//                           //     setState(() {
//                           //      selectedDrowpdown = newvalue ;
//                           //     });
//                           //
//                           // //   Get.find<OutletsController>().setitem(newvalue);
//                           //
//                           //
//                           //    //_selectedvalue = newvalue;
//                           //   })
//                         })),
//
//                   SizedBox(height: Get.size.height * 0.01),
//                   Container(
//                     child: _imageFile == null
//                         ? Center(
//                       child: Text("No Image Selected"),
//                     )
//                         : Image.file(File(_imageFile.path)),
//                   ),
//                   ElevatedButton(
//                     onPressed: () async {
//                       if (Get.find<OutletsController>().selectedDrowpdown.isNotEmpty) {
//                                                             var conn = await Utilities.isInternetWorking();
//                                                             showDialog(
//                                                                 barrierDismissible: false,
//                                                                 context: context,
//                                                                 builder: (context) {
//                                                                   return CupertinoAlertDialog(
//                                                                     title: Text('Please Wait'),
//                                                                     content: Column(
//                                                                       children: [
//                                                                         Divider(),
//                                                                         Padding(
//                                                                           padding: const EdgeInsets.all(8.0),
//                                                                           child: Text(conn
//                                                                               ? 'Registering new Sales Outlet'
//                                                                               : 'Saving offline'),
//                                                                         ),
//                                                                         CupertinoActivityIndicator(
//                                                                           radius: 17,
//                                                                         )
//                                                                       ],
//                                                                     ),
//                                                                   );
//                                                                 });
//                                                             var sales = Sales(
//                                                                 outletId:  "12",
//                                                                 orders: "d",
//                                                                 soldAt:  DateTime.now().toString(),
//                                                                 outletLatitude: "23",
//                                                                 outletLongitude: "32",
//                                                                 remark:  Get.find<OutletsController>().selectedDrowpdown,
//
//
//                                                             );
//                                   //                           // selectedoutlet.add({
//                                   //                           //   //"outlet_id": outletId,
//                                   //                           //
//                                   //                           //   "remark": selectedDrowpdown,
//                                   //                           //
//                                   //                           // });
//                                                             if (conn) {
//                                                               var response = await sellProductApi(sales);
//                                                               print(sales);
//                                                               // Get.back();
//                                                               Utilities.showInToast(response.message,
//                                                                   toastType: response.success
//                                                                       ? ToastType.SUCCESS
//                                                                       : ToastType.ERROR);
//
//                                   //                             //   if (response.success) {
//                                   //                             //     outlet.synced = true;
//                                   //                             //     Get.back();
//                                   //                             //   }
//                                   //                             // } else {
//                                   //                             //   Get.back();
//                                   //                             //   outlet.synced = false;
//                                   //                             //
//                                   //                             //   Utilities.showInToast('Storing Offline',
//                                   //                             //       toastType: ToastType.INFO);
//                                   //                             // }
//                                   //                             // await DatabaseHelper.instance
//                                   //                             //     .insertOutlet(outlet);
//                                   //                             // Get.find<ProductsController>().addremark(sales);
//                                                               Get.back();
//                                                             } else {
//                                                               Utilities.showInToast('Please complete the form',
//                                                                   toastType: ToastType.ERROR);
//                                                             }
//                                   //                           // if (selectedDrowpdown != null) {
//                                   //                           //   // selectedoutlet.add({
//                                   //                           //   //   //"outlet_id": outletId,
//                                   //                           //   //
//                                   //                           //   //   "remark": selectedDrowpdown,
//                                   //                           //   //
//                                   //                           //   // });
//                                   //                           //   sales.remark = jsonEncode(selectedoutlet);
//                                   //                           //   Get.find<OutletsController>().addoutletInList(outletId);
//                                   //                           //   //Get.find<ProductsController>().addremark(selectedoutlet);
//                                   //                           //   Utilities.showInToast("Remark Noted");
//                                   //                           //   print(selectedDrowpdown);
//                                   //                           // } else {
//                                   //                           //   Utilities.showInToast("Please add Remark");
//                                   //                           // }
//                                                             Get.back();}
//                                                         },
//                     child: Text("Add"),
//                   )
//                 ],
//               ),
//             )),
//         shape: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
//         backgroundColor: Colors.white,
//         enableDrag: true,
//       );
//     }
//
//
//
//     void _showDialog(BuildContext context) {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: new Text("Remark"),
//             content:
//             Padding(
//               padding: const EdgeInsets.all(12.0),
//               child: TextField(
//                 autofocus: false,
//                 decoration: InputDecoration(
//                     labelText: 'Add Your Remark',
//                     prefixIcon: Icon(Icons.person)),
//                 controller: remarkEditingController,
//               ),
//             ),
//
//             actions: <Widget>[
//               new ElevatedButton(
//                 child: new Text("OK"),
//                 onPressed: () async{
//                   if(validateInputremark()){
//                   var conn = await Utilities.isInternetWorking();
//                   showDialog(
//                       barrierDismissible: false,
//                       context: context,
//                       builder: (context) {
//                         return CupertinoAlertDialog(
//                           title: Text('Please Wait'),
//                           content: Column(
//                             children: [
//                               Divider(),
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Text(conn
//                                     ? 'Registering your Remark'
//                                     : 'Saving offline'),
//                               ),
//                               CupertinoActivityIndicator(
//                                 radius: 17,
//                               )
//                             ],
//                           ),
//                         );
//                       });
//                   var sales = Sales(
//                     remark: remarkEditingController.text,
//
//                   );
//
//           if (conn) {
//           var response = await sellProductApi(sales);
//           Get.back();
//
//           Utilities.showInToast(response.message,
//           toastType: response.success
//           ? ToastType.SUCCESS
//               : ToastType.ERROR);
//
//           if (response.success) {
//
//           Get.back();
//           }
//           } else {
//           Get.back();
//
//
//
//           }
//
//           Get.find<ProductsController>().addremark(sales);
//           Get.back();
//           } else {
//           Utilities.showInToast('Please complete the form',
//           toastType: ToastType.ERROR);
//           }
//                 },
//               ),
//             ],
//           );
//         },
//       );
//     }
//     Widget buildMainTile(Outlet outlet) {
//       return  Card(
//         color: outlet.selected ? Colors.grey : Colors.white,
//         elevation: 7,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Row(
//               mainAxisAlignment:  MainAxisAlignment.end,
//               children: [
//
//                Padding(
//                 padding: const EdgeInsets.only(right: 1),
//                 child: Center(
//                     child: CircleAvatar(
//                       radius: (35),
//                       backgroundColor:  outlet .synced
//                           ? Colors.green
//                           : Colors.grey,
//                       child: Icon(
//                         !outlet .synced
//                             ? Icons.cloud_off_outlined
//                             : Icons.shopping_bag_outlined,
//                         color: Colors.white,
//                       ),
//                     )),
//               ),
//                 SizedBox(
//                   width: Get.size.width * 0.3,
//                 ),
//                 CircleAvatar(
//                     radius: (20),
//                   backgroundColor:  outlet .synced
//                       ? Colors.blueGrey
//                       : Colors.grey,
//                   child:  IconButton(onPressed:(){
//                     showQuantityBottomSheet(outlet.id.toString());
//                   } , icon: Icon(Icons.add))
//                 )
//               // ElevatedButton(onPressed: (){
//               //   // showDialog(
//               //   //   context: context,
//               //   //   builder: (BuildContext context) {
//               //   //     return AlertDialog(
//               //   //       title: new Text("Remark"),
//               //   //       content:
//               //   //       Padding(
//               //   //         padding: const EdgeInsets.all(12.0),
//               //   //         child: TextField(
//               //   //           autofocus: false,
//               //   //           decoration: InputDecoration(
//               //   //               labelText: 'Add Your Remark',
//               //   //               prefixIcon: Icon(Icons.person)),
//               //   //           controller: remarkEditingController,
//               //   //         ),
//               //   //       ),
//               //   //
//               //   //
//               //   //       actions: <Widget>[
//               //   //         new ElevatedButton(
//               //   //           child: new Text("OK"),
//               //   //           onPressed: () async{
//               //   //
//               //   //             // if(validateInputremark()){
//               //   //             //   var conn = await Utilities.isInternetWorking();
//               //   //             //   showDialog(
//               //   //             //       barrierDismissible: false,
//               //   //             //       context: context,
//               //   //             //       builder: (context) {
//               //   //             //         return CupertinoAlertDialog(
//               //   //             //           title: Text('Please Wait'),
//               //   //             //           content: Column(
//               //   //             //             children: [
//               //   //             //               Divider(),
//               //   //             //               Padding(
//               //   //             //                 padding: const EdgeInsets.all(8.0),
//               //   //             //                 child: Text(conn
//               //   //             //                     ? 'Registering your Remark'
//               //   //             //                     : 'Saving offline'),
//               //   //             //               ),
//               //   //             //               CupertinoActivityIndicator(
//               //   //             //                 radius: 17,
//               //   //             //               )
//               //   //             //             ],
//               //   //             //           ),
//               //   //             //         );
//               //   //             //       });
//               //   //             //   var sales = Sales(
//               //   //             //       remark: remarkEditingController.text ,
//               //   //             //       outletId: _selectedIndex.toString()
//               //   //             //   );
//               //   //             //
//               //   //             //   if (conn) {
//               //   //             //     var response = await sellProductApi(sales);
//               //   //             //     Get.back();
//               //   //             //
//               //   //             //     Utilities.showInToast(response.message,
//               //   //             //         toastType: response.success
//               //   //             //             ? ToastType.SUCCESS
//               //   //             //             : ToastType.ERROR);
//               //   //             //
//               //   //             //     if (response.success) {
//               //   //             //
//               //   //             //       Get.back();
//               //   //             //     }
//               //   //             //   } else {
//               //   //             //     Get.back();
//               //   //             //
//               //   //             //
//               //   //             //
//               //   //             //   }
//               //   //             //
//               //   //             //   Get.find<ProductsController>().addremark(sales);
//               //   //             //   Get.back();
//               //   //             // } else {
//               //   //             //   Utilities.showInToast('Please complete the form',
//               //   //             //       toastType: ToastType.ERROR);
//               //   //             // }
//               //   //           },
//               //   //         ),
//               //   //       ],
//               //   //     );
//               //   //   },
//               //   // );
//               //   // print( Get.find<OutletsController>()
//               //   //     .outletList.length
//               //   //    );
//               //   //print(Get.find<Routecontroller>().routeList.length);
//               //   //print(Get.find<ChannelController>().channelList.length);
//               //
//               // }, child: Text("Press")),
//             ],
//
//             ),
//             // SizedBox(
//             //   width: Get.size.height * 1,
//             // ),
//             Divider(),
//             Center(
//               child: Text(
//
//                 outlet .name,
//                 style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold),
//               ),
//             ),
//
//             // Padding(
//             //   padding: const EdgeInsets.all(4.0),
//             //   child: Row(
//             //     mainAxisAlignment: MainAxisAlignment
//             //         .start,
//             //     children: [
//             //       // Icon(
//             //       //   Icons.person,
//             //       //   size: 16,
//             //       // ),
//             //       SizedBox(
//             //         width: 5,
//             //       ),
//             //       //   Image(image: item.image)
//             //
//             //     ],
//             //   ),
//             // ),
//             // Divider(),
//             // Padding(
//             //   padding: const EdgeInsets.all(4.0),
//             //   child: Row(
//             //     mainAxisAlignment: MainAxisAlignment
//             //         .start,
//             //     children: [
//             //       // Icon(
//             //       //   Icons.person,
//             //       //   size: 16,
//             //       // ),
//             //       SizedBox(
//             //         width: 5,
//             //       ),
//             //       //Text(item.ownerName),
//             //     ],
//             //   ),
//             // ),
//             // Padding(
//             //   padding: const EdgeInsets.all(4.0),
//             //   child: Row(
//             //     mainAxisAlignment: MainAxisAlignment
//             //         .start,
//             //     children: [
//             //       Icon(
//             //         Icons.phone,
//             //         size: 16,
//             //       ),
//             //       SizedBox(
//             //         width: 5,
//             //       ),
//             //       //Text(item.contact),
//             //     ],
//             //   ),
//             // ),
//             // Padding(
//             //   padding: const EdgeInsets.all(4.0),
//             //   child: Row(
//             //     mainAxisAlignment: MainAxisAlignment
//             //         .start,
//             //     children: [
//             //       Icon(
//             //         Icons.location_on,
//             //         size: 16,
//             //       ),
//             //       SizedBox(
//             //         width: 5,
//             //       ),
//             //       // Expanded(
//             //       //   child: Text(
//             //       //     province +
//             //       //         ", " +
//             //       //         district +
//             //       //         ", " +
//             //       //         area +
//             //       //         ", " +
//             //       //         (item.street ?? ""),
//             //       //     overflow: TextOverflow.visible,
//             //       //     style: TextStyle(fontSize: 12),
//             //       //   ),
//             //       // ),
//             //     ],
//             //   ),
//             // ),
//             // Padding(
//             //   padding: const EdgeInsets.all(4.0),
//             //   child: Row(
//             //     mainAxisAlignment: MainAxisAlignment
//             //         .start,
//             //     children: [
//             //       Icon(
//             //         Icons.category,
//             //         size: 16,
//             //       ),
//             //       SizedBox(
//             //         width: 5,
//             //       ),
//             //       //Text(item.type),
//             //     ],
//             //   ),
//             // ),
//             MaterialButton(
//               onPressed: () {
//                 Get.to(() =>
//                     SellProductPage(
//                       outlet: Get
//                           .find<OutletsController>()
//                           .outletList.first,
//                     ));
//               },
//               color: Colors.green[900],
//               minWidth: Get.size.width,
//               textColor: Colors.white,
//               padding: EdgeInsets.all(10.0),
//               child: Text("Sell Product"),
//             ),
//           ],
//         ),
//       );
//     }
//     Widget listSegment(List<Outlet> outList) {
//       return ListView.builder(
//         itemCount:  outList.length,
//         itemBuilder: (context, index) {
//           var item =   outList[index];
//           return Obx(
//                 () =>
//                 // Padding(
//                 //   padding: EdgeInsets.all(5),
//                 //   child: Container(
//                 //     decoration: BoxDecoration(
//                 //         color: Color(( Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.3),
//                 //         border: Border.all(
//                 //             color: Color(( Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.5),
//                 //             width: 3
//                 //         ),
//                 //         borderRadius: BorderRadius.circular(20)
//                 //     ),
//                 //     height: Get.size.height * 0.1,
//                 //     width: Get.size.width ,
//
//                 //    child:
//               ListTile(
//                       onTap: () async {
//                         _selectedIndex.value = index;
//                      //   selectedOutlet.value = outList[index];
//                       //   Constants.selectedDistributor = outList[index];
//                       // //  selectedDistributor.value = distList[index];
//                       //   _selectedIndex.value = index;
//                       //   Get.find<OutletsController>().fetchOutlets();
//                       //   print(Constants.selectedDistributor);
//                       //   Get.find<PreferenceController>()
//                       //       .setDistributor(jsonEncode(Constants.selectedDistributor));
//                       //   Utilities.showInToast(
//                       //       "Distributor : ${selectedDistributor.value.name}");
//                       //   var distributor = Distributor(
//                       //       id:  Constants.selectedDistributor.id
//                       //   );
//                       //   //   Get.find<DistributorController>().addDistributorlet(distributor);
//                       //   var conn = await Utilities.isInternetWorking();
//                       //   if(conn){
//                       //     registerdistributor(distributor);
//                       //     print(distributor );
//                       //     //    _displayDialog(context);
//                       //     // if(response.success){
//                       //     //   distributor.synced = true;
//                       //     // }
//                       //   }
//                       //   //    //Get.back();
//                       //   // _displayDialog(context);
//                       //   //Constants.selectedDistributor.id
//                       //   print(Constants.selectedDistributor.id);
//                       },
//                 selected: index == _selectedIndex.value,
//                       title: Card(
//                         elevation: 7,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Center(
//                                   child: CircleAvatar(
//                                     backgroundColor:  outList[index].synced
//                                         ? Colors.green
//                                         : Colors.grey,
//                                     child: Icon(
//                                       !outList[index].synced
//                                           ? Icons.cloud_off_outlined
//                                           : Icons.shopping_bag_outlined,
//                                       color: Colors.white,
//                                     ),
//                                   )),
//                             ),
//                             Center(
//                               child: Text(
//
//                                 outList[index].name,
//                                 style: TextStyle(
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                             ),
//           ElevatedButton(onPressed: (){
//             showDialog(
//               context: context,
//               builder: (BuildContext context) {
//                 return AlertDialog(
//                   title: new Text("Remark"),
//                   content:
//                   Padding(
//                     padding: const EdgeInsets.all(12.0),
//                     child: TextField(
//                       autofocus: false,
//                       decoration: InputDecoration(
//                           labelText: 'Add Your Remark',
//                           prefixIcon: Icon(Icons.person)),
//                       controller: remarkEditingController,
//                     ),
//                   ),
//
//                   actions: <Widget>[
//                     new ElevatedButton(
//                       child: new Text("OK"),
//                       onPressed: () async{
//
//                         if(validateInputremark()){
//                           var conn = await Utilities.isInternetWorking();
//                           showDialog(
//                               barrierDismissible: false,
//                               context: context,
//                               builder: (context) {
//                                 return CupertinoAlertDialog(
//                                   title: Text('Please Wait'),
//                                   content: Column(
//                                     children: [
//                                       Divider(),
//                                       Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: Text(conn
//                                             ? 'Registering your Remark'
//                                             : 'Saving offline'),
//                                       ),
//                                       CupertinoActivityIndicator(
//                                         radius: 17,
//                                       )
//                                     ],
//                                   ),
//                                 );
//                               });
//                           var sales = Sales(
//                               remark: remarkEditingController.text[index],
//                               outletId: _selectedIndex.toString()
//                           );
//
//                           if (conn) {
//                             var response = await sellProductApi(sales);
//                             Get.back();
//
//                             Utilities.showInToast(response.message,
//                                 toastType: response.success
//                                     ? ToastType.SUCCESS
//                                     : ToastType.ERROR);
//
//                             if (response.success) {
//
//                               Get.back();
//                             }
//                           } else {
//                             Get.back();
//
//
//
//                           }
//
//                           Get.find<ProductsController>().addremark(sales);
//                           Get.back();
//                         } else {
//                           Utilities.showInToast('Please complete the form',
//                               toastType: ToastType.ERROR);
//                         }
//                       },
//                     ),
//                   ],
//                 );
//               },
//             );
//                 // print( Get.find<OutletsController>()
//                 //     .outletList.length
//                  //    );
//                 //print(Get.find<Routecontroller>().routeList.length);
//                 //print(Get.find<ChannelController>().channelList.length);
//             }, child: Text("Press")),
//                             // Padding(
//                             //   padding: const EdgeInsets.all(4.0),
//                             //   child: Row(
//                             //     mainAxisAlignment: MainAxisAlignment
//                             //         .start,
//                             //     children: [
//                             //       // Icon(
//                             //       //   Icons.person,
//                             //       //   size: 16,
//                             //       // ),
//                             //       SizedBox(
//                             //         width: 5,
//                             //       ),
//                             //       //   Image(image: item.image)
//                             //
//                             //     ],
//                             //   ),
//                             // ),
//                             // Divider(),
//                             // Padding(
//                             //   padding: const EdgeInsets.all(4.0),
//                             //   child: Row(
//                             //     mainAxisAlignment: MainAxisAlignment
//                             //         .start,
//                             //     children: [
//                             //       // Icon(
//                             //       //   Icons.person,
//                             //       //   size: 16,
//                             //       // ),
//                             //       SizedBox(
//                             //         width: 5,
//                             //       ),
//                             //       //Text(item.ownerName),
//                             //     ],
//                             //   ),
//                             // ),
//                             // Padding(
//                             //   padding: const EdgeInsets.all(4.0),
//                             //   child: Row(
//                             //     mainAxisAlignment: MainAxisAlignment
//                             //         .start,
//                             //     children: [
//                             //       Icon(
//                             //         Icons.phone,
//                             //         size: 16,
//                             //       ),
//                             //       SizedBox(
//                             //         width: 5,
//                             //       ),
//                             //       //Text(item.contact),
//                             //     ],
//                             //   ),
//                             // ),
//                             // Padding(
//                             //   padding: const EdgeInsets.all(4.0),
//                             //   child: Row(
//                             //     mainAxisAlignment: MainAxisAlignment
//                             //         .start,
//                             //     children: [
//                             //       Icon(
//                             //         Icons.location_on,
//                             //         size: 16,
//                             //       ),
//                             //       SizedBox(
//                             //         width: 5,
//                             //       ),
//                             //       // Expanded(
//                             //       //   child: Text(
//                             //       //     province +
//                             //       //         ", " +
//                             //       //         district +
//                             //       //         ", " +
//                             //       //         area +
//                             //       //         ", " +
//                             //       //         (item.street ?? ""),
//                             //       //     overflow: TextOverflow.visible,
//                             //       //     style: TextStyle(fontSize: 12),
//                             //       //   ),
//                             //       // ),
//                             //     ],
//                             //   ),
//                             // ),
//                             // Padding(
//                             //   padding: const EdgeInsets.all(4.0),
//                             //   child: Row(
//                             //     mainAxisAlignment: MainAxisAlignment
//                             //         .start,
//                             //     children: [
//                             //       Icon(
//                             //         Icons.category,
//                             //         size: 16,
//                             //       ),
//                             //       SizedBox(
//                             //         width: 5,
//                             //       ),
//                             //       //Text(item.type),
//                             //     ],
//                             //   ),
//                             // ),
//                             MaterialButton(
//                               onPressed: () {
//                                 Get.to(() =>
//                                     SellProductPage(
//                                         outlet: Get
//                                             .find<OutletsController>()
//                                             .outletList[index],
//                                     ));
//                               },
//                               color: Colors.green[900],
//                               minWidth: Get.size.width,
//                               textColor: Colors.white,
//                               padding: EdgeInsets.all(10.0),
//                               child: Text("Sell Product"),
//                             ),
//                           ],
//                         ),
//                       ),
//                       // Row(
//                       //   children: [
//                       //     Text(
//                       //       outList[index].name,
//                       //     ),
//                       //     Text(outList[index].name)
//                       //   ],
//                       // ),
//                     ),
//                   );
//
//         },
//       );
//     }
//
//     Widget _buildListViewWidget(List<Outlet> outletList) {
//       return ListView.builder(
//           shrinkWrap: true,
//           physics: NeverScrollableScrollPhysics(),
//           itemCount: outletList.length,
//           itemBuilder: (context, index) {
//             return buildMainTile(outletList[index]);
//           });
//     }
//     Widget outletList() {
//       return Expanded(
//         child: GetBuilder<OutletsController>(
//           init: OutletsController(),
//           builder: (controller) {
//             return controller.searchList.isNotEmpty
//                 ? listSegment(controller.searchList)
//                 : controller.outletList != null
//                 ? controller.outletList.isEmpty
//                 ? Center(child: Text("No Distributors"))
//                 : listSegment(controller.outletList)
//                 : Center(
//               child: CircularProgressIndicator(),
//             );
//           },
//         ),
//       );
//     }
//     // Widget outletlist(){
//     //   return Expanded(child: GetBuilder<OutletsController>(
//     //     init: OutletsController(),
//     //     builder: (outletcontroller){
//     //       return outletcontroller.searchList.isNotEmpty
//     //           ? listoutlet(outletcontroller.searchList) :
//     //       outletcontroller.outletList != null
//     //           ? outletcontroller.outletList.isEmpty
//     //           ? Center(child: Text("No route")): listoutlet(outletcontroller.outletList )
//     //           : Center(child: CircularProgressIndicator(),);
//     //     },
//     //
//     //   ));
//     // }
//
//
//
//
//
//     return Scaffold(
//         floatingActionButton: FloatingActionButton.extended(
//           label: Row(
//             children: [
//               Icon(Icons.sync),
//               Text("Sync Outlets"),
//             ],
//           ),
//           onPressed: () async {
//             print(Get
//                 .find<OutletsController>()
//                 .outletList.length);
//             // if (_lock) return;
//             // var conn = await Utilities.isInternetWorking();
//             // if (conn) {
//             //   Utilities.showInToast('Syncing Data', toastType: ToastType.INFO);
//             //   await Get.find<OutletsController>().syncData();
//             //   print(Get.find<OutletsController>().syncData());
//             //   Utilities.showInToast('Syncing Success',
//             //       toastType: ToastType.SUCCESS);
//             //
//             //   _lock = false;
//             // } else {
//             //   Utilities.showInToast('No internet services!',
//             //       toastType: ToastType.INFO);
//             // }
//           },
//         ),
//
//
//         appBar: AppBar(
//           title: Text('Outlets'),
//         ),
//         body:
//
//             GetBuilder<OutletsController>(
//               builder: (outletController)
//     {
//       return Get
//           .find<OutletsController>()
//           .outletList
//           .isEmpty
//           ? Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // GestureDetector(
//             //   child: TextField(
//             //     controller: textEditingController,
//             //     decoration: InputDecoration(
//             //       border: OutlineInputBorder(
//             //         borderSide: BorderSide(
//             //           color: Colors.red, //this has no effect
//             //         ),
//             //         borderRadius: BorderRadius.circular(10.0),
//             //       ),
//             //       hintText: "Search Distributor...",
//             //     ),
//             //     onChanged: (text) {
//             //       Get.find<OutletsController>().searchOutlets(text);
//             //       // Get.find<Distributor_Route_Controller>().addDistributorlet(distributorList());
//             //     },
//             //   ),
//             //   onTap: () {},
//             // ),
//             Text("Distributor: " +
//                 Constants.selectedRoute.routename.toString()),
//             Text("No outlet found for selected distributor"),
//           ],
//         ),
//       )
//           : Scrollbar(
//         isAlwaysShown: true,
//         interactive: true,
//         thickness: 6.0,
//         child:  Get.find<OutletsController>().outletList == null
//             ? Center(
//           child: CircularProgressIndicator(),
//         ):  Column(
//           children: [
//             GestureDetector(
//               child: TextField(
//                 controller: textEditingController,
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(
//                     borderSide: BorderSide(
//                       color: Colors.red, //this has no effect
//                     ),
//                     borderRadius: BorderRadius.circular(10.0),
//                   ),
//                   hintText: "Search Distributor...",
//                 ),
//                 onChanged: (text) {
//                   Get.find<OutletsController>().searchOutlets(text);
//                   // Get.to((text) =>
//                   //     SellProductPage(
//                   //         outlet: Get
//                   //             .find<OutletsController>()
//                   //             .outletList[text]));
//     },
//
//
//               ),
//               onTap: (){
//             //    Get.to((text) =>
//                     // SellProductPage(
//                     //     outlet: Get
//                     //         .find<OutletsController>()
//                     //         .outletList[text]));
//               },
//             ),
//             _buildListViewWidget(Get.find<OutletsController>()
//                 .outletList)
//             //outletList()
//           ],
//         ),
//         //outletlist()
//
//       );
//     }
//     )
//     );}}
//
// import 'dart:convert';
// import 'dart:io';
//
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:mobitrack_dv_flutter/controller/address_controller.dart';
// import 'package:mobitrack_dv_flutter/controller/outlets_controller.dart';
// import 'package:mobitrack_dv_flutter/controller/products_controller.dart';
// import 'package:mobitrack_dv_flutter/model/outlet.dart';
// import 'package:mobitrack_dv_flutter/model/products.dart';
// import 'package:mobitrack_dv_flutter/utils/constants.dart';
// import 'package:mobitrack_dv_flutter/utils/utilities.dart';
// import 'package:mobitrack_dv_flutter/view/products/sell_products.dart';
//
// import '../../controller/database_controller.dart';
// import 'package:equatable/equatable.dart';
//
//
// class ViewOutletPage extends StatefulWidget{
//   @override
//   State<StatefulWidget> createState() {
//     // TODO: implement createState
//     return ViewOutletsPages();
//   }
//
// }
// class ViewOutletsPages extends State<ViewOutletPage> {
//   var outlet = Get.lazyPut(() => OutletsController());
//
//   bool _lock = false;
//   List<Outlet> outlets = Get.find<OutletsController>().outletList;
//   DatabaseHelper databaseHelper;
//   TextEditingController textEditingController ;
//   TextEditingController remarkEditingController = new TextEditingController();
//   var selectedOutlet = Outlet();
//   var selectedoutlet = [];
//   var _selectedIndex = 0 .obs;
//   Sales sales = Sales();
//   String selectedDrowpdown ="";
//   List<String> item = ["1","Stock Available Image","margin Issue","Owner not in shop","Credit limit Issue"];
//
//   String base64Image;
//   XFile _imageFile;
//   final ImagePicker _picker = ImagePicker();
//
//   // final outlet = createoutlet();
//
//   @override
//   Widget build(BuildContext context) {
//
//     bool validateInputremark(){
//       return remarkEditingController.text.isNotEmpty;
//     }
//
//     // Widget listoutlet(List<Outlet> outletlist){
//     //   return ListView.builder(
//     //       itemCount:
//     //       //Constants.outletLlist.length,
//     //       Get.find<OutletsController>().outletList.length,
//     //       itemBuilder: (context, index) {
//     //         var list = Get
//     //             .find<OutletsController>()
//     //             .outletList;
//     //         print(list);
//     //         var item =
//     //         //Constants.outletLlist[index];
//     //         Get
//     //             .find<OutletsController>()
//     //             .outletList[index];
//     //         // print(Get
//     //         //     .find<AddressController>()
//     //         //     .addressList);
//     //         // if (item.route == Constants.outletLlist) {
//     //         // String province = Get.find<AddressController>()
//     //         //     .addressList
//     //         //     .where((element) =>
//     //         // element.id ==
//     //         //     int.parse(item.addressId.toString()))
//     //         //     .toList()
//     //         //     .first
//     //         //     .province;
//     //         // String district = Get.find<AddressController>()
//     //         //     .addressList
//     //         //     .where((element) =>
//     //         // element.id ==
//     //         //     int.parse(item.addressId.toString()))
//     //         //     .toList()
//     //         //     .first
//     //         //     .district;
//     //         // String area = Get.find<AddressController>()
//     //         //     .addressList
//     //         //     .where((element) =>
//     //         // element.id ==
//     //         //     int.parse(item.addressId.toString()))
//     //         //     .toList()
//     //         //     .first
//     //         //     .localLevelEn;
//     //
//     //         return
//     //           // item.longitude != null ?
//     //
//     //           Container(
//     //             child: Card(
//     //               elevation: 7,
//     //               child: Column(
//     //                 crossAxisAlignment: CrossAxisAlignment.start,
//     //                 mainAxisSize: MainAxisSize.min,
//     //                 children: [
//     //                   Padding(
//     //                     padding: const EdgeInsets.all(8.0),
//     //                     child: Center(
//     //                         child: CircleAvatar(
//     //                           backgroundColor: item.synced
//     //                               ? Colors.green
//     //                               : Colors.grey,
//     //                           child: Icon(
//     //                             !item.synced
//     //                                 ? Icons.cloud_off_outlined
//     //                                 : Icons.shopping_bag_outlined,
//     //                             color: Colors.white,
//     //                           ),
//     //                         )),
//     //                   ),
//     //                   Center(
//     //                     child: Text(
//     //
//     //                       item.name,
//     //                       style: TextStyle(
//     //                           fontSize: 18,
//     //                           fontWeight: FontWeight.bold),
//     //                     ),
//     //                   ),
//     //                   Padding(
//     //                     padding: const EdgeInsets.all(4.0),
//     //                     child: Row(
//     //                       mainAxisAlignment: MainAxisAlignment
//     //                           .start,
//     //                       children: [
//     //                         // Icon(
//     //                         //   Icons.person,
//     //                         //   size: 16,
//     //                         // ),
//     //                         SizedBox(
//     //                           width: 5,
//     //                         ),
//     //                         //   Image(image: item.image)
//     //
//     //                       ],
//     //                     ),
//     //                   ),
//     //                   Divider(),
//     //                   Padding(
//     //                     padding: const EdgeInsets.all(4.0),
//     //                     child: Row(
//     //                       mainAxisAlignment: MainAxisAlignment
//     //                           .start,
//     //                       children: [
//     //                         // Icon(
//     //                         //   Icons.person,
//     //                         //   size: 16,
//     //                         // ),
//     //                         SizedBox(
//     //                           width: 5,
//     //                         ),
//     //                         //Text(item.ownerName),
//     //                       ],
//     //                     ),
//     //                   ),
//     //                   Padding(
//     //                     padding: const EdgeInsets.all(4.0),
//     //                     child: Row(
//     //                       mainAxisAlignment: MainAxisAlignment
//     //                           .start,
//     //                       children: [
//     //                         Icon(
//     //                           Icons.phone,
//     //                           size: 16,
//     //                         ),
//     //                         SizedBox(
//     //                           width: 5,
//     //                         ),
//     //                         //Text(item.contact),
//     //                       ],
//     //                     ),
//     //                   ),
//     //                   Padding(
//     //                     padding: const EdgeInsets.all(4.0),
//     //                     child: Row(
//     //                       mainAxisAlignment: MainAxisAlignment
//     //                           .start,
//     //                       children: [
//     //                         Icon(
//     //                           Icons.location_on,
//     //                           size: 16,
//     //                         ),
//     //                         SizedBox(
//     //                           width: 5,
//     //                         ),
//     //                         // Expanded(
//     //                         //   child: Text(
//     //                         //     province +
//     //                         //         ", " +
//     //                         //         district +
//     //                         //         ", " +
//     //                         //         area +
//     //                         //         ", " +
//     //                         //         (item.street ?? ""),
//     //                         //     overflow: TextOverflow.visible,
//     //                         //     style: TextStyle(fontSize: 12),
//     //                         //   ),
//     //                         // ),
//     //                       ],
//     //                     ),
//     //                   ),
//     //
//     //                   Padding(
//     //                     padding: const EdgeInsets.all(4.0),
//     //                     child: Row(
//     //                       mainAxisAlignment: MainAxisAlignment
//     //                           .start,
//     //                       children: [
//     //                         Icon(
//     //                           Icons.category,
//     //                           size: 16,
//     //                         ),
//     //                         SizedBox(
//     //                           width: 5,
//     //                         ),
//     //                         //Text(item.type),
//     //                       ],
//     //                     ),
//     //                   ),
//     //                   MaterialButton(
//     //                     onPressed: () {
//     //                       Get.to(() =>
//     //                           SellProductPage(
//     //                               outlet: Get
//     //                                   .find<OutletsController>()
//     //                                   .outletList[index]));
//     //                     },
//     //                     color: Colors.green[900],
//     //                     minWidth: Get.size.width,
//     //                     textColor: Colors.white,
//     //                     padding: EdgeInsets.all(10.0),
//     //                     child: Text("Sell Product"),
//     //                   ),
//     //                 ],
//     //               ),
//     //             ),
//     //           );
//     //       }
//     //
//     //   );
//     // }
//
//     // List item = ["Outlet Closed Image","Stock Availabe Image","margin Issue","Owner not in shop","Credit limit Issue"];
//     // String _selectedvalue= "Outlet Closed Image".obs;
//
//     void pickImage() async {
//       try {
//         final pickedFile = await _picker.pickImage(
//           source: ImageSource.camera,
//           imageQuality: 25,
//         );
//         if (pickedFile != null) {
//           setState(() {
//             _imageFile = pickedFile;
//
//           });
//           List<int> imageBytes = await pickedFile.readAsBytes();
//           base64Image = base64Encode(imageBytes);
//
//           print(base64Image);
//         }
//       } catch (e) {
//         Utilities.showInToast(e.message);
//       }
//     }
//     InputDecoration decoration(String label) {
//       return InputDecoration(
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12.0),
//         ),
//         labelText: label,
//       );
//     }
//     void showQuantityBottomSheet( ) {
//       String addedQuantity;
//       String discountPercent = "0";
//       Get.bottomSheet(
//         // ListView.builder(itemCount: Get.find<OutletsController>().item?.length != null ? Get.find<OutletsController>().item?.length  : "",
//         //     itemBuilder: (context, index){
//        //   return
//       Container(
//               child: Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Padding(
//                         padding: const EdgeInsets.all(12.0),
//                         child:
//                         // DropdownButton(
//                         //
//                         //   // Initial Value
//                         //     value: selectedDrowpdown,
//                         //
//                         //     // Down Arrow Icon
//                         //     icon: const Icon(Icons.keyboard_arrow_down),
//                         //
//                         //     // Array list of items
//                         //     items: item.map((String items) {
//                         //       return DropdownMenuItem(
//                         //         value: items,
//                         //         child: Text(items),
//                         //       );
//                         //     }).toList(),
//                         // After selecting the desired option,it will
//                         // change button value to selected value
//                         // onChanged: (String newValue) {
//                         //   setState(() {
//                         //     selectedDrowpdown = newValue;
//                         //   });
//                         //                 DropdownButton(
//                         //                 hint: Text("Outlet Closed Image"), // Not necessary for Option 1
//                         //   value:selectedDrowpdown,
//                         //   onChanged: (newValue) {
//                         //     selectedDrowpdown = newValue;
//                         //   setState(() {
//                         //   selectedDrowpdown = newValue;
//                         // //  print(newValue);
//                         //   //print(selectedDrowpdown);
//                         //   });
//                         //   },
//                         //   items: item.map((location) {
//                         //   return DropdownMenuItem(
//                         //   child: new Text(location),
//                         //   value: location,
//                         //   );
//                         //   }).toList(),
//                         //   ),
//                         Padding(
//                           padding: const EdgeInsets.all(10.0),
//                           child: GetBuilder<OutletsController>(
//                             builder: (builder) {
//                               return Get.find<OutletsController>().item.length == null
//                                   ? SizedBox()
//                                   : InputDecorator(
//                                 decoration: decoration("Select Remark"),
//                                 child: ButtonTheme(
//                                   alignedDropdown: true,
//                                   child: DropdownButton<String>(
//                                     // iconEnabledCo
//                                     // iconDisabledColor: Colors.red,
//                                     isDense: true,
//                                     isExpanded: true,
//                                     hint: Text(
//                                         Get.find<OutletsController>().selectedDrowpdown),
//                                     items:
//                                     Get.find<OutletsController>().item.map((e) {
//                                       return DropdownMenuItem<String>(
//                                           value: e, child: Text(e));
//                                     }).toList(),
//                                     onChanged: (district) {
//                                       setState(() {
//                                      //   Get.find<OutletsController>().selectedDrowpdown = district;
//                                        Get.find<OutletsController>().setitem(district);
//                                     //  district = addedQuantity.toString();
//                                       // Get.find<OutletsController>().selectedDrowpdown = addedQuantity.toString();
//                                       });
//                                      // district = selectedDrowpdown;
//
//                                     //  print(addedQuantity);
//                                      print(Get.find<OutletsController>().selectedDrowpdown);
//                                      // print(selectedDrowpdown);
//                                    //   print(Get.find<OutletsController>().setitem(district ));
//                                    //   district = Constants.item;
//                                       //      print(selectedDrowpdown);
//                                       //   district = Constants.selectedzone.zone;
//                                       // Get.find<AddressController>().getAreaList(district);
//                                     },
//                                   ),
//                                 ),
//                               );
//                             },
//                           ),
//                         )
//                       // DropdownButton<String>(
//                       //   hint: Text("Remark"),
//                       //   value:  selectedDrowpdown,
//                       //   items:
//                       //   //[for(var data in  Get.find<OutletsController>().item)])
//                       //   // [
//                       //   //   for (var data in Get.find<OutletsController>().item)
//                       //   //     DropdownMenuItem(
//                       //   //       child: new Text(
//                       //   //         data,
//                       //   //       ),
//                       //   //       value: data,
//                       //   //     )
//                       //   // ],
//                       //
//                       //   // Get.find<OutletsController>().item.map((e) {
//                       //   //   return DropdownMenuItem<String>(
//                       //   //           value: e,
//                       //   //           child: Text(e),
//                       //   //         );
//                       //   // }),
//                       //     item.map((  value) {
//                       //     return DropdownMenuItem<String>(
//                       //       value: value,
//                       //       child: Text(value),
//                       //     );
//                       //   }).toList(),
//                       //   onChanged: (newvalue) {
//                       //     setState(() {
//                       //      selectedDrowpdown = newvalue ;
//                       //     });
//                       //
//                       // //   Get.find<OutletsController>().setitem(newvalue);
//                       //
//                       //
//                       //    //_selectedvalue = newvalue;
//                       //   })
//                     ),
//
//                     SizedBox(height: Get.size.height * 0.01),
//                     Container(
//                       child: _imageFile == null
//                           ? Center(
//                         child: Text("No Image Selected"),
//                       )
//                           : Image.file(File(_imageFile.path)),
//                     ),
//                     ElevatedButton(
//                       onPressed: () async {
//                         // pickImage();
//                         if (Get.find<OutletsController>().selectedDrowpdown.isNotEmpty) {
//                           var conn = await Utilities.isInternetWorking();
//                           showDialog(
//                               barrierDismissible: false,
//                               context: context,
//                               builder: (context) {
//                                 return CupertinoAlertDialog(
//                                   title: Text('Please Wait'),
//                                   content: Column(
//                                     children: [
//                                       Divider(),
//                                       Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: Text(conn
//                                             ? 'Registering new Sales Outlet'
//                                             : 'Saving offline'),
//                                       ),
//                                       CupertinoActivityIndicator(
//                                         radius: 17,
//                                       )
//                                     ],
//                                   ),
//                                 );
//                               });
//                           var sales = Sales(
//                               outletId:  "12",
//                               remark:  Get.find<OutletsController>().selectedDrowpdown,
//                                orders:  "gkhg",
//                           // sales.distributorId = "12";
//                            soldAt: DateTime.now().toString(),
//                         outletLatitude: "55656",
//                             outletLongitude: "gjf"
//                           );
//                           // selectedoutlet.add({
//                           //   //"outlet_id": outletId,
//                           //
//                           //   "remark": selectedDrowpdown,
//                           //
//                           // });
//                           if (conn) {
//                             var response = await sellProductApi(sales);
//                             print(sales);
//                           // Get.back();
//                             Utilities.showInToast(response.message,
//                                 toastType: response.success
//                                     ? ToastType.SUCCESS
//                                     : ToastType.ERROR);
//
//                             //   if (response.success) {
//                             //     outlet.synced = true;
//                             //     Get.back();
//                             //   }
//                             // } else {
//                             //   Get.back();
//                             //   outlet.synced = false;
//                             //
//                             //   Utilities.showInToast('Storing Offline',
//                             //       toastType: ToastType.INFO);
//                             // }
//                             // await DatabaseHelper.instance
//                             //     .insertOutlet(outlet);
//                             // Get.find<ProductsController>().addremark(sales);
//                             Get.back();
//                           } else {
//                             Utilities.showInToast('Please complete the form',
//                                 toastType: ToastType.ERROR);
//                           }
//                           // if (selectedDrowpdown != null) {
//                           //   // selectedoutlet.add({
//                           //   //   //"outlet_id": outletId,
//                           //   //
//                           //   //   "remark": selectedDrowpdown,
//                           //   //
//                           //   // });
//                           //   sales.remark = jsonEncode(selectedoutlet);
//                           //   Get.find<OutletsController>().addoutletInList(outletId);
//                           //   //Get.find<ProductsController>().addremark(selectedoutlet);
//                           //   Utilities.showInToast("Remark Noted");
//                           //   print(selectedDrowpdown);
//                           // } else {
//                           //   Utilities.showInToast("Please add Remark");
//                           // }
//                           Get.back();}
//                       },
//                       child: Text("Add"),
//                     )
//                   ],
//                 ),
//               )
//         ),
//         shape: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
//         backgroundColor: Colors.white,
//         enableDrag: true,
//       );
//     }
//
//
//
//     void _showDialog(BuildContext context) {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: new Text("Remark"),
//             content:
//             Padding(
//               padding: const EdgeInsets.all(12.0),
//               child: TextField(
//                 autofocus: false,
//                 decoration: InputDecoration(
//                     labelText: 'Add Your Remark',
//                     prefixIcon: Icon(Icons.person)),
//                 controller: remarkEditingController,
//               ),
//             ),
//
//             actions: <Widget>[
//               new ElevatedButton(
//                 child: new Text("OK"),
//                 onPressed: () async{
//                   if(validateInputremark()){
//                   var conn = await Utilities.isInternetWorking();
//                   showDialog(
//                       barrierDismissible: false,
//                       context: context,
//                       builder: (context) {
//                         return CupertinoAlertDialog(
//                           title: Text('Please Wait'),
//                           content: Column(
//                             children: [
//                               Divider(),
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Text(conn
//                                     ? 'Registering your Remark'
//                                     : 'Saving offline'),
//                               ),
//                               CupertinoActivityIndicator(
//                                 radius: 17,
//                               )
//                             ],
//                           ),
//                         );
//                       });
//                   // var sales = Sales(
//                   //   remark: remarkEditingController.text,
//                   //
//                   // );
//
//           if (conn) {
//           var response = await sellProductApi(sales);
//           Get.back();
//
//           Utilities.showInToast(response.message,
//           toastType: response.success
//           ? ToastType.SUCCESS
//               : ToastType.ERROR);
//
//           if (response.success) {
//
//           Get.back();
//           }
//           } else {
//           Get.back();
//
//
//
//           }
//
//           Get.find<ProductsController>().addremark(sales);
//           Get.back();
//           } else {
//           Utilities.showInToast('Please complete the form',
//           toastType: ToastType.ERROR);
//           }
//                 },
//               ),
//             ],
//           );
//         },
//       );
//     }
//     Widget buildMainTile(List<Outlet> outlet) {
//       return  ListView.builder(
//         itemCount: outlet.length,
//         itemBuilder: (context,index){
//           return   Card(
//             elevation: 7,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Row(
//                   mainAxisAlignment:  MainAxisAlignment.end,
//                   children: [
//
//                     Padding(
//                       padding: const EdgeInsets.only(right: 1),
//                       child: Center(
//                           child: CircleAvatar(
//                             radius: (35),
//                             backgroundColor:  outlet[index].synced
//                                 ? Colors.green
//                                 : Colors.grey,
//                             child: Icon(
//                               !outlet[index].synced
//                                   ? Icons.cloud_off_outlined
//                                   : Icons.shopping_bag_outlined,
//                               color: Colors.white,
//                             ),
//                           )),
//                     ),
//                     SizedBox(
//                       width: Get.size.width * 0.3,
//                     ),
//                     CircleAvatar(
//                         radius: (20),
//                         backgroundColor:  outlet[index].synced
//                             ? Colors.blueGrey
//                             : Colors.grey,
//                         child:  IconButton(onPressed:(){
//                           // showQuantityBottomSheet(outlet.id.toString());
//
//                           Get.bottomSheet(
//                             // ListView.builder(itemCount: Get.find<OutletsController>().item?.length != null ? Get.find<OutletsController>().item?.length  : "",
//                             //   itemBuilder: (context, index){
//                             //     return
//                             Container(
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(10.0),
//                                   child: Column(
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: [
//                                       Padding(
//                                           padding: const EdgeInsets.all(12.0),
//                                           child:
//                                           // DropdownButton(
//                                           //
//                                           //   // Initial Value
//                                           //     value: selectedDrowpdown,
//                                           //
//                                           //     // Down Arrow Icon
//                                           //     icon: const Icon(Icons.keyboard_arrow_down),
//                                           //
//                                           //     // Array list of items
//                                           //     items: item.map((String items) {
//                                           //       return DropdownMenuItem(
//                                           //         value: items,
//                                           //         child: Text(items),
//                                           //       );
//                                           //     }).toList(),
//                                           // After selecting the desired option,it will
//                                           // change button value to selected value
//                                           // onChanged: (String newValue) {
//                                           //   setState(() {
//                                           //     selectedDrowpdown = newValue;
//                                           //   });
//                                           //                 DropdownButton(
//                                           //                 hint: Text("Outlet Closed Image"), // Not necessary for Option 1
//                                           //   value:selectedDrowpdown,
//                                           //   onChanged: (newValue) {
//                                           //     selectedDrowpdown = newValue;
//                                           //   setState(() {
//                                           //   selectedDrowpdown = newValue;
//                                           // //  print(newValue);
//                                           //   //print(selectedDrowpdown);
//                                           //   });
//                                           //   },
//                                           //   items: item.map((location) {
//                                           //   return DropdownMenuItem(
//                                           //   child: new Text(location),
//                                           //   value: location,
//                                           //   );
//                                           //   }).toList(),
//                                           //   ),
//                                           Padding(
//                                             padding: const EdgeInsets.all(10.0),
//                                             child: GetBuilder<OutletsController>(
//                                               builder: (builder) {
//                                                 return Get.find<OutletsController>().item.length == null
//                                                     ? SizedBox()
//                                                     : InputDecorator(
//                                                   decoration: decoration("Select Remark"),
//                                                   child: ButtonTheme(
//                                                     alignedDropdown: true,
//                                                     child: DropdownButton<String>(
//                                                       // iconEnabledCo
//                                                       // iconDisabledColor: Colors.red,
//                                                       isDense: true,
//                                                       isExpanded: true,
//                                                       hint: Text(
//                                                           Get.find<OutletsController>().selectedDrowpdown),
//                                                       items:
//                                                       Get.find<OutletsController>().item.map((e) {
//                                                         return DropdownMenuItem<String>(
//                                                             value: e, child: Text(e));
//                                                       }).toList(),
//                                                       onChanged: (String district) {
//                                                         setState(() {
//                                                           Get.find<OutletsController>().selectedDrowpdown = district;
//                                                           //  Get.find<OutletsController>().setitem(district );
//                                                         });
//
//                                                         // district = selectedDrowpdown;
//                                                         print(Get.find<OutletsController>().selectedDrowpdown);
//                                                         print(district);
//                                                         //   print(Get.find<OutletsController>().setitem(district ));
//                                                         //   district = Constants.item;
//                                                         //      print(selectedDrowpdown);
//                                                         //   district = Constants.selectedzone.zone;
//                                                         // Get.find<AddressController>().getAreaList(district);
//                                                       },
//                                                     ),
//                                                   ),
//                                                 );
//                                               },
//                                             ),
//                                           )
//                                         // DropdownButton<String>(
//                                         //   hint: Text("Remark"),
//                                         //   value:  selectedDrowpdown,
//                                         //   items:
//                                         //   //[for(var data in  Get.find<OutletsController>().item)])
//                                         //   // [
//                                         //   //   for (var data in Get.find<OutletsController>().item)
//                                         //   //     DropdownMenuItem(
//                                         //   //       child: new Text(
//                                         //   //         data,
//                                         //   //       ),
//                                         //   //       value: data,
//                                         //   //     )
//                                         //   // ],
//                                         //
//                                         //   // Get.find<OutletsController>().item.map((e) {
//                                         //   //   return DropdownMenuItem<String>(
//                                         //   //           value: e,
//                                         //   //           child: Text(e),
//                                         //   //         );
//                                         //   // }),
//                                         //     item.map((  value) {
//                                         //     return DropdownMenuItem<String>(
//                                         //       value: value,
//                                         //       child: Text(value),
//                                         //     );
//                                         //   }).toList(),
//                                         //   onChanged: (newvalue) {
//                                         //     setState(() {
//                                         //      selectedDrowpdown = newvalue ;
//                                         //     });
//                                         //
//                                         // //   Get.find<OutletsController>().setitem(newvalue);
//                                         //
//                                         //
//                                         //    //_selectedvalue = newvalue;
//                                         //   })
//                                       ),
//
//                                       SizedBox(height: Get.size.height * 0.01),
//                                       Container(
//                                         child: _imageFile == null
//                                             ? Center(
//                                           child: Text("No Image Selected"),
//                                         )
//                                             : Image.file(File(_imageFile.path)),
//                                       ),
//                                       ElevatedButton(
//                                         onPressed: () async {
//                                           // pickImage();
//                                           if (Get.find<OutletsController>().selectedDrowpdown.isNotEmpty) {
//                                             var conn = await Utilities.isInternetWorking();
//                                             showDialog(
//                                                 barrierDismissible: false,
//                                                 context: context,
//                                                 builder: (context) {
//                                                   return CupertinoAlertDialog(
//                                                     title: Text('Please Wait'),
//                                                     content: Column(
//                                                       children: [
//                                                         Divider(),
//                                                         Padding(
//                                                           padding: const EdgeInsets.all(8.0),
//                                                           child: Text(conn
//                                                               ? 'Registering new Sales Outlet'
//                                                               : 'Saving offline'),
//                                                         ),
//                                                         CupertinoActivityIndicator(
//                                                           radius: 17,
//                                                         )
//                                                       ],
//                                                     ),
//                                                   );
//                                                 });
//                                             // var sales = Sales(
//                                             //     outletId:  outlet[index].id.toString(),
//                                             //     remark:  Get.find<OutletsController>().selectedDrowpdown
//                                             // );
//                                             // selectedoutlet.add({
//                                             //   //"outlet_id": outletId,
//                                             //
//                                             //   "remark": selectedDrowpdown,
//                                             //
//                                             // });
//                                             if (conn) {
//                                               var response = await sellProductApi(sales);
//                                               print(sales);
//                                               // Get.back();
//                                               Utilities.showInToast(response.message,
//                                                   toastType: response.success
//                                                       ? ToastType.SUCCESS
//                                                       : ToastType.ERROR);
//
//                                               //   if (response.success) {
//                                               //     outlet.synced = true;
//                                               //     Get.back();
//                                               //   }
//                                               // } else {
//                                               //   Get.back();
//                                               //   outlet.synced = false;
//                                               //
//                                               //   Utilities.showInToast('Storing Offline',
//                                               //       toastType: ToastType.INFO);
//                                               // }
//                                               // await DatabaseHelper.instance
//                                               //     .insertOutlet(outlet);
//                                               // Get.find<ProductsController>().addremark(sales);
//                                               Get.back();
//                                             } else {
//                                               Utilities.showInToast('Please complete the form',
//                                                   toastType: ToastType.ERROR);
//                                             }
//                                             // if (selectedDrowpdown != null) {
//                                             //   // selectedoutlet.add({
//                                             //   //   //"outlet_id": outletId,
//                                             //   //
//                                             //   //   "remark": selectedDrowpdown,
//                                             //   //
//                                             //   // });
//                                             //   sales.remark = jsonEncode(selectedoutlet);
//                                             //   Get.find<OutletsController>().addoutletInList(outletId);
//                                             //   //Get.find<ProductsController>().addremark(selectedoutlet);
//                                             //   Utilities.showInToast("Remark Noted");
//                                             //   print(selectedDrowpdown);
//                                             // } else {
//                                             //   Utilities.showInToast("Please add Remark");
//                                             // }
//                                             Get.back();}
//                                         },
//                                         child: Text("Add"),
//                                       )
//                                     ],
//                                   ),)),
//
//
//
//
//                             shape: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
//                             backgroundColor: Colors.white,
//                             enableDrag: true,
//                           );
//                         } , icon: Icon(Icons.add))
//                     )
//                     // ElevatedButton(onPressed: (){
//                     //   // showDialog(
//                     //   //   context: context,
//                     //   //   builder: (BuildContext context) {
//                     //   //     return AlertDialog(
//                     //   //       title: new Text("Remark"),
//                     //   //       content:
//                     //   //       Padding(
//                     //   //         padding: const EdgeInsets.all(12.0),
//                     //   //         child: TextField(
//                     //   //           autofocus: false,
//                     //   //           decoration: InputDecoration(
//                     //   //               labelText: 'Add Your Remark',
//                     //   //               prefixIcon: Icon(Icons.person)),
//                     //   //           controller: remarkEditingController,
//                     //   //         ),
//                     //   //       ),
//                     //   //
//                     //   //
//                     //   //       actions: <Widget>[
//                     //   //         new ElevatedButton(
//                     //   //           child: new Text("OK"),
//                     //   //           onPressed: () async{
//                     //   //
//                     //   //             // if(validateInputremark()){
//                     //   //             //   var conn = await Utilities.isInternetWorking();
//                     //   //             //   showDialog(
//                     //   //             //       barrierDismissible: false,
//                     //   //             //       context: context,
//                     //   //             //       builder: (context) {
//                     //   //             //         return CupertinoAlertDialog(
//                     //   //             //           title: Text('Please Wait'),
//                     //   //             //           content: Column(
//                     //   //             //             children: [
//                     //   //             //               Divider(),
//                     //   //             //               Padding(
//                     //   //             //                 padding: const EdgeInsets.all(8.0),
//                     //   //             //                 child: Text(conn
//                     //   //             //                     ? 'Registering your Remark'
//                     //   //             //                     : 'Saving offline'),
//                     //   //             //               ),
//                     //   //             //               CupertinoActivityIndicator(
//                     //   //             //                 radius: 17,
//                     //   //             //               )
//                     //   //             //             ],
//                     //   //             //           ),
//                     //   //             //         );
//                     //   //             //       });
//                     //   //             //   var sales = Sales(
//                     //   //             //       remark: remarkEditingController.text ,
//                     //   //             //       outletId: _selectedIndex.toString()
//                     //   //             //   );
//                     //   //             //
//                     //   //             //   if (conn) {
//                     //   //             //     var response = await sellProductApi(sales);
//                     //   //             //     Get.back();
//                     //   //             //
//                     //   //             //     Utilities.showInToast(response.message,
//                     //   //             //         toastType: response.success
//                     //   //             //             ? ToastType.SUCCESS
//                     //   //             //             : ToastType.ERROR);
//                     //   //             //
//                     //   //             //     if (response.success) {
//                     //   //             //
//                     //   //             //       Get.back();
//                     //   //             //     }
//                     //   //             //   } else {
//                     //   //             //     Get.back();
//                     //   //             //
//                     //   //             //
//                     //   //             //
//                     //   //             //   }
//                     //   //             //
//                     //   //             //   Get.find<ProductsController>().addremark(sales);
//                     //   //             //   Get.back();
//                     //   //             // } else {
//                     //   //             //   Utilities.showInToast('Please complete the form',
//                     //   //             //       toastType: ToastType.ERROR);
//                     //   //             // }
//                     //   //           },
//                     //   //         ),
//                     //   //       ],
//                     //   //     );
//                     //   //   },
//                     //   // );
//                     //   // print( Get.find<OutletsController>()
//                     //   //     .outletList.length
//                     //   //    );
//                     //   //print(Get.find<Routecontroller>().routeList.length);
//                     //   //print(Get.find<ChannelController>().channelList.length);
//                     //
//                     // }, child: Text("Press")),
//                   ],
//
//                 ),
//                 // SizedBox(
//                 //   width: Get.size.height * 1,
//                 // ),
//                 Divider(),
//                 Center(
//                   child: Text(
//
//                     outlet[index].name,
//                     style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold),
//                   ),
//                 ),
//
//                 // Padding(
//                 //   padding: const EdgeInsets.all(4.0),
//                 //   child: Row(
//                 //     mainAxisAlignment: MainAxisAlignment
//                 //         .start,
//                 //     children: [
//                 //       // Icon(
//                 //       //   Icons.person,
//                 //       //   size: 16,
//                 //       // ),
//                 //       SizedBox(
//                 //         width: 5,
//                 //       ),
//                 //       //   Image(image: item.image)
//                 //
//                 //     ],
//                 //   ),
//                 // ),
//                 // Divider(),
//                 // Padding(
//                 //   padding: const EdgeInsets.all(4.0),
//                 //   child: Row(
//                 //     mainAxisAlignment: MainAxisAlignment
//                 //         .start,
//                 //     children: [
//                 //       // Icon(
//                 //       //   Icons.person,
//                 //       //   size: 16,
//                 //       // ),
//                 //       SizedBox(
//                 //         width: 5,
//                 //       ),
//                 //       //Text(item.ownerName),
//                 //     ],
//                 //   ),
//                 // ),
//                 // Padding(
//                 //   padding: const EdgeInsets.all(4.0),
//                 //   child: Row(
//                 //     mainAxisAlignment: MainAxisAlignment
//                 //         .start,
//                 //     children: [
//                 //       Icon(
//                 //         Icons.phone,
//                 //         size: 16,
//                 //       ),
//                 //       SizedBox(
//                 //         width: 5,
//                 //       ),
//                 //       //Text(item.contact),
//                 //     ],
//                 //   ),
//                 // ),
//                 // Padding(
//                 //   padding: const EdgeInsets.all(4.0),
//                 //   child: Row(
//                 //     mainAxisAlignment: MainAxisAlignment
//                 //         .start,
//                 //     children: [
//                 //       Icon(
//                 //         Icons.location_on,
//                 //         size: 16,
//                 //       ),
//                 //       SizedBox(
//                 //         width: 5,
//                 //       ),
//                 //       // Expanded(
//                 //       //   child: Text(
//                 //       //     province +
//                 //       //         ", " +
//                 //       //         district +
//                 //       //         ", " +
//                 //       //         area +
//                 //       //         ", " +
//                 //       //         (item.street ?? ""),
//                 //       //     overflow: TextOverflow.visible,
//                 //       //     style: TextStyle(fontSize: 12),
//                 //       //   ),
//                 //       // ),
//                 //     ],
//                 //   ),
//                 // ),
//                 // Padding(
//                 //   padding: const EdgeInsets.all(4.0),
//                 //   child: Row(
//                 //     mainAxisAlignment: MainAxisAlignment
//                 //         .start,
//                 //     children: [
//                 //       Icon(
//                 //         Icons.category,
//                 //         size: 16,
//                 //       ),
//                 //       SizedBox(
//                 //         width: 5,
//                 //       ),
//                 //       //Text(item.type),
//                 //     ],
//                 //   ),
//                 // ),
//                 MaterialButton(
//                   onPressed: () {
//                     Get.to(() =>
//                         SellProductPage(
//                           outlet: Get
//                               .find<OutletsController>()
//                               .outletList.first,
//                         ));
//
//                   },
//                   color: Colors.green[900],
//                   minWidth: Get.size.width,
//                   textColor: Colors.white,
//                   padding: EdgeInsets.all(10.0),
//                   child: Text("Sell Product"),
//                 ),
//               ],
//             ),
//
//           );},
//       );
//     }
//     Widget listSegment(List<Outlet> outList) {
//       return outList == null ? Text("NUll") :
//         ListView.builder(
//         itemCount:  outList.length  ,
//         itemBuilder: (context, index) {
//         //  var item =   outList[index];
//           return Obx(
//                 () =>
//                 // Padding(
//                 //   padding: EdgeInsets.all(5),
//                 //   child: Container(
//                 //     decoration: BoxDecoration(
//                 //         color: Color(( Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.3),
//                 //         border: Border.all(
//                 //             color: Color(( Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.5),
//                 //             width: 3
//                 //         ),
//                 //         borderRadius: BorderRadius.circular(20)
//                 //     ),
//                 //     height: Get.size.height * 0.1,
//                 //     width: Get.size.width ,
//
//                 //    child:
//
//               ListTile(
//                       onTap: () async {
//                         _selectedIndex.value = index;
//                      //   selectedOutlet.value = outList[index];
//                       //   Constants.selectedDistributor = outList[index];
//                       // //  selectedDistributor.value = distList[index];
//                       //   _selectedIndex.value = index;
//                       //   Get.find<OutletsController>().fetchOutlets();
//                       //   print(Constants.selectedDistributor);
//                       //   Get.find<PreferenceController>()
//                       //       .setDistributor(jsonEncode(Constants.selectedDistributor));
//                       //   Utilities.showInToast(
//                       //       "Distributor : ${selectedDistributor.value.name}");
//                       //   var distributor = Distributor(
//                       //       id:  Constants.selectedDistributor.id
//                       //   );
//                       //   //   Get.find<DistributorController>().addDistributorlet(distributor);
//                       //   var conn = await Utilities.isInternetWorking();
//                       //   if(conn){
//                       //     registerdistributor(distributor);
//                       //     print(distributor );
//                       //     //    _displayDialog(context);
//                       //     // if(response.success){
//                       //     //   distributor.synced = true;
//                       //     // }
//                       //   }
//                       //   //    //Get.back();
//                       //   // _displayDialog(context);
//                       //   //Constants.selectedDistributor.id
//                       //   print(Constants.selectedDistributor.id);
//                       },
//                 selected: index == _selectedIndex.value,
//                       title: Card(
//                         elevation: 7,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Row(
//                               mainAxisAlignment:  MainAxisAlignment.end,
//                               children: [
//
//                                 Padding(
//                                   padding: const EdgeInsets.only(right: 1),
//                                   child: Center(
//                                       child: CircleAvatar(
//                                         radius: (35),
//                                         backgroundColor:  outList[index] .synced
//                                             ? Colors.green
//                                             : Colors.grey,
//                                         child: Icon(
//                                           !outList [index].synced
//                                               ? Icons.cloud_off_outlined
//                                               : Icons.shopping_bag_outlined,
//                                           color: Colors.white,
//                                         ),
//                                       )),
//                                 ),
//                                 SizedBox(
//                                   width: Get.size.width * 0.3,
//                                 ),
//                                 CircleAvatar(
//                                     radius: (20),
//                                     backgroundColor:  outList[index] .synced
//                                         ? Colors.blueGrey
//                                         : Colors.grey,
//                                     child:  IconButton(onPressed:(){
//                                      showQuantityBottomSheet();
//                                   //     Get.bottomSheet(
//                                   //       // ListView.builder(itemCount: Get.find<OutletsController>().item?.length != null ? Get.find<OutletsController>().item?.length  : "",
//                                   //       //   itemBuilder: (context, index){
//                                   //       //     return
//                                   //             Container(
//                                   //               child: Padding(
//                                   //                 padding: const EdgeInsets.all(10.0),
//                                   //                 child: Column(
//                                   //                   mainAxisSize: MainAxisSize.min,
//                                   //                   children: [
//                                   //                     Padding(
//                                   //                         padding: const EdgeInsets.all(12.0),
//                                   //                         child:
//                                   //                         // DropdownButton(
//                                   //                         //
//                                   //                         //   // Initial Value
//                                   //                         //     value: selectedDrowpdown,
//                                   //                         //
//                                   //                         //     // Down Arrow Icon
//                                   //                         //     icon: const Icon(Icons.keyboard_arrow_down),
//                                   //                         //
//                                   //                         //     // Array list of items
//                                   //                         //     items: item.map((String items) {
//                                   //                         //       return DropdownMenuItem(
//                                   //                         //         value: items,
//                                   //                         //         child: Text(items),
//                                   //                         //       );
//                                   //                         //     }).toList(),
//                                   //                         // After selecting the desired option,it will
//                                   //                         // change button value to selected value
//                                   //                         // onChanged: (String newValue) {
//                                   //                         //   setState(() {
//                                   //                         //     selectedDrowpdown = newValue;
//                                   //                         //   });
//                                   //                         //                 DropdownButton(
//                                   //                         //                 hint: Text("Outlet Closed Image"), // Not necessary for Option 1
//                                   //                         //   value:selectedDrowpdown,
//                                   //                         //   onChanged: (newValue) {
//                                   //                         //     selectedDrowpdown = newValue;
//                                   //                         //   setState(() {
//                                   //                         //   selectedDrowpdown = newValue;
//                                   //                         // //  print(newValue);
//                                   //                         //   //print(selectedDrowpdown);
//                                   //                         //   });
//                                   //                         //   },
//                                   //                         //   items: item.map((location) {
//                                   //                         //   return DropdownMenuItem(
//                                   //                         //   child: new Text(location),
//                                   //                         //   value: location,
//                                   //                         //   );
//                                   //                         //   }).toList(),
//                                   //                         //   ),
//                                   //                         Padding(
//                                   //                           padding: const EdgeInsets.all(10.0),
//                                   //                           child: GetBuilder<OutletsController>(
//                                   //                             builder: (builder) {
//                                   //                               return Get.find<OutletsController>().item.length == null
//                                   //                                   ? SizedBox()
//                                   //                                   : InputDecorator(
//                                   //                                 decoration: decoration("Select Remark"),
//                                   //                                 child: ButtonTheme(
//                                   //                                   alignedDropdown: true,
//                                   //                                   child: DropdownButton<String>(
//                                   //                                     // iconEnabledCo
//                                   //                                     // iconDisabledColor: Colors.red,
//                                   //                                     isDense: true,
//                                   //                                     isExpanded: true,
//                                   //                                     hint: Text(
//                                   //                                         Get.find<OutletsController>().selectedDrowpdown),
//                                   //                                     items:
//                                   //                                     Get.find<OutletsController>().item.map((e) {
//                                   //                                       return DropdownMenuItem<String>(
//                                   //                                           value: e, child: Text(e));
//                                   //                                     }).toList(),
//                                   //                                     onChanged: (String district) {
//                                   //                                       setState(() {
//                                   //                                         Get.find<OutletsController>().selectedDrowpdown = district;
//                                   //                                         //  Get.find<OutletsController>().setitem(district );
//                                   //                                       });
//                                   //
//                                   //                                       // district = selectedDrowpdown;
//                                   //                                       print(Get.find<OutletsController>().selectedDrowpdown);
//                                   //                                       print(district);
//                                   //                                       //   print(Get.find<OutletsController>().setitem(district ));
//                                   //                                       //   district = Constants.item;
//                                   //                                       //      print(selectedDrowpdown);
//                                   //                                       //   district = Constants.selectedzone.zone;
//                                   //                                       // Get.find<AddressController>().getAreaList(district);
//                                   //                                     },
//                                   //                                   ),
//                                   //                                 ),
//                                   //                               );
//                                   //                             },
//                                   //                           ),
//                                   //                         )
//                                   //                       // DropdownButton<String>(
//                                   //                       //   hint: Text("Remark"),
//                                   //                       //   value:  selectedDrowpdown,
//                                   //                       //   items:
//                                   //                       //   //[for(var data in  Get.find<OutletsController>().item)])
//                                   //                       //   // [
//                                   //                       //   //   for (var data in Get.find<OutletsController>().item)
//                                   //                       //   //     DropdownMenuItem(
//                                   //                       //   //       child: new Text(
//                                   //                       //   //         data,
//                                   //                       //   //       ),
//                                   //                       //   //       value: data,
//                                   //                       //   //     )
//                                   //                       //   // ],
//                                   //                       //
//                                   //                       //   // Get.find<OutletsController>().item.map((e) {
//                                   //                       //   //   return DropdownMenuItem<String>(
//                                   //                       //   //           value: e,
//                                   //                       //   //           child: Text(e),
//                                   //                       //   //         );
//                                   //                       //   // }),
//                                   //                       //     item.map((  value) {
//                                   //                       //     return DropdownMenuItem<String>(
//                                   //                       //       value: value,
//                                   //                       //       child: Text(value),
//                                   //                       //     );
//                                   //                       //   }).toList(),
//                                   //                       //   onChanged: (newvalue) {
//                                   //                       //     setState(() {
//                                   //                       //      selectedDrowpdown = newvalue ;
//                                   //                       //     });
//                                   //                       //
//                                   //                       // //   Get.find<OutletsController>().setitem(newvalue);
//                                   //                       //
//                                   //                       //
//                                   //                       //    //_selectedvalue = newvalue;
//                                   //                       //   })
//                                   //                     ),
//                                   //
//                                   //                     SizedBox(height: Get.size.height * 0.01),
//                                   //                     Container(
//                                   //                       child: _imageFile == null
//                                   //                           ? Center(
//                                   //                         child: Text("No Image Selected"),
//                                   //                       )
//                                   //                           : Image.file(File(_imageFile.path)),
//                                   //                     ),
//                                   //                     ElevatedButton(
//                                   //                       onPressed: () async {
//                                   //                         // pickImage();
//                                   //                         if (Get.find<OutletsController>().selectedDrowpdown.isNotEmpty) {
//                                   //                           var conn = await Utilities.isInternetWorking();
//                                   //                           showDialog(
//                                   //                               barrierDismissible: false,
//                                   //                               context: context,
//                                   //                               builder: (context) {
//                                   //                                 return CupertinoAlertDialog(
//                                   //                                   title: Text('Please Wait'),
//                                   //                                   content: Column(
//                                   //                                     children: [
//                                   //                                       Divider(),
//                                   //                                       Padding(
//                                   //                                         padding: const EdgeInsets.all(8.0),
//                                   //                                         child: Text(conn
//                                   //                                             ? 'Registering new Sales Outlet'
//                                   //                                             : 'Saving offline'),
//                                   //                                       ),
//                                   //                                       CupertinoActivityIndicator(
//                                   //                                         radius: 17,
//                                   //                                       )
//                                   //                                     ],
//                                   //                                   ),
//                                   //                                 );
//                                   //                               });
//                                   //                           // var sales = Sales(
//                                   //                           //   //  outletId:  outletId,
//                                   //                           //     remark:  Get.find<OutletsController>().selectedDrowpdown
//                                   //                           // );
//                                   //                           // selectedoutlet.add({
//                                   //                           //   //"outlet_id": outletId,
//                                   //                           //
//                                   //                           //   "remark": selectedDrowpdown,
//                                   //                           //
//                                   //                           // });
//                                   //                           if (conn) {
//                                   //                             var response = await sellProductApi(sales);
//                                   //                             print(sales);
//                                   //                             // Get.back();
//                                   //                             Utilities.showInToast(response.message,
//                                   //                                 toastType: response.success
//                                   //                                     ? ToastType.SUCCESS
//                                   //                                     : ToastType.ERROR);
//                                   //
//                                   //                             //   if (response.success) {
//                                   //                             //     outlet.synced = true;
//                                   //                             //     Get.back();
//                                   //                             //   }
//                                   //                             // } else {
//                                   //                             //   Get.back();
//                                   //                             //   outlet.synced = false;
//                                   //                             //
//                                   //                             //   Utilities.showInToast('Storing Offline',
//                                   //                             //       toastType: ToastType.INFO);
//                                   //                             // }
//                                   //                             // await DatabaseHelper.instance
//                                   //                             //     .insertOutlet(outlet);
//                                   //                             // Get.find<ProductsController>().addremark(sales);
//                                   //                             Get.back();
//                                   //                           } else {
//                                   //                             Utilities.showInToast('Please complete the form',
//                                   //                                 toastType: ToastType.ERROR);
//                                   //                           }
//                                   //                           // if (selectedDrowpdown != null) {
//                                   //                           //   // selectedoutlet.add({
//                                   //                           //   //   //"outlet_id": outletId,
//                                   //                           //   //
//                                   //                           //   //   "remark": selectedDrowpdown,
//                                   //                           //   //
//                                   //                           //   // });
//                                   //                           //   sales.remark = jsonEncode(selectedoutlet);
//                                   //                           //   Get.find<OutletsController>().addoutletInList(outletId);
//                                   //                           //   //Get.find<ProductsController>().addremark(selectedoutlet);
//                                   //                           //   Utilities.showInToast("Remark Noted");
//                                   //                           //   print(selectedDrowpdown);
//                                   //                           // } else {
//                                   //                           //   Utilities.showInToast("Please add Remark");
//                                   //                           // }
//                                   //                           Get.back();}
//                                   //                       },
//                                   //                       child: Text("Add"),
//                                   //                     )
//                                   //                   ],
//                                   //                 ),
//                                   //               )),
//                                   //       shape: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
//                                   //       backgroundColor: Colors.white,
//                                   //       enableDrag: true,
//                                   //     );
//
//                                     } , icon: Icon(Icons.add))
//                                 )
//                                 // ElevatedButton(onPressed: (){
//                                 //   // showDialog(
//                                 //   //   context: context,
//                                 //   //   builder: (BuildContext context) {
//                                 //   //     return AlertDialog(
//                                 //   //       title: new Text("Remark"),
//                                 //   //       content:
//                                 //   //       Padding(
//                                 //   //         padding: const EdgeInsets.all(12.0),
//                                 //   //         child: TextField(
//                                 //   //           autofocus: false,
//                                 //   //           decoration: InputDecoration(
//                                 //   //               labelText: 'Add Your Remark',
//                                 //   //               prefixIcon: Icon(Icons.person)),
//                                 //   //           controller: remarkEditingController,
//                                 //   //         ),
//                                 //   //       ),
//                                 //   //
//                                 //   //
//                                 //   //       actions: <Widget>[
//                                 //   //         new ElevatedButton(
//                                 //   //           child: new Text("OK"),
//                                 //   //           onPressed: () async{
//                                 //   //
//                                 //   //             // if(validateInputremark()){
//                                 //   //             //   var conn = await Utilities.isInternetWorking();
//                                 //   //             //   showDialog(
//                                 //   //             //       barrierDismissible: false,
//                                 //   //             //       context: context,
//                                 //   //             //       builder: (context) {
//                                 //   //             //         return CupertinoAlertDialog(
//                                 //   //             //           title: Text('Please Wait'),
//                                 //   //             //           content: Column(
//                                 //   //             //             children: [
//                                 //   //             //               Divider(),
//                                 //   //             //               Padding(
//                                 //   //             //                 padding: const EdgeInsets.all(8.0),
//                                 //   //             //                 child: Text(conn
//                                 //   //             //                     ? 'Registering your Remark'
//                                 //   //             //                     : 'Saving offline'),
//                                 //   //             //               ),
//                                 //   //             //               CupertinoActivityIndicator(
//                                 //   //             //                 radius: 17,
//                                 //   //             //               )
//                                 //   //             //             ],
//                                 //   //             //           ),
//                                 //   //             //         );
//                                 //   //             //       });
//                                 //   //             //   var sales = Sales(
//                                 //   //             //       remark: remarkEditingController.text ,
//                                 //   //             //       outletId: _selectedIndex.toString()
//                                 //   //             //   );
//                                 //   //             //
//                                 //   //             //   if (conn) {
//                                 //   //             //     var response = await sellProductApi(sales);
//                                 //   //             //     Get.back();
//                                 //   //             //
//                                 //   //             //     Utilities.showInToast(response.message,
//                                 //   //             //         toastType: response.success
//                                 //   //             //             ? ToastType.SUCCESS
//                                 //   //             //             : ToastType.ERROR);
//                                 //   //             //
//                                 //   //             //     if (response.success) {
//                                 //   //             //
//                                 //   //             //       Get.back();
//                                 //   //             //     }
//                                 //   //             //   } else {
//                                 //   //             //     Get.back();
//                                 //   //             //
//                                 //   //             //
//                                 //   //             //
//                                 //   //             //   }
//                                 //   //             //
//                                 //   //             //   Get.find<ProductsController>().addremark(sales);
//                                 //   //             //   Get.back();
//                                 //   //             // } else {
//                                 //   //             //   Utilities.showInToast('Please complete the form',
//                                 //   //             //       toastType: ToastType.ERROR);
//                                 //   //             // }
//                                 //   //           },
//                                 //   //         ),
//                                 //   //       ],
//                                 //   //     );
//                                 //   //   },
//                                 //   // );
//                                 //   // print( Get.find<OutletsController>()
//                                 //   //     .outletList.length
//                                 //   //    );
//                                 //   //print(Get.find<Routecontroller>().routeList.length);
//                                 //   //print(Get.find<ChannelController>().channelList.length);
//                                 //
//                                 // }, child: Text("Press")),
//                               ],
//
//                             ),
//                             // SizedBox(
//                             //   width: Get.size.height * 1,
//                             // ),
//                             Divider(),
//                             Center(
//                               child: Text(
//
//                                 outList[index] .name,
//                                 style: TextStyle(
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                             ),
//
//                             // Padding(
//                             //   padding: const EdgeInsets.all(4.0),
//                             //   child: Row(
//                             //     mainAxisAlignment: MainAxisAlignment
//                             //         .start,
//                             //     children: [
//                             //       // Icon(
//                             //       //   Icons.person,
//                             //       //   size: 16,
//                             //       // ),
//                             //       SizedBox(
//                             //         width: 5,
//                             //       ),
//                             //       //   Image(image: item.image)
//                             //
//                             //     ],
//                             //   ),
//                             // ),
//                             // Divider(),
//                             // Padding(
//                             //   padding: const EdgeInsets.all(4.0),
//                             //   child: Row(
//                             //     mainAxisAlignment: MainAxisAlignment
//                             //         .start,
//                             //     children: [
//                             //       // Icon(
//                             //       //   Icons.person,
//                             //       //   size: 16,
//                             //       // ),
//                             //       SizedBox(
//                             //         width: 5,
//                             //       ),
//                             //       //Text(item.ownerName),
//                             //     ],
//                             //   ),
//                             // ),
//                             // Padding(
//                             //   padding: const EdgeInsets.all(4.0),
//                             //   child: Row(
//                             //     mainAxisAlignment: MainAxisAlignment
//                             //         .start,
//                             //     children: [
//                             //       Icon(
//                             //         Icons.phone,
//                             //         size: 16,
//                             //       ),
//                             //       SizedBox(
//                             //         width: 5,
//                             //       ),
//                             //       //Text(item.contact),
//                             //     ],
//                             //   ),
//                             // ),
//                             // Padding(
//                             //   padding: const EdgeInsets.all(4.0),
//                             //   child: Row(
//                             //     mainAxisAlignment: MainAxisAlignment
//                             //         .start,
//                             //     children: [
//                             //       Icon(
//                             //         Icons.location_on,
//                             //         size: 16,
//                             //       ),
//                             //       SizedBox(
//                             //         width: 5,
//                             //       ),
//                             //       // Expanded(
//                             //       //   child: Text(
//                             //       //     province +
//                             //       //         ", " +
//                             //       //         district +
//                             //       //         ", " +
//                             //       //         area +
//                             //       //         ", " +
//                             //       //         (item.street ?? ""),
//                             //       //     overflow: TextOverflow.visible,
//                             //       //     style: TextStyle(fontSize: 12),
//                             //       //   ),
//                             //       // ),
//                             //     ],
//                             //   ),
//                             // ),
//                             // Padding(
//                             //   padding: const EdgeInsets.all(4.0),
//                             //   child: Row(
//                             //     mainAxisAlignment: MainAxisAlignment
//                             //         .start,
//                             //     children: [
//                             //       Icon(
//                             //         Icons.category,
//                             //         size: 16,
//                             //       ),
//                             //       SizedBox(
//                             //         width: 5,
//                             //       ),
//                             //       //Text(item.type),
//                             //     ],
//                             //   ),
//                             // ),
//                             MaterialButton(
//                               onPressed: () {
//                                 Get.to(() =>
//                                     SellProductPage(
//                                       outlet: Get
//                                           .find<OutletsController>()
//                                           .outletList[index],
//                                     ));
//
//                               },
//                               color: Colors.green[900],
//                               minWidth: Get.size.width,
//                               textColor: Colors.white,
//                               padding: EdgeInsets.all(10.0),
//                               child: Text("Sell Product"),
//                             ),
//                           ],
//                         ),
//                       )
//           //             Card(
//           //               elevation: 7,
//           //               child: Column(
//           //                 crossAxisAlignment: CrossAxisAlignment.start,
//           //                 mainAxisSize: MainAxisSize.min,
//           //                 children: [
//           //                   Padding(
//           //                     padding: const EdgeInsets.all(8.0),
//           //                     child: Center(
//           //                         child: CircleAvatar(
//           //                           backgroundColor:  outList[index].synced
//           //                               ? Colors.green
//           //                               : Colors.grey,
//           //                           child: Icon(
//           //                             !outList[index].synced
//           //                                 ? Icons.cloud_off_outlined
//           //                                 : Icons.shopping_bag_outlined,
//           //                             color: Colors.white,
//           //                           ),
//           //                         )),
//           //                   ),
//           //                   Center(
//           //                     child: Text(
//           //
//           //                       outList[index].name,
//           //                       style: TextStyle(
//           //                           fontSize: 18,
//           //                           fontWeight: FontWeight.bold),
//           //                     ),
//           //                   ),
//           // ElevatedButton(onPressed: (){
//           //   showDialog(
//           //     context: context,
//           //     builder: (BuildContext context) {
//           //       return AlertDialog(
//           //         title: new Text("Remark"),
//           //         content:
//           //         Padding(
//           //           padding: const EdgeInsets.all(12.0),
//           //           child: TextField(
//           //             autofocus: false,
//           //             decoration: InputDecoration(
//           //                 labelText: 'Add Your Remark',
//           //                 prefixIcon: Icon(Icons.person)),
//           //             controller: remarkEditingController,
//           //           ),
//           //         ),
//           //
//           //         actions: <Widget>[
//           //           new ElevatedButton(
//           //             child: new Text("OK"),
//           //             onPressed: () async{
//           //
//           //               if(validateInputremark()){
//           //                 var conn = await Utilities.isInternetWorking();
//           //                 showDialog(
//           //                     barrierDismissible: false,
//           //                     context: context,
//           //                     builder: (context) {
//           //                       return CupertinoAlertDialog(
//           //                         title: Text('Please Wait'),
//           //                         content: Column(
//           //                           children: [
//           //                             Divider(),
//           //                             Padding(
//           //                               padding: const EdgeInsets.all(8.0),
//           //                               child: Text(conn
//           //                                   ? 'Registering your Remark'
//           //                                   : 'Saving offline'),
//           //                             ),
//           //                             CupertinoActivityIndicator(
//           //                               radius: 17,
//           //                             )
//           //                           ],
//           //                         ),
//           //                       );
//           //                     });
//           //                 var sales = Sales(
//           //                     remark: remarkEditingController.text[index],
//           //                     outletId: _selectedIndex.toString()
//           //                 );
//           //
//           //                 if (conn) {
//           //                   var response = await sellProductApi(sales);
//           //                   Get.back();
//           //
//           //                   Utilities.showInToast(response.message,
//           //                       toastType: response.success
//           //                           ? ToastType.SUCCESS
//           //                           : ToastType.ERROR);
//           //
//           //                   if (response.success) {
//           //
//           //                     Get.back();
//           //                   }
//           //                 } else {
//           //                   Get.back();
//           //
//           //
//           //
//           //                 }
//           //
//           //                 Get.find<ProductsController>().addremark(sales);
//           //                 Get.back();
//           //               } else {
//           //                 Utilities.showInToast('Please complete the form',
//           //                     toastType: ToastType.ERROR);
//           //               }
//           //             },
//           //           ),
//           //         ],
//           //       );
//           //     },
//           //   );
//           //       // print( Get.find<OutletsController>()
//           //       //     .outletList.length
//           //        //    );
//           //       //print(Get.find<Routecontroller>().routeList.length);
//           //       //print(Get.find<ChannelController>().channelList.length);
//           //   }, child: Text("Press")),
//           //                   // Padding(
//           //                   //   padding: const EdgeInsets.all(4.0),
//           //                   //   child: Row(
//           //                   //     mainAxisAlignment: MainAxisAlignment
//           //                   //         .start,
//           //                   //     children: [
//           //                   //       // Icon(
//           //                   //       //   Icons.person,
//           //                   //       //   size: 16,
//           //                   //       // ),
//           //                   //       SizedBox(
//           //                   //         width: 5,
//           //                   //       ),
//           //                   //       //   Image(image: item.image)
//           //                   //
//           //                   //     ],
//           //                   //   ),
//           //                   // ),
//           //                   // Divider(),
//           //                   // Padding(
//           //                   //   padding: const EdgeInsets.all(4.0),
//           //                   //   child: Row(
//           //                   //     mainAxisAlignment: MainAxisAlignment
//           //                   //         .start,
//           //                   //     children: [
//           //                   //       // Icon(
//           //                   //       //   Icons.person,
//           //                   //       //   size: 16,
//           //                   //       // ),
//           //                   //       SizedBox(
//           //                   //         width: 5,
//           //                   //       ),
//           //                   //       //Text(item.ownerName),
//           //                   //     ],
//           //                   //   ),
//           //                   // ),
//           //                   // Padding(
//           //                   //   padding: const EdgeInsets.all(4.0),
//           //                   //   child: Row(
//           //                   //     mainAxisAlignment: MainAxisAlignment
//           //                   //         .start,
//           //                   //     children: [
//           //                   //       Icon(
//           //                   //         Icons.phone,
//           //                   //         size: 16,
//           //                   //       ),
//           //                   //       SizedBox(
//           //                   //         width: 5,
//           //                   //       ),
//           //                   //       //Text(item.contact),
//           //                   //     ],
//           //                   //   ),
//           //                   // ),
//           //                   // Padding(
//           //                   //   padding: const EdgeInsets.all(4.0),
//           //                   //   child: Row(
//           //                   //     mainAxisAlignment: MainAxisAlignment
//           //                   //         .start,
//           //                   //     children: [
//           //                   //       Icon(
//           //                   //         Icons.location_on,
//           //                   //         size: 16,
//           //                   //       ),
//           //                   //       SizedBox(
//           //                   //         width: 5,
//           //                   //       ),
//           //                   //       // Expanded(
//           //                   //       //   child: Text(
//           //                   //       //     province +
//           //                   //       //         ", " +
//           //                   //       //         district +
//           //                   //       //         ", " +
//           //                   //       //         area +
//           //                   //       //         ", " +
//           //                   //       //         (item.street ?? ""),
//           //                   //       //     overflow: TextOverflow.visible,
//           //                   //       //     style: TextStyle(fontSize: 12),
//           //                   //       //   ),
//           //                   //       // ),
//           //                   //     ],
//           //                   //   ),
//           //                   // ),
//           //                   // Padding(
//           //                   //   padding: const EdgeInsets.all(4.0),
//           //                   //   child: Row(
//           //                   //     mainAxisAlignment: MainAxisAlignment
//           //                   //         .start,
//           //                   //     children: [
//           //                   //       Icon(
//           //                   //         Icons.category,
//           //                   //         size: 16,
//           //                   //       ),
//           //                   //       SizedBox(
//           //                   //         width: 5,
//           //                   //       ),
//           //                   //       //Text(item.type),
//           //                   //     ],
//           //                   //   ),
//           //                   // ),
//           //                   MaterialButton(
//           //                     onPressed: () {
//           //                       Get.to(() =>
//           //                           SellProductPage(
//           //                               outlet: Get
//           //                                   .find<OutletsController>()
//           //                                   .outletList[index],
//           //                           ));
//           //                     },
//           //                     color: Colors.green[900],
//           //                     minWidth: Get.size.width,
//           //                     textColor: Colors.white,
//           //                     padding: EdgeInsets.all(10.0),
//           //                     child: Text("Sell Product"),
//           //                   ),
//           //                 ],
//           //               ),
//           //             ),
//                       // Row(
//                       //   children: [
//                       //     Text(
//                       //       outList[index].name,
//                       //     ),
//                       //     Text(outList[index].name)
//                       //   ],
//                       // ),
//                     ),
//                   );
//
//         },
//       );
//     }
//
//     Widget _buildListViewWidget(List<Outlet> outletList) {
//       return ListView.builder(
//           shrinkWrap: true,
//           physics: NeverScrollableScrollPhysics(),
//           itemCount: outletList.length,
//           itemBuilder: (context, index) {
//             return buildMainTile(outletList
//             );
//           });
//     }
//     Widget outletList() {
//       return Expanded(
//         child: GetBuilder<OutletsController>(
//           init: OutletsController(),
//           builder: (controller) {
//             return controller.searchList.isNotEmpty
//                 ? listSegment(controller.searchList)
//                 : controller.outletList != null
//                 ? controller.outletList.isEmpty
//                 ? Center(child: Text("No Routes"))
//                 : listSegment(controller.outletList)
//                 : Center(
//               child: CircularProgressIndicator(),
//             );
//           },
//         ),
//       );
//     }
//     // Widget outletlist(){
//     //   return Expanded(child: GetBuilder<OutletsController>(
//     //     init: OutletsController(),
//     //     builder: (outletcontroller){
//     //       return outletcontroller.searchList.isNotEmpty
//     //           ? listoutlet(outletcontroller.searchList) :
//     //       outletcontroller.outletList != null
//     //           ? outletcontroller.outletList.isEmpty
//     //           ? Center(child: Text("No route")): listoutlet(outletcontroller.outletList )
//     //           : Center(child: CircularProgressIndicator(),);
//     //     },
//     //
//     //   ));
//     // }
//
//
//
//
//
//     return Scaffold(
//         floatingActionButton: FloatingActionButton.extended(
//           label: Row(
//             children: [
//               Icon(Icons.sync),
//               Text("Sync Outlets"),
//             ],
//           ),
//           onPressed: () async {
//             print(Get
//                 .find<OutletsController>()
//                 .outletList.length);
//             // if (_lock) return;
//             // var conn = await Utilities.isInternetWorking();
//             // if (conn) {
//             //   Utilities.showInToast('Syncing Data', toastType: ToastType.INFO);
//             //   await Get.find<OutletsController>().syncData();
//             //   print(Get.find<OutletsController>().syncData());
//             //   Utilities.showInToast('Syncing Success',
//             //       toastType: ToastType.SUCCESS);
//             //
//             //   _lock = false;
//             // } else {
//             //   Utilities.showInToast('No internet services!',
//             //       toastType: ToastType.INFO);
//             // }
//           },
//         ),
//
//         appBar: AppBar(
//           title: Text('Outlets'),
//         ),
//         body:
//
//             GetBuilder<OutletsController>(
//               builder: (outletController)
//     {
//       return Get
//           .find<OutletsController>()
//           .outletList
//           .isEmpty
//           ? Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // GestureDetector(
//             //   child: TextField(
//             //     controller: textEditingController,
//             //     decoration: InputDecoration(
//             //       border: OutlineInputBorder(
//             //         borderSide: BorderSide(
//             //           color: Colors.red, //this has no effect
//             //         ),
//             //         borderRadius: BorderRadius.circular(10.0),
//             //       ),
//             //       hintText: "Search Distributor...",
//             //     ),
//             //     onChanged: (text) {
//             //       Get.find<OutletsController>().searchOutlets(text);
//             //       // Get.find<Distributor_Route_Controller>().addDistributorlet(distributorList());
//             //     },
//             //   ),
//             //   onTap: () {},
//             // ),
//             Text("Distributor: " +
//                 Constants.selectedRoute.routename.toString()),
//             Text("No outlet found for selected distributor"),
//           ],
//         ),
//       )
//           : Scrollbar(
//         isAlwaysShown: true,
//         interactive: true,
//         thickness: 6.0,
//         child:  Get.find<OutletsController>().outletList == null
//             ? Center(
//           child: CircularProgressIndicator(),
//         ):  Column(
//           children: [
//             GestureDetector(
//               child: TextField(
//                 controller: textEditingController,
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(
//                     borderSide: BorderSide(
//                       color: Colors.red, //this has no effect
//                     ),
//                     borderRadius: BorderRadius.circular(10.0),
//                   ),
//                   hintText: "Search Distributor...",
//                 ),
//                 onChanged: (text) {
//                   Get.find<OutletsController>().searchOutlets(text);
//                   // Get.to((text) =>
//                   //     SellProductPage(
//                   //         outlet: Get
//                   //             .find<OutletsController>()
//                   //             .outletList[text]));
//     },
//
//
//               ),
//               onTap: (){
//             //    Get.to((text) =>
//                     // SellProductPage(
//                     //     outlet: Get
//                     //         .find<OutletsController>()
//                     //         .outletList[text]));
//               },
//             ),
//             // _buildListViewWidget(Get.find<OutletsController>()
//             //     .outletList)
//            // buildMainTile( Get.find<OutletsController>().outletList)
//             outletList()
//
//           ],
//         ),
//         //outletlist()
//
//       );
//     }
//     )
//     );}}