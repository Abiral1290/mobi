import 'dart:convert';

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:mobitrack_dv_flutter/controller/database_controller.dart';
import 'package:mobitrack_dv_flutter/controller/location_controller.dart';
import 'package:mobitrack_dv_flutter/controller/outlets_controller.dart';
import 'package:mobitrack_dv_flutter/model/outlet_post.dart';
import 'package:mobitrack_dv_flutter/utils/api_urls.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import '../../controller/TownController.dart';
import '../../controller/auth_controller.dart';
import '../../controller/categories_controller.dart';
import '../../controller/channelController.dart';
import '../../model/outlet.dart';
import '../../utils/constants.dart';
import '../../utils/utilities.dart';
import '../products/brandwiseproduct.dart';

class OutletInfoPages extends StatefulWidget{

  final Outlet? outlet;
  OutletInfoPages({Key? key, this.outlet}): super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return OutletInfoPage();
  }

}
class OutletInfoPage extends State<OutletInfoPages>{



  int? id;
  final TextEditingController _nameCntrl = new TextEditingController();
  final TextEditingController _ownerCntrl = new TextEditingController();
  final TextEditingController _phoneCntrl = new TextEditingController();
  String? base64Image;
  XFile? _imageFile;
  final ImagePicker _picker = ImagePicker();
  bool edit = false;
  String? visit_frequency;
  double? width  ;
  DatabaseHelper? databaseHelper;
    GoogleMapController? mapController;

    LatLng _center = const LatLng(27.7172, 85.3240);
   Location? _location  ;
  final Set<Marker> markers = new Set(); //markers for google map
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    _location!.onLocationChanged.listen((l) {
      mapController!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude!, l.longitude!), zoom: 20),
        ),
      );
    });
  }

  // OutletInfoPages({@required this.outlet});
  @override
  Widget build(BuildContext context) {

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

    bool validateInput() {
      return _nameCntrl.text.isNotEmpty &&

          _ownerCntrl.text.isNotEmpty &&

          _phoneCntrl.text.isNotEmpty &&
          _phoneCntrl.text.length == 10 ;
          //&&
          //_imageFile != null;
      //&&
      // &&
      //     Constants.selectedroute.route_name.isNotEmpty &&
      //      Constants.selectedtown.town.isNotEmpty &&
      // Constants.selectedcategory.category.isNotEmpty &&
      //Constants.selectedchannel.channel.isNotEmpty;
      // _townCntrl.value.text.isNotEmpty &&
      // _routeCntrl.value.text.isNotEmpty &&
      // _channelCntrl.value.text.isNotEmpty ;
      //&&
      // _categoryCntrl.value.text.isNotEmpty;
      //&&
      //  _visitfrequencyCntrl.value.text.isNotEmpty ;
      //&&
      // isProvinceSelected;
      //&&
      // _imageFile != null;
    }

    Widget textfield( ){
      return TextField(
        controller: null,

      );
    }
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(onPressed: (){
          Get.back();
        }, icon: Icon( Icons.arrow_back,
          color: Colors.white,)
         ),
        actions:   [
          // Padding(
          //   padding: EdgeInsets.all(8.0),
          //   child: Icon(Icons.shield_moon,
          //       color: Colors.white),
          // ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: IconButton(onPressed: (){
              setState(() {
                edit = true;
                width = 250;
                textfield();
                id = widget.outlet!.id;
                base64Image = widget.outlet!.image;
                _nameCntrl.text =   widget.outlet!.name!;
                _ownerCntrl.text = widget.outlet!.ownerName!;
                _phoneCntrl.text = widget.outlet!.contact!;
              });
            }, icon: Icon(Icons.edit, color: Colors.white))
            //Icon(Icons.edit, color: Color.fromARGB(255, 34, 47, 53)),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child:IconButton(onPressed: (){
              setState(() {
            //   databaseHelper.deleteDatabase(path);
              });
            }, icon: Icon(Icons.more_vert, color: Colors.white))
         //   Icon(Icons.more_vert, color: Colors.white),
          ),
        ],
        title:   Padding(
          padding: EdgeInsets.all(8.0),
          child:
          edit == true ?TextField(
          //  style: TextStyle(color: Colors.white),
            controller: _nameCntrl,
            decoration: InputDecoration(
              fillColor: Colors.white, filled: true,
              focusColor: Colors.white,
              hintStyle: TextStyle(fontSize: 17),
              hintText:  widget.outlet!.name!,
             // suffixIcon: Icon(Icons.search),
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(20),
            ),
          ):
          Text(
            widget.outlet!.name!,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(

               // borderRadius: ,
                onTap: (){
                  pickImage();
                },
                child:   Container(

                  constraints: BoxConstraints.expand(
                    height:
                    (Theme.of(context).textTheme.headline4?.fontSize!)! * 1.1 +
                        250.0,
                  ),
                  padding: const EdgeInsets.all(8.0),
                  color: Colors.white,
                  alignment: Alignment.center,
                  child:_imageFile == null
                      ?
                  Image.network(
                      ApiUrls.baseurl+Get.find<OutletsController>().image.toString()
                  )
                      : Image.file(File(_imageFile!.path)),
                  // const Icon(
                  //   Icons.cloud_download_sharp,
                  //   size: 100,
                  //   color: Colors.blue,
                  // ),
                ),
              ),
            ),
            // AnimatedContainer (
            //   duration: Duration (seconds: 1),
            //   width: width,
            //   height: 40,
            //   color: Colors.red,
            //
            // ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  side: BorderSide(color: Colors.black)
                ),
                color: Colors.white,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children:   [
                    // edit == true ?  Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: TextField(
                    //     autofocus: true,
                    //     //keyboardType: TextInputType.r,
                    //     maxLength: 10,
                    //  //   autofillHints: widget.outlet.ownerName ,
                    //     decoration: InputDecoration(
                    //       //    prefixText: '+977 - ',
                    //        // labelText:  widget.outlet.ownerName,
                    //         prefixIcon: Icon(Icons.phone)),
                    //     controller: null,
                    //   ),
                    // ) :
                    ListTile(
                      leading: Icon(
                        Icons.person,
                        size: Get.size.height *0.05,
                      ),
                      // title: Text(
                      //   outlet.name,
                      //   style: TextStyle(
                      //     fontSize: 15.0,
                      //     color: Color.fromARGB(255, 22, 21, 21),
                      //     fontWeight: FontWeight.w600,
                      //   ),
                      // ),
                      title: edit == true ?TextField(
                        controller: _ownerCntrl ,
                        decoration: InputDecoration(
                          hintStyle: TextStyle(fontSize: 17),
                          hintText: widget.outlet!.ownerName,
                       //   suffixIcon: Icon(Icons.search),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(20),
                        ),
                      ):
                      Text("${widget.outlet!.ownerName}",
                        style: TextStyle(
                        fontSize: 15.0,
                        color: Color.fromARGB(255, 22, 21, 21),
                        fontWeight: FontWeight.w600,
                      ),),
                    ),
                    // edit == true?     Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: TextField(
                    //     autofocus: false,
                    //     keyboardType: TextInputType.number,
                    //     maxLength: 10,
                    //     decoration: InputDecoration(
                    //     //    prefixText: '+977 - ',
                    //         labelText:  widget.outlet.contact,
                    //         prefixIcon: Icon(Icons.phone)),
                    //     controller: null,
                    //   ),
                    // ):
                    ListTile(
                      onTap: (){
                        UrlLauncher.launchUrl(Uri.parse("tel://${widget.outlet!.contact}"));
                     //   launchUrl(Uri.parse(widget.outlet.contact));
                      },
                      leading: Icon(
                        Icons.phone_android,
                        size: Get.size.height *0.05,
                      ),
                      title: edit == true ?
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          autofocus: false,
                          keyboardType: TextInputType.number,
                        //  maxLength: 10,
                          decoration: InputDecoration(
                              prefixText: '+977 - ',
                           //   labelText: "Phone",
                              hintText:  widget.outlet!.contact,
                            //  prefixIcon: Icon(Icons.phone)
                          ),
                          controller: _phoneCntrl,
                        ),
                      )
                      // TextField(
                      //   controller: _phoneCntrl,
                      //   decoration: InputDecoration(
                      //     hintStyle: TextStyle(fontSize: 17),
                      //     hintText:  widget.outlet.contact,
                      // //    suffixIcon: Icon(Icons.search),
                      //     border: InputBorder.none,
                      //     contentPadding: EdgeInsets.all(20),
                      //   ),
                      // )
                          :Text(
                       widget.outlet!.contact!,
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Color.fromARGB(255, 22, 21, 21),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    //  subtitle:  edit == true ?Text(""):Text("Contact Person"),
                    //  trailing: Icon(Icons.shield_moon),
                    ),
                    edit == true?
                    Padding(
                      padding:
                      EdgeInsets.symmetric(horizontal: 80, vertical: 5),
                      child: MaterialButton(
                        onPressed: () async {
                          FocusScope.of(context).unfocus(); //dismiss keyboard
                          if (validateInput()) {
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

                            //      print(Get.find<OutletsController>().outletList.first.town_id);

                            var outlet = OutletPost(
                              id: id == null ? DateTime.now().millisecondsSinceEpoch : id,
                              outletId:  DateTime.now().millisecondsSinceEpoch.toString() ,
                              contact: _phoneCntrl.text,
                              latitude:Get.find<LocationController>().userPosition!.longitude.toString(),
                              name: _nameCntrl.text,
                              ownerName: _ownerCntrl.text,
                              distributorId: '',
                              //Get.find<SalesReportController>().salesReportList.first.distributorId.toString(),
                              // distributer_id == null ? Get.find<AuthController().: distributer_id,
                              salesOfficer:  Get.find<AuthController>().user.id.toString(),
                              townId:
                              Get.find<TownController>().selectedtown== 0 ? Get.find<OutletsController>().outletList!.first.town_id:
                              Get.find<TownController>().selectedtown.toString(),

                              // Get.find<OutletsController>().outletList.first.town_id== null
                              //     ? Get.find<TownController>().selectedtown.toString(): Get.find<OutletsController>().outletList.first.town_id,
                              //    Get.find<TownController>().selectedtown,
                              //Constants.selectedRoute.id.toString(),
                              //  Get.find<TownController>().selectedtown,
                              //  : Get.find<TownController>().selectedZone,
                              channelId:
                              Get.find<ChannelController>().selectedid   == 0 ?Get.find<OutletsController>().outletList!.first.channel_id:
                              Get.find<ChannelController>().selectedid.toString(),
                              // Get.find<OutletsController>().outletList.first.channel_id== null ?
                              // Get.find<ChannelController>().selectedchannel.toString(): Get.find<OutletsController>().outletList.first.channel_id,
                              //Constants.selectedRoute.id.toString(),
                              //Get.find<ChannelController>().selectedchannel,
                              categoryId:
                              Get.find<CategoriesController>().selectedid.isEmpty ? Get.find<OutletsController>().outletList!.first.category_id:
                              Get.find<CategoriesController>().selectedid,
                              // Get.find<OutletsController>().outletList.first.category_id == null ?Get.find<CategoriesController>().selectedCategory :
                              // Get.find<OutletsController>().outletList.first.category_id ,
                              //Constants.selectedRoute.id.toString(),
                              routeId:
                              Constants.selectedRoute!.id.toString().isNotEmpty ?   Get.find<OutletsController>().outletList!.first.route_id:  Constants.selectedRoute!.id.toString(),
                              //   Constants.selectedRoute.id.toString() == null? Get.find<Routecontroller>().selectedroute : Constants.selectedRoute.id.toString() ,
                              //   //route  ,
                              //"1",
                              // Constants.selectedRoute.id.toString(),
                              //Constants.selectedRoute.id.toString(),
                              //   Get.find<Routecontroller>().selectedroute,
                             visitFrequency:
                             visit_frequency == null ? "Weekly": visit_frequency,
                              //image: base64Image,
                              // town: Get.find<TownController>().selectedtown,
                              //  zone:  zone,
                              // zone:  Constants.selectedzone.id.toString(),
                              // zon: Constants.selectedzone.id,
                              //   category: _categoryCntrl.text,
                              // visitfrequency: _selectedvalue,
                              //   type: _type,
                              longitude: Get.find<LocationController>().userPosition!.longitude.toString(),
                              image: base64Image,
                            );
                            if (conn) {
                              var response = await registerOutletPost(outlet);
                              print( Get.find<CategoriesController>().selectedid.toString());
                              // print(town);
                              // print(channel);
                              print( Get.find<CategoriesController>().selectedCategory);

                              // print( Get.find<TownController>().selectedtown);
                              // print( Get.find<Routecontroller>().selectedroute);
                              //  print(outlet.townId);
                              //       Get.find<TownController>().selectedtown
                              // await DatabaseHelper.instance
                              //     .insertOutlet(outlet);
                              //  Get.back();
                              Utilities.showInToast(response.message!,
                                  toastType: response.success!
                                      ? ToastType.SUCCESS
                                      : ToastType.ERROR);

                              if (response.success!) {
                                outlet.synced = true;
                                Get.back();
                              }
                            } else {
                              Get.back();
                              outlet.synced = false;
                              Utilities.showInToast('Storing Offline',
                                  toastType: ToastType.INFO);
                            }
                            // await DatabaseHelper.instance
                            //     .insertOutlet(outlet);
                            Get.find<OutletsController>().addOutlet(outlet);
                            Get.back();
                          } else {
                            Utilities.showInToast('Please complete the form',
                                toastType: ToastType.ERROR);
                          }
                        },
                        color: Colors.blue,
                        textColor: Colors.white,
                        child: Text('Submit'),
                      ),
                    )

                    // MaterialButton(onPressed: ()async{
                    //   if(validateInput()){
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
                    //     var outlet = OutletPost(
                    //       id: id == null ? DateTime.now().millisecondsSinceEpoch : id,
                    //       outletId:  DateTime.now().millisecondsSinceEpoch.toString() ,
                    //       contact: _phoneCntrl.text,
                    //    //   latitude:position.latitude.toString(),
                    //       name: _nameCntrl.text,
                    //       ownerName: _ownerCntrl.text,
                    //       distributorId: '',
                    //       salesOfficer:  Get.find<AuthController>().user.id.toString(),
                    //       townId:
                    //       Get.find<TownController>().selectedtown== 0 ? Get.find<OutletsController>().outletList.first.town_id:
                    //       Get.find<TownController>().selectedtown.toString(),
                    //       channelId:
                    //       Get.find<ChannelController>().selectedid   == 0 ?Get.find<OutletsController>().outletList.first.channel_id:
                    //       Get.find<ChannelController>().selectedid.toString(),
                    //       categoryId:
                    //       Get.find<CategoriesController>().selectedid.isEmpty ? Get.find<OutletsController>().outletList.first.category_id:
                    //       Get.find<CategoriesController>().selectedid,
                    //       routeId:
                    //       Constants.selectedRoute.id.toString() == null ?   Get.find<OutletsController>().outletList.first.route_id:  Constants.selectedRoute.id.toString(),
                    //       //   Constants.selectedRoute.id.toString() == null? Get.find<Routecontroller>().selectedroute : Constants.selectedRoute.id.toString() ,
                    //       //   //route  ,
                    //       //"1",
                    //       // Constants.selectedRoute.id.toString(),
                    //       //Constants.selectedRoute.id.toString(),
                    //       //   Get.find<Routecontroller>().selectedroute,
                    //     //  visitFrequency:
                    //       //visit_frequency == null ? "Weekly": visit_frequency,
                    //  //     image: base64Image,
                    //     );
                    //     if (conn) {
                    //       var response = await registerOutletPost(outlet);
                    //       print( Get.find<CategoriesController>().selectedid.toString());
                    //       // print(town);
                    //       // print(channel);
                    //       print( Get.find<CategoriesController>().selectedCategory);
                    //
                    //       // print( Get.find<TownController>().selectedtown);
                    //       // print( Get.find<Routecontroller>().selectedroute);
                    //       //  print(outlet.townId);
                    //       //       Get.find<TownController>().selectedtown
                    //       // await DatabaseHelper.instance
                    //       //     .insertOutlet(outlet);
                    //       //  Get.back();
                    //       Utilities.showInToast(response.message,
                    //           toastType: response.success
                    //               ? ToastType.SUCCESS
                    //               : ToastType.ERROR);
                    //
                    //       if (response.success) {
                    //         outlet.synced = true;
                    //         Get.back();
                    //       }
                    //     } else {
                    //       Get.back();
                    //       outlet.synced = false;
                    //       Utilities.showInToast('Storing Offline',
                    //           toastType: ToastType.INFO);
                    //     }
                    //
                    //   }
                    //
                    // },
                    //   color: Colors.blue,
                    //   textColor: Colors.white,
                    //   child: Text('Submit'),
                    // )
                        :
                    ListTile(
                      leading: Icon(
                        Icons.emoji_emotions,
                        size: Get.size.height *0.05,
                      ),
                      // title: Text(
                      //   outlet.name,
                      //   style: TextStyle(
                      //     fontSize: 15.0,
                      //     color: Color.fromARGB(255, 22, 21, 21),
                      //     fontWeight: FontWeight.w600,
                      //   ),
                      // ),
                       title:Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Text("Let's Order",
                             style: TextStyle(
                               fontSize: 15.0,
                               color: Color.fromARGB(255, 22, 21, 21),
                               fontWeight: FontWeight.w600,
                             ),),
                           IconButton(onPressed: (){ Get.to(() =>
                               BrandWiseProduct(outlet: widget.outlet!
                                 // Get
                                 //   .find<OutletsController>()
                                 //   .outletList[index])
                               ) );}, icon: Icon(Icons.arrow_forward,size: 25,),)
                         ],
                       )

                    ),
                    // ListTile(
                    //   onTap: (){
                    //     BrandWiseProduct(outlet: widget.outlet
                    //             // Get
                    //             //   .find<OutletsController>()
                    //             //   .outletList[index])
                    //     );
                    //   },
                    //   title: Text(
                    //     'Call History',
                    //     style: TextStyle(
                    //       fontSize: 15.0,
                    //       color: Color.fromARGB(255, 22, 21, 21),
                    //       fontWeight: FontWeight.w600,
                    //     ),
                    //   ),
                    //   trailing: Icon(Icons.arrow_forward_ios),
                    // ),
                    // Padding(
                    //   padding: EdgeInsets.all(8.0),
                    //   child: ListTile(
                    //     title: Text(
                    //       'Order History',
                    //       style: TextStyle(
                    //         fontSize: 15.0,
                    //         color: Color.fromARGB(255, 22, 21, 21),
                    //         fontWeight: FontWeight.w600,
                    //       ),
                    //     ),
                    //     trailing: Icon(Icons.arrow_forward_ios),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                height: 300,
                child: GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: _center,
                    zoom: 15.0,
                  ),
                  myLocationEnabled: true,
                  markers: getmarkers(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Set<Marker> getmarkers() {
    //markers to place on map
    setState(() {
      // markers.add(Marker(
      //   //add first marker
      //   markerId: MarkerId(_center.toString()),
      //   position: _center, //position of marker
      //   infoWindow: InfoWindow(
      //     //popup info
      //     title: 'Marker Title First ',
      //     snippet: 'My Custom Subtitle',
      //   ),
      //   icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      // ));
      // markers.add(Marker(
      //   //add second marker
      //   markerId: MarkerId(_center.toString()),
      //   position: LatLng(27.7099116, 85.3132343), //position of marker
      //   infoWindow: InfoWindow(
      //     //popup info
      //     title: 'Marker Title Second ',
      //     snippet: 'My Custom Subtitle',
      //   ),
      //   icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      // ));

      markers.add(Marker(
        //add third marker
        markerId: MarkerId(_center.toString()),
        position: LatLng(double.parse(widget.outlet!.latitude!), double.parse(widget.outlet!.longitude!)), //position of marker
        infoWindow: InfoWindow(
          //popup info
          title: widget.outlet!.name!,
          snippet:  widget.outlet!.contact!,
        ),
        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      ));

      //add more markers here
    });

    return markers;
  }
}
