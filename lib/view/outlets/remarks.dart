
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobitrack_dv_flutter/controller/location_controller.dart';
import 'package:mobitrack_dv_flutter/controller/products_controller.dart';
import 'package:mobitrack_dv_flutter/model/products.dart';
import 'package:mobitrack_dv_flutter/utils/constants.dart';
import 'package:mobitrack_dv_flutter/view/outlets/view_outlets.dart';
import 'package:mobitrack_dv_flutter/view/products/brandwiseproduct.dart';

import '../../model/outlet.dart';
import '../../utils/utilities.dart';


class Remark extends StatefulWidget{
 //  Product product;
  final Outlet? outlet;
   const Remark({Key? key ,@required this.outlet}) : super(key: key);
   // Remark({this.product,this.outlet});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Remarks( );
  }

}
class Remarks extends State<Remark>{

  // final Outlet outlet;
  // Remarks({this.outlet});
 // List<String> item = ['Outlet Closed Image ', 'Stock Availabe Image','Owner not in shop', 'margin Issue', 'Credit limit Issue',];
  String _remark = Remarktype.closed_outlet;

  dynamic _type  ;
  var selectedProductList = [].obs;
  String? base64Image;

  LocationPermission? permission;
  XFile? _imageFile;
  final ImagePicker _picker = ImagePicker();
  bool vechicles = true;

 // MediaQuery aksf = MA

  void pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 25,
      );
      if (pickedFile != null) {
        setState(() {
          _imageFile = pickedFile;

        });
        List<int> imageBytes = await pickedFile.readAsBytes();
        base64Image = base64Encode(imageBytes);

        print(base64Image);
      }
    } catch (e) {
      Utilities.showInToast(e.toString());
    }
  }
  bool validateInput(){
    return (_type  == 'Outlet Closed ' && base64Image!.isEmpty) || (_type == "Stock Availabe  " && base64Image!.isEmpty);
  }

  @override
  Widget build(BuildContext context) {

    //
    // Widget mycard(){
    //   return Container(
    //     width:  Get.size.width * 0.99,
    //     child: Card(
    //
    //       child: InkWell(
    //         onTap: (){},
    //         child: Container(
    //           width: double.infinity,
    //           padding: EdgeInsets.all(20),
    //           child: Row(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               Padding(
    //                 padding: const EdgeInsets.only(top: 8.0),
    //                 child:  Radio(
    //                   value: Remarktype.credit_limit,
    //                   groupValue: _type,
    //                   onChanged: (newValue) =>
    //                       setState(() => _type = newValue),
    //                   activeColor: Colors.red,
    //                 ),
    //               ),
    //               Padding(
    //                 padding: const EdgeInsets.only(top: 8.0),
    //                 child:       Text(Remarktype.closed_outlet,),
    //               ),
    //               Padding(
    //                 padding: EdgeInsets.symmetric(
    //                     horizontal: 10.0, vertical: 5.0),
    //                 child: OutlinedButton(
    //
    //                   style: OutlinedButton.styleFrom(
    //                     minimumSize: Size.fromWidth(Get.size.width *0.1),
    //                   ),
    //                   onPressed: () {
    //                     pickImage();
    //                   },
    //                   child: Text("Select Image"),
    //                 ),
    //
    //               ),
    //
    //
    //             ],
    //           ),
    //         ),
    //       ),
    //     ),
    //   );
    // }
    // TODO: implement build

    Widget tes({String?
    text}){
      return Container(
        width: Get.size.width * 0.3,
        child: Text(text.toString()),
      );
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(onPressed: (){Get.back();}, icon: Icon(Icons.arrow_back,color: Colors.white,)),
         title: Text("Brands",style: TextStyle(color: Colors.white),),
      ),
      body:
          //   Column(
          //   children: [mycard()],
          // );
            Card(
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
            child: InkWell(
              onTap: () {},
                // OutletInfoPages(
                //   outlet : Get
                //         .find<OutletsController>()
                //         .outletList[index],
                // ));
               // BrandProductPage());
                // SellProductPage(
                //   outlet: Get
                //       .find<OutletsController>()
                //       .outletList[index],
                // ));
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child:
                ListView (
                  children: [
                   // Text(widget.outlet.name),
                    SizedBox(
                      height: 35,
                    ),
                    Container(
                        child: Column(
                children: [
                //   Column(
                //     children: [
                //                 Radio(
                //                   value: Remarktype.closed_outlet,
                //                   groupValue: _type,
                //                   onChanged: (newValue) =>
                //                       setState(() => _type = newValue),
                //                   activeColor: Colors.red,
                //                 ),
                //                // Text(Remarktype.closed_outlet,),
                //
                //
                //           Radio(
                //             value: Remarktype.owner_shop,
                //             groupValue: _type,
                //             onChanged: (newValue) =>
                //                 setState(() => _type = newValue),
                //             activeColor: Colors.red,
                //           ),
                //       Radio(
                //               value: Remarktype.owner_shop,
                //               groupValue: _type,
                //               onChanged: (newValue) =>
                //                   setState(() => _type = newValue),
                //               activeColor: Colors.red,),
                //         Radio(
                //                 value: Remarktype.margin_issue,
                //                 groupValue: _type,
                //                 onChanged: (newValue) =>
                //                     setState(() => _type = newValue),
                //                 activeColor: Colors.red,
                //               ),
                //       Radio(
                //                 value: Remarktype.credit_limit,
                //                 groupValue: _type,
                //                 onChanged: (newValue) =>
                //                     setState(() => _type = newValue),
                //                 activeColor: Colors.red,
                //               ),
                //
                //
                //           // Padding(
                //           //   padding: EdgeInsets.symmetric(
                //           //       horizontal: 20.0, vertical: 5.0),
                //           //   child: OutlinedButton(
                //           //     style: OutlinedButton.styleFrom(),
                //           //     onPressed: () {
                //           //       pickImage();
                //           //     },
                //           //     child: Text("Select Image"),
                //           //   ),
                //           // ),
                //     ],
                //   ),
                // Column(
                //   children: [
                //     Text(Remarktype.closed_outlet,),
                //     Text(Remarktype.owner_shop),
                //     Text(Remarktype.margin_issue),
                //     Text(Remarktype.credit_limit),
                //     Text( Remarktype.stock_avai),
                //   ],
                // )
                  Container(
                    child:      Row(
                      children: [
                        Radio(
                          value: Remarktype.closed_outlet,
                          groupValue: _type,
                          onChanged: (newValue) =>
                              setState(() => _type = newValue),
                          activeColor: Colors.red,
                        ),
                        //Text(Remarktype.closed_outlet,),
                        tes(text: Remarktype.closed_outlet),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 5.0, vertical: 5.0),
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(

                            ),
                            onPressed: () {
                              pickImage();
                            },
                            child: Text("Select Image"),
                          ),
                        ),
                      ],
                    ),
                  ),
                SizedBox(
                  width: 65,
                ),
                Row(
                  children: [
                    Radio(
                      value: Remarktype.owner_shop,
                      groupValue: _type,
                      onChanged: (newValue) =>
                          setState(() => _type = newValue),
                      activeColor: Colors.red,
                    ),
                    tes(text: Remarktype.owner_shop),
                   // Text(Remarktype.owner_shop),

                  ],
                ),
                  SizedBox(
                    width: 42,
                  ),

                  Row(
                    //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Radio(
                        value: Remarktype.margin_issue,
                        groupValue: _type,
                        onChanged: (newValue) =>
                            setState(() => _type = newValue),
                        activeColor: Colors.red,
                      ),
                      tes(text: Remarktype.margin_issue),
                      // Text( Remarktype.stock_avai),

                    ],
                  ),
                  SizedBox(
                    width: 42,
                  ),

                  Row(
                    //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Radio(
                        value: Remarktype.credit_limit,
                        groupValue: _type,
                        onChanged: (newValue) =>
                            setState(() => _type = newValue),
                        activeColor: Colors.red,
                      ),
                      tes(text: Remarktype.credit_limit),
                      // Text( Remarktype.stock_avai),

                    ],
                  ),
                  SizedBox(
                    width: 42,
                  ),

                  Row(
                  //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Radio(
                      value: Remarktype.stock_avai,
                      groupValue: _type,
                      onChanged: (newValue) =>
                          setState(() => _type = newValue),
                      activeColor: Colors.red,
                    ),
                    tes(text: Remarktype.stock_avai),
                   // Text( Remarktype.stock_avai),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 5.0, vertical: 5.0),
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(),
                        onPressed: () {
                          pickImage();
                        },
                        child: Text("Select Image"),
                      ),
                    ),
                  ],
                ),
                  SizedBox(
                    height: Get.height *0.1,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.black)),
                      onPressed: () async {

                      if( (_type == "Stock Availabe  " && base64Image == null) ){
                        Utilities.showInToast("Please select your Image");
                      }
                      else if((_type  == 'Outlet Closed ' && base64Image == null)){
                        Utilities.showInToast("Please select your Image");
                      }
                      else{
                          selectedProductList.add({
                            "product_id": "0",
                            "batch_id": "",
                            "quantity": "",
                            "discount": ""
                          });
                          var conn = await Utilities.isInternetWorking();
                          if (conn) {

                            // Test if location services are enabled.

                           bool serviceEnabled =
                            await Geolocator.isLocationServiceEnabled();
                            if (!serviceEnabled) {
                              return Utilities.showInToast(
                                  'Location services are disabled.',
                                  toastType: ToastType.ERROR);
                            }
                            // check for permission
                            permission = await Geolocator.checkPermission();
                            if (permission == LocationPermission.denied ||
                                permission ==
                                    LocationPermission.deniedForever) {
                              Utilities.showInToast(
                                  "Location permission is denied, Please enable permission for future use",
                                  toastType: ToastType.ERROR);
                              // request permission
                              permission = await Geolocator.requestPermission();
                              if (permission == LocationPermission.denied ||
                                  permission ==
                                      LocationPermission.deniedForever) {
                                // Permissions are denied,
                                return Utilities.showInToast(
                                    "Location permission is denied, Please enable permission for future use",
                                    toastType: ToastType.ERROR);
                              }
                            }



                           // print(item.Cost);
                            await Get.find<LocationController>()
                                .getCurrentPosition();
                            var location = Get.find<LocationController>() ;
                            if (location.userPosition != null) {
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
                                                ? 'Adding new Remark'
                                                : 'Saving offline'),
                                          ),
                                          CupertinoActivityIndicator(
                                            radius: 17,
                                          )
                                        ],
                                      ),
                                    );
                                  });
                              var location = Get.find<LocationController>().userPosition;
                              print(widget.outlet!.name!);
                              var remark = Sales(
                                route: Constants.selectedRoute.toString(),
                                soldAt:  DateTime.now().toString(),
                                outlet_name: widget.outlet!.name.toString(),
                                outletId: widget.outlet!.id.toString(),
                                orders:  jsonEncode(selectedProductList),
                                total_cost :"",
                                remark: _type,
                                latitude: location!.latitude.toString(),
                                longitude: location.longitude.toString(),
                                remark_image: base64Image,
                              );
                              print( location.latitude.toString());
                              print(location.longitude.toString());
                              print(remark);
                              var response = await sellProductApi(remark);
                              // Get.find<ProductsController>().storeSalesOffline(remark);
                              Constants.increase_unsucessfulcall ++;
                              print(remark);
                              Get.back();
                              //   Get.to(ViewOutletstPage());
                              Utilities.showInToast(response.message!,
                                  toastType: response.success!
                                      ? ToastType.SUCCESS
                                      : ToastType.ERROR);
                              Get.back();
                            } else {
                              Utilities.showInToast("Outlet Saved Sucessfully",
                                  toastType: ToastType.ERROR);
                            }
                          } else {
                            Utilities.showInToast(
                                "Could not get your location",
                                toastType: ToastType.ERROR);
                          }
                          // if(conn){
                          //   showDialog(
                          //       barrierDismissible: false,
                          //       context: context,
                          //       builder: (context) {
                          //         return CupertinoAlertDialog(
                          //           title: Text('Please Wait'),
                          //           content: Column(
                          //             children: [
                          //               Divider(),
                          //               Padding(
                          //                 padding: const EdgeInsets.all(8.0),
                          //                 child: Text(conn
                          //                     ? 'Adding new Remark'
                          //                     : 'Saving offline'),
                          //               ),
                          //               CupertinoActivityIndicator(
                          //                 radius: 17,
                          //               )
                          //             ],
                          //           ),
                          //         );
                          //       });
                          //   var location = Get.find<LocationController>().userPosition;
                          //   print(widget.outlet.name);
                          //   var remark = Sales(
                          //     route: Constants.selectedRoute.toString(),
                          //     soldAt:  DateTime.now().toString(),
                          //     outlet_name: widget.outlet.name.toString(),
                          //     outletId: widget.outlet.id.toString(),
                          //     orders:  jsonEncode(selectedProductList),
                          //     total_cost :"",
                          //     remark: _type,
                          //     latitude: location.latitude.toString(),
                          //     longitude: location.longitude.toString(),
                          //     remark_image: base64Image,
                          //   );
                          //   print( location.latitude.toString());
                          //   print(location.longitude.toString());
                          //   print(remark);
                          //   var response = await sellProductApi(remark);
                          //   // Get.find<ProductsController>().storeSalesOffline(remark);
                          //   Constants.increase_unsucessfulcall ++;
                          //   print(remark);
                          //   Get.back();
                          //   //   Get.to(ViewOutletstPage());
                          //   Utilities.showInToast(response.message,
                          //       toastType: response.success
                          //           ? ToastType.SUCCESS
                          //           : ToastType.ERROR);
                          //   Get.back();
                          // }else{
                          //   //  Get.find<ProductsController>().storeSalesOffline();
                          // }

                      }

                  }, child: Text("Submit"))
              ],
            ),
          ),
          ]),
                        // Column(
                        //   mainAxisAlignment: MainAxisAlignment.start,
                        //   children: [
                        //     Padding(  padding: const EdgeInsets.all(10.0),
                        //       child:   Column(
                        //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //           children: [
                        //             // new Text(
                        //             //   item[index],
                        //             //   style: new TextStyle(
                        //             //     fontSize: 16.0,
                        //             //   ),
                        //             // ),Q
                        //             // new Radio(
                        //             //   value: Remarktype.closed_outlet,
                        //             //   groupValue: _remark,
                        //             //   onChanged: (newvalue)=>
                        //             //   _remark = newvalue,
                        //             // ),
                        //             Row(
                        //                 children: <Widget>[
                        //                   Radio(
                        //                     value: Remarktype.closed_outlet,
                        //                     groupValue: _remark,
                        //                     onChanged: (newValue) {
                        //                       setState(() {
                        //                         _remark = newValue;
                        //                       });
                        //                     }
                        //                     ,
                        //                     activeColor: Colors.red,
                        //                   ),
                        //                   Text(Remarktype.closed_outlet),
                        //                   SizedBox(
                        //                     width: 42,
                        //                   ),
                        //                 ]
                        //             ),
                        //             Row(
                        //                 children: <Widget>[
                        //                   Radio(
                        //                     value: Remarktype.credit_limit,
                        //                     groupValue: _remark,
                        //                     onChanged: (newValue) {
                        //                       setState(() {
                        //                         _remark = newValue;
                        //                       });
                        //                     }
                        //                     ,
                        //                     activeColor: Colors.red,
                        //                   ),
                        //                   Text(Remarktype.credit_limit),
                        //                   SizedBox(
                        //                     width: 42,
                        //                   ),
                        //                 ]
                        //             ),
                        //             Row(
                        //                 children: <Widget>[
                        //                   Radio(
                        //                     value: Remarktype.margin_issue,
                        //                     groupValue: _remark,
                        //                     onChanged: (newValue) {
                        //                       setState(() {
                        //                         _remark = newValue;
                        //                       });
                        //                     }
                        //                     ,
                        //                     activeColor: Colors.red,
                        //                   ),
                        //                   Text(Remarktype.margin_issue),
                        //                   SizedBox(
                        //                     width: 42,
                        //                   ),
                        //                 ]
                        //             ),
                        //             Row(
                        //                 children: <Widget>[
                        //                   Radio(
                        //                     value: Remarktype.owner_shop,
                        //                     groupValue: _remark,
                        //                     onChanged: (newValue) {
                        //                       setState(() {
                        //                         _remark = newValue;
                        //                       });
                        //
                        //                     },
                        //
                        //                     activeColor: Colors.red,
                        //                   ),
                        //                   Text(Remarktype.owner_shop),
                        //                   SizedBox(
                        //                     width: 42,
                        //                   ),
                        //                 ]
                        //             ),
                        //             ElevatedButton(
                        //               onPressed: (){
                        //               },
                        //               child: Text("Submit"),
                        //             )
                        //           ]),
                        //       // Padding(  padding: const EdgeInsets.all(10.0),
                        //       //     child:   Row(
                        //       //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //       //         children: [
                        //       //           new Text(
                        //       //             'Owner not in shop',
                        //       //             style: new TextStyle(fontSize: 16.0),
                        //       //           ),
                        //       //         ]
                        //       //     )
                        //       //
                        //       // ),
                        //       // Padding(  padding: const EdgeInsets.all(10.0),
                        //       //     child:   Row(
                        //       //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //       //         children: [
                        //       //           new Text(
                        //       //             'margin Issue',
                        //       //             style: new TextStyle(fontSize: 16.0),
                        //       //           ),
                        //       //         ]
                        //       //     )
                        //       //
                        //       // ),
                        //       // Padding(  padding: const EdgeInsets.all(10.0),
                        //       //     child:   Row(
                        //       //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //       //         children: [
                        //       //           new Text(
                        //       //             'Credit limit Issue',
                        //       //             style: new TextStyle(fontSize: 16.0),
                        //       //           ),
                        //       //         ]
                        //       //     )
                        //       //
                        //       // ),
                        //     )],
                        // )

                  // itemCount: item.length,
                  // itemBuilder: (context, index){
                  //   return   Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     mainAxisSize: MainAxisSize.min,
                  //     children: [
                  //
                  //       // MaterialButton(
                  //       //   onPressed: () {
                  //       //     Get.to(() =>
                  //       //         SellProductPage(
                  //       //           outlet: Get
                  //       //               .find<OutletsController>()
                  //       //               .outletList[index],
                  //       //         ));
                  //       //
                  //       //   },
                  //       //   color: Colors.green[900],
                  //       //   minWidth: Get.size.width,
                  //       //   textColor: Colors.white,
                  //       //   padding: EdgeInsets.all(10.0),
                  //       //   child: Text("Sell Product"),
                  //       // ),
                  //
                  //     ],
                  //   );
                  // },
                ),
              ),
            )
          //   Column(
          //   children: [
          //   new Radio(
          //         value: 0,
          //         groupValue: null,
          //         onChanged: null,
          //       ),
          //       new Text(
          //         'Outlet Closed Image',
          //         style: new TextStyle(fontSize: 16.0),
          //       ),
          // new Text(
          //       'Stock Availabe Image',
          //       style: new TextStyle(
          //         fontSize: 16.0,
          //       ),
          //     ),
          // new Text(
          //       'Owner not in shop',
          //       style: new TextStyle(fontSize: 16.0),
          //     ),
          //         new Text(
          //           'margin Issue',
          //           style: new TextStyle(fontSize: 16.0),
          //         ),
          // new Text(
          //       'Credit limit Issue',
          //       style: new TextStyle(fontSize: 16.0),
          //     ),
          //   ],
          // );
          //   Row(
          //   children: [
          //     new Radio(
          //       value: 0,
          //       groupValue: null,
          //       onChanged: null,
          //     ),
          //     new Text(
          //       'Outlet Closed Image',
          //       style: new TextStyle(fontSize: 16.0),
          //     ),
          //     new Radio(
          //       value: 1,
          //       groupValue: null,
          //       onChanged: null,
          //     ),
          //     new Text(
          //       'Stock Availabe Image',
          //       style: new TextStyle(
          //         fontSize: 16.0,
          //       ),
          //     ),
          //     new Radio(
          //       value: 2,
          //       groupValue: null,
          //       onChanged: null,
          //     ),
          //     new Text(
          //       'Owner not in shop',
          //       style: new TextStyle(fontSize: 16.0),
          //     ),
          //     new Radio(
          //       value: 2,
          //       groupValue: null,
          //       onChanged: null,
          //     ),
          //     new Text(
          //       'margin Issue',
          //       style: new TextStyle(fontSize: 16.0),
          //     ),
          //     new Radio(
          //       value: 2,
          //       groupValue: null,
          //       onChanged: null,
          //     ),
          //     new Text(
          //       'Credit limit Issue',
          //       style: new TextStyle(fontSize: 16.0),
          //     ),
          //   ],
          // );

    );
  }

}

// Outlet Closed Image
// Stock Availabe Image
// Owner not in shop
// margin Issue
// Credit limit Issue