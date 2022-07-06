import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:http/http.dart' as http;

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobitrack_dv_flutter/controller/TownController.dart';
import 'package:mobitrack_dv_flutter/controller/address_controller.dart';
import 'package:mobitrack_dv_flutter/controller/auth_controller.dart';
import 'package:mobitrack_dv_flutter/controller/categories_controller.dart';
import 'package:mobitrack_dv_flutter/controller/channelController.dart';
import 'package:mobitrack_dv_flutter/controller/database_controller.dart';
import 'package:mobitrack_dv_flutter/controller/distributed_controller.dart';
import 'package:mobitrack_dv_flutter/controller/location_controller.dart';
import 'package:mobitrack_dv_flutter/controller/outlets_controller.dart';
import 'package:mobitrack_dv_flutter/controller/sales_report_controller.dart';
import 'package:mobitrack_dv_flutter/model/distributer_outlet.dart';
import 'package:mobitrack_dv_flutter/model/distributor.dart';
import 'package:mobitrack_dv_flutter/model/latlang.dart';
import 'package:mobitrack_dv_flutter/model/outlet.dart';
import 'package:mobitrack_dv_flutter/model/outlet_post.dart';
import 'package:mobitrack_dv_flutter/model/resp.dart';
import 'package:mobitrack_dv_flutter/model/town.dart';
import 'package:mobitrack_dv_flutter/utils/constants.dart';
import 'package:mobitrack_dv_flutter/utils/utilities.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:mobitrack_dv_flutter/view/outlets/view_outlets.dart';
import 'package:mobitrack_dv_flutter/view/view_distributor.dart';

import '../../controller/preference_controller.dart';
import '../../controller/routes_controller.dart';
import '../../utils/api_urls.dart';
import 'package:flutter_native_image/flutter_native_image.dart';

class RegisterShopPage extends StatefulWidget {
  @override
  _RegisterShopPageState createState() => _RegisterShopPageState();
}
class _RegisterShopPageState extends State<RegisterShopPage> {
  final TextEditingController _nameCntrl = new TextEditingController();
  final TextEditingController _ownerCntrl = new TextEditingController();
  final TextEditingController _phoneCntrl = new TextEditingController();
  final TextEditingController _zoneCntrl = new TextEditingController();
  final TextEditingController _townCntrl = new TextEditingController();
  final TextEditingController _routeCntrl = new TextEditingController();
  final TextEditingController _channelCntrl = new TextEditingController();
  final TextEditingController _categoryCntrl = new TextEditingController();
  final TextEditingController _visitfrequencyCntrl = new TextEditingController();
  String _selectedvalue= "Weekly";

  var _streetCntrl = new TextEditingController().obs;
  var addresscon = Get.lazyPut<AddressController>(()=> AddressController());
  var routecontroller = Get.lazyPut(()=>Routecontroller());
  //var towncontroller = Get.lazyPut(()=>TownController());
  var categorycontroller = Get.lazyPut(()=>CategoriesController());
  var channelcontroller = Get.lazyPut(()=>ChannelController());
  var towncontroller = Get.lazyPut(()=>TownController());


  var provinceLists = Get.find<AddressController>().provinceList.obs;
  var zonelist = Get.find<AddressController>().zonelist.obs;
  //var outletlist=   Get.find<OutletsController>().outletList.obs;
  var outletlists = Get.lazyPut<OutletsController>(() => OutletsController());

  int id;
  String channel ;
  String category  ;
  String town;
  String route;
  String visit_frequency;
  String distributer_id;

  List<String> outlet = [];
  var _selctIndex = 0.obs;
  var sellecOutlet = Outletss().obs;

  List<Outlet> out;
  Completer<GoogleMapController> _controller = Completer();
  Map<String, Marker> markers = <String, Marker>{};

  final ImagePicker _picker = ImagePicker();

  XFile _imageFile;

  String _type = SellerType.mart; //dafault is mart
  String base64Image;
  var street = "".obs;
  bool isProvinceSelected = false;
  bool iszoneSelected = false;
  Position position;


  @override
  void initState() {
    // Get.find<AddressController>().districtList = [];
    // Get.find<AddressController>().areaList = [];
    Get.find<ChannelController>().channelList = [];
    Get.find<Routecontroller>().routeList = [];
    Get.find<CategoriesController>().categoriesList = [];
    Get.find<TownController>().townlist = [];
    determinePosition();
    super.initState();
  }

  determineStreet(double lat, double lng) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      street.value = placemarks[0].street;
      _streetCntrl.value.text = street.value;
      print("Place: " + placemarks[0].street);
    } catch (e) {
      Utilities.showInToast(
          "No address information found for supplied coordinates! Please manually write street address",
          toastType: ToastType.INFO);
    }
  }

  determinePosition() async {
    if (Get.find<LocationController>().userPosition == null) {
      position = await GeolocatorPlatform.instance.getCurrentPosition(
      );
    } else {
      position = Get.find<LocationController>().userPosition;
    }
    if (position != null) {
      determineStreet(position.latitude, position.longitude);
    }
  }
  bool validateInput() {
    return _nameCntrl.text.isNotEmpty &&
        _ownerCntrl.text.isNotEmpty &&
        _phoneCntrl.text.isNotEmpty &&
        _phoneCntrl.text.length == 10 &&
        _imageFile != null;
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
  // bool v(){
  //   return _ownerCntrl.text == Constants.selectid.ownerName;
  // }

  InputDecoration decoration(String label) {
    return InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      labelText: label,
    );
  }

  Future<File> customCompressed({
    File imagePathToCompress,
    quality = 90,
    percentage = 80,
  }) async {
    var path = await FlutterNativeImage.compressImage(
      imagePathToCompress.absolute.path,
      quality: 10,
      percentage: 10,
    );
    return path;
  }
  void pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 10,
      );
      if (pickedFile != null) {
        setState(() {
          _imageFile = pickedFile;
        });
       // List<int> imageBytes = await pickedFile.readAsBytes();
        File image = File(pickedFile.path);
        final sizeInKbBefore = image.lengthSync();
        log('before compressed $sizeInKbBefore kb');
        File compressedImage = await customCompressed(imagePathToCompress: image);
        final sizeInKb = compressedImage.lengthSync() / 1024;
        log('after compressed $sizeInKb kb');
        Uint8List bytes = image.readAsBytesSync();
       // String base64Image = base64Encode(bytes);
        base64Image = base64Encode(bytes);
        print(_imageFile );
        print(base64Image);
      }
    } catch (e) {
      Utilities.showInToast(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildProvinceDropdown() {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: GetBuilder<AddressController>(
          builder: (builder) {
            return Get.find<AddressController>().provinceList.isEmpty
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
                            Get.find<AddressController>().selectedProvince),
                        items:
                            Get.find<AddressController>().provinceList.map((e) {
                          return DropdownMenuItem<String>(
                              value: e, child: Text(e));
                        }).toList(),
                        onChanged: (province) {
                          isProvinceSelected = true;
                          Get.find<AddressController>()
                              .setSelectedProvince(province);
                          Get.find<AddressController>()
                              .getDistrictList(province);
                        },
                      ),
                    ),
                  );
          },
        ),
      );
    }

    Widget _buildchanelDropdown() {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: GetBuilder<ChannelController>(
          builder: (builder) {
            return Get.find<ChannelController>().channelList.isEmpty
                ? SizedBox()
                : InputDecorator(
              decoration: decoration("Select Channel"),
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButton<String>(
                  iconEnabledColor: Colors.green,
                  iconDisabledColor: Colors.red,
                  isDense: true,
                  isExpanded: true,
                  hint: Text(
                      Get.find<ChannelController>().selectedchannel),
                  items:
                  Get.find<ChannelController>().channelList.map((e) {
                    return DropdownMenuItem<String>(
                        value: e.channel.toString(), child: Text(e.channel.toString()));
                  }).toList(),
                  onChanged: (channel ) {
                    Get.find<ChannelController>().setSelectedTown(channel);
                  //  Get.find<ChannelController>().setSelectedTown(channel );
                //    channel = channel;
                //    channel =Constants.selectedchannel.channel;

                    // isProvinceSelected = true;
                    // Get.find<AddressController>()
                    //     .setSelectedProvince(province);
                    // Get.find<AddressController>()
                    //     .getDistrictList(province);
                  },
                ),
              ),
            );
          },
        ),
      );
    }
    Widget _buildrouteDropdown() {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: GetBuilder<Routecontroller>(
          builder: (builder) {
            return
              // Get.find<Routecontroller>().routess.isEmpty
              //   ? SizedBox()
               // :
            InputDecorator(
              decoration: decoration("Select Routes"),
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButton<String>(
                  iconEnabledColor: Colors.green,
                  iconDisabledColor: Colors.red,
                  isDense: true,
                  isExpanded: true,
                  // hint: Text(
                  //     Get.find<Routecontroller>().selectedchannel),
                  items:
                  Get.find<Routecontroller>().routeList.map((e) {
                    return DropdownMenuItem<String>(
                        value: e.routename.toString(), child: Text(e.routename.toString()));
                  }).toList(),
                  onChanged: (channel ) {
                   Get.find<Routecontroller>().setSelectedProvince(channel);
                    //  Get.find<ChannelController>().setSelectedTown(channel );
                    //    channel = channel;
                    //    channel =Constants.selectedchannel.channel;

                    // isProvinceSelected = true;
                    // Get.find<AddressController>()
                    //     .setSelectedProvince(province);
                    // Get.find<AddressController>()
                    //     .getDistrictList(province);
                  },
                ),
              ),
            );
          },
        ),
      );
    }

    var selectedroute = Outlet().obs;
    var _selectedInde_1 = 0.obs;

    Widget listroute(List<Outlet> routelist){
      return ListView.builder(itemBuilder: (context, index) {
        return Obx(
                () => ListTile(
                onTap: (){
                  Constants.selectedOutlets = routelist[index];
                  selectedroute.value = routelist[index];
                  Get.find<OutletsController>().fetchOutlets();
                  print(Constants.selectedDistributor);
                  Get.find<PreferenceController>()
                      .setDistributor(jsonEncode(Constants.selectedOutlets));
                  Utilities.showInToast(
                      "Distributor : ${selectedroute.value.name}");
                  Get.back();
                },
                selected: index == _selectedInde_1.value,
                title: Text(
                  routelist[index].name,
                )
            ))  ;
      });
    }

    // Widget routelist(){
    //   return Expanded(child: GetBuilder<OutletsController>(
    //     init: OutletsController(),
    //     builder: (outletcontroller){
    //       return outletcontroller.outletList.isNotEmpty
    //           ? listroute(outletcontroller.outletList) :
    //       outletcontroller.outletList != null
    //           ? outletcontroller.outletList.isEmpty
    //           ? Center(child: Text("No route")): listroute(outletcontroller.outletList ): Center(child: CircularProgressIndicator(),);
    //     },
    //   ));
    // }
    Widget _buildRoute() {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: GetBuilder<Routecontroller>(
          builder: (builder) {
            return Get.find<Routecontroller>().routess.isEmpty
                ? SizedBox()
                : InputDecorator(
              decoration: decoration("Select Route"),
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButton<String>(
                  iconEnabledColor: Colors.green,
                  iconDisabledColor: Colors.red,
                  isDense: true,
                  isExpanded: true,
                  hint: Text(
                      Get.find<Routecontroller>().routess.first.routename),
                  items:
                  Get.find<Routecontroller>().routess.map((e) {
                    return DropdownMenuItem<String>(
                        value: e.routename, child: Text(e.routename));
                  }).toList(),
                  onChanged: (route) {
                    Get.find<Routecontroller>().setSelectedProvince(route);
                    //route = route;
                //    route = Constants.selectedRoute.routename;
                   // isProvinceSelected = true;
                   // Get.find<AddressController>()
                   //     .setSelectedProvince(province);
                   // Get.find<AddressController>()
                   //     .getDistrictList(province);
                  },
                ),
              ),
            );
          },
        ),
      );
    }
    Widget _buildcategoryDropdown() {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: GetBuilder<CategoriesController>(
          builder: (builder) {
            return Get.find<CategoriesController>().categoriesList.isEmpty
                ? SizedBox()
                : InputDecorator(
              decoration: decoration("Select Category"),
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButton<String>(
                  // iconEnabledCo
                  // iconDisabledColor: Colors.red,
                  isDense: true,
                  isExpanded: true,
                  hint: Text(
                      Get.find<CategoriesController>().selectedCategory),
                  items:
                  Get.find<CategoriesController>().categoriesList.map((e) {
                    return DropdownMenuItem<String>(
                        value: e.category, child: Text(e.category));
                  }).toList(),
                  onChanged: (district) {
                  //  Get.find<CategoriesController>().selectedCategory.toString();
                   Get.find<CategoriesController>().setSelectedProvince(district );
                    district = category;
              //      district = Constants.selectedcategory.category;
                   // Get.find<AddressController>().getAreaList(district);
                  },
                ),
              ),
            );
          },
        ),
      );
    }
    Widget _buildzoneDropdown() {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: GetBuilder<CategoriesController>(
          builder: (builder) {
            return Get.find<CategoriesController>().categoriesList.isEmpty
                ? SizedBox()
                : InputDecorator(
              decoration: decoration("Select Categories"),
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButton<String>(
                  // iconEnabledCo
                  // iconDisabledColor: Colors.red,
                  isDense: true,
                  isExpanded: true,
                   hint: Text(
                       Get.find<CategoriesController>().selectedCategory
                   ),
                  items:
                  Get.find<CategoriesController>().categoriesList.map((e) {
                    return DropdownMenuItem<String>(
                        value: e.category, child: Text(e.category));
                  }).toList(),
                  onChanged: (district) {
                    Get.find<CategoriesController>().setSelectedProvince(district );
                //    district = category;
                 //   Get.find<TownController>().setSelectionZone(district );
                    // district = zone;
                  //   print(Constants.selectedzone.zone);s
                    // Get.find<AddressController>().getAreaList(district);
                  },
                ),
              ),
            );
          },
        ),
      );
    }
    // Widget _buildtownDropdown() {
    //   return Padding(
    //     padding: const EdgeInsets.all(10.0),
    //     child: GetBuilder<TownController>(
    //       builder: (builder) {
    //         return Get.find<TownController>().townlist.isEmpty
    //             ? SizedBox()
    //             : InputDecorator(
    //                 decoration: decoration("Select Town"),
    //                 child: ButtonTheme(
    //                   alignedDropdown: true,
    //                   child: DropdownButton<String>(
    //                     // iconEnabledColor: Colors.green,
    //                     // iconDisabledColor: Colors.red,
    //                     // isDense: true,å
    //                     // isExpanded: true,
    //                   //  hint: Text(Get.find<AddressController>().selectedArea),
    //                     items: Get.find<TownController>().townlist.map((e) {
    //                       return DropdownMenuItem<String>(
    //                           value: e.town , child: Text(e.town));
    //                     }).toList(),
    //                     onChanged: (town) {
    //                      // Get.find<TownController>().setSelectedTown(town);
    //                     },
    //                   ),
    //                 ),
    //               );
    //       },
    //     ),
    //   );
    // }
    Widget _buildtownDropdownss() {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: GetBuilder<TownController>(
          builder: (builder) {
            return Get.find<TownController>().townlist.isEmpty
                ? SizedBox()
                : InputDecorator(
              decoration: decoration("Select Town"),
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButton<String>(
                  iconEnabledColor: Colors.green,
                  iconDisabledColor: Colors.red,
                  isDense: true,
                  isExpanded: true,
                  hint: Text( Get.find<TownController>().selectedtowns),
                  items:
                  // item_town.map((e) {
                  //   return DropdownMenuItem<String>(
                  //     value: e, child: Text(e),
                  //   );
                  // }),
                  Get.find<TownController>().townlist.map((e) {
                    return DropdownMenuItem<String>(
                        value: e.town, child: Text(e.town));
                  }).toList(),
                  onChanged: (town) {
                    Get.find<TownController>().setSelectedTown(town);
                    //   town = town;
                    //town = Constants.selectedtown.town;
                    // Get.find<TownController>().setSelectedTown(town);
                  },
                ),
              ),
            );
          },
        ),
      );
    }
    Widget _buildtownDropdown() {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: GetBuilder<TownController>(
          builder: (builder) {
            return Get.find<TownController>().townlist.isEmpty
                ? SizedBox()
                : InputDecorator(
              decoration: decoration("Select Town"),
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButton<String>(
                  iconEnabledColor: Colors.green,
                  iconDisabledColor: Colors.red,
                  isDense: true,
                  isExpanded: true,
                    hint: Text( Get.find<TownController>().selectedtowns),
                  items:
                  // item_town.map((e) {
                  //   return DropdownMenuItem<String>(
                  //     value: e, child: Text(e),
                  //   );
                  // }),
                  Get.find<TownController>().townlist.map((e) {
                    return DropdownMenuItem<String>(
                        value: e.town, child: Text(e.town));
                  }).toList(),
                  onChanged: (town) {
                    Get.find<TownController>().setSelectedTown(town);
                 //   town = town;
                    //town = Constants.selectedtown.town;
                    // Get.find<TownController>().setSelectedTown(town);
                  },
                ),
              ),
            );
          },
        ),
      );
    }

    Widget buildMapContainer() {
      return Container(
        height: Get.size.height * 0.3 ,
        child: position == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : GoogleMap(
                initialCameraPosition: CameraPosition(
                    target: LatLng(position.latitude, position.longitude),
                    zoom: 16),
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                markers: Set<Marker>.of(markers.values),
                mapType: MapType.normal,
                zoomGesturesEnabled: true,
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
                  new Factory<OneSequenceGestureRecognizer>(
                    () => new EagerGestureRecognizer(),
                  ),
                ].toSet(),
                onLongPress: (LatLng latlng) {
                  print(latlng.latitude.toString() +
                      "," +
                      latlng.longitude.toString());
                  setState(() {
                    markers["outletMarker"] = Marker(
                      markerId: MarkerId("outletMarker"),
                      position: new LatLng(latlng.latitude, latlng.longitude),
                    );
                  });

                  position = Position(
                      longitude: latlng.longitude,
                      latitude: latlng.latitude,
                      timestamp: DateTime.now(),
                      accuracy: 0.0,
                      altitude: 0.0,
                      heading: 0.0,
                      speed: 0.0,
                      speedAccuracy: 0.0);
                  determineStreet(position.latitude, position.longitude);
                },
              ),
      );
    }
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('Register Sales Outlet'),
        ),
        body:
        GetBuilder<LocationController>(
          builder: (locationController) {
            return
              // Get.find<LocationController>().userPosition == null
              //   ? Center(
              //       child: Column(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         children: [
              //           Text("Please enable location"),
              //           CupertinoActivityIndicator(),
              //         ],
              //       )
              //     )
              //  :
                 ListView(
              shrinkWrap: true,
                      children: [
           //            DropdownButton(
           //  value: asd,
           //  onChanged: (String newValue) {
           //  setState(() {
           // asd = newValue;
           //  });
           //  },
           //  items: outlet.map((String items) {
           //  return DropdownMenuItem(
           //  value: items,
           //  child: asds(),
           //  );
           //  }).toList(),
           //  )
    //                         snapshot.data.map<DropdownMenuItem<String>>((value)=> new DropdownMenuItem<String>(child: Text(value["name"]),
    // value: value["name"],))

                        // DropdownButtonHideUnderline(
                        //   child: ButtonTheme(
                        //     alignedDropdown: true,
                        //     child: DropdownButton<String>(
                        //       value: _myCity,
                        //       iconSize: 30,
                        //       icon: (null),
                        //       style: TextStyle(
                        //         color: Colors.black54,
                        //         fontSize: 16,
                        //       ),
                        //       hint: Text('Route'),
                        //       onChanged: (String newValue) {
                        //         setState(() {
                        //           _myCity = newValue;
                        //           print(_myCity);
                        //         });
                        //       },
                        //       items: out.map((item) {
                        //         return new DropdownMenuItem(
                        //           child: new Text(item),
                        //           value: item.toString(),
                        //         );
                        //       })?.toList() ??
                        //           [],
                        //     ),
                        //   ),
                        // )
                        // TypeAheadField(
                        //     suggestionsCallback: UserApi.getUserSuggestionsa,
                        //
                        //     onSuggestionSelected: (Outlet suggestion){
                        //       _nameCntrl.text =  suggestion.name ;
                        //       final outlet = suggestion;
                        //       //outlet.name = this._nameCntrl.text;
                        //       ScaffoldMessenger.of(context)..removeCurrentSnackBar()..showSnackBar(SnackBar(content: Text("Selected ${outlet.name.toString()}"),));
                        //     },),
                        // Constants.selectedRoute == null ? TextField(
                        //     controller: _nameCntrl,
                        //     autofocus: false,
                        //     decoration: InputDecoration(
                        //         labelText: "Shop Name",
                        //         prefixIcon: Icon(Icons.shopping_bag_outlined)
                        //     )
                        // ):
                        TypeAheadFormField<Outlet>(
                          suggestionsCallback: UserApi.getUserSuggestionsa,
                          //     (element) async{
                          //   return await UserApi.getUserSuggestionsa(element);
                          //   element = Constants.selectid.salesOfficerId.toString();
                          // },
                          // getuserdata().then((value){
                          //   value = _myCity;
                          // }),
                          //  UserApis.getUserSuggestionsa().then((value) => null),
            //                  (val) {
            //             //   userApis.outss = val.toString() ;
            //                val = UserApis.fetchOutletsApiss.toString();
            // },
                          debounceDuration: Duration(milliseconds: 500),
                          textFieldConfiguration: TextFieldConfiguration(
                            controller: _nameCntrl,
                          autofocus: false,
                            decoration: InputDecoration(
                              labelText: "Shop Name",
                                prefixIcon: Icon(Icons.shopping_bag_outlined)
                            )
                          ),
                          onSuggestionSelected: (Outlet suggestion){
                            //_query();
                            id =suggestion.id ;
                            _nameCntrl.text =  suggestion.name ;
                           _ownerCntrl.text = suggestion.ownerName;
                           _phoneCntrl.text = suggestion.contact;
                           town = suggestion.route_id.toString() == null ? 1 : suggestion.route_id.toString();
                           channel = suggestion.channel_id.toString() == null ? 2 :suggestion.channel_id.toString();
                           category = suggestion.category_id.toString() == null ? 2 : suggestion.category_id.toString() ;
                           route = suggestion.route_id.toString() == null ? 2 : suggestion.route_id.toString();
                           visit_frequency = suggestion.visitfrequency.toString();
                           distributer_id = suggestion.distributorId;
                          },
                          itemBuilder: (context, suggestion){
                           // final outlet = suggestion;åßß
                            var item = suggestion.name;
                            return ListTile(
                              title: Text(suggestion.name  == null ? "No Product Found": suggestion.name.toString()),
                           //leading:  Text(sugesstion.image == null? Icon(Icons.circle).toString() : sugesstion.image),
                           //   subtitle: Text(outlet.ownerName),
                            );
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextField(
                            autofocus: false,
                            decoration: InputDecoration(
                                labelText: "Owner Name",
                                prefixIcon: Icon(Icons.person)),
                            controller: _ownerCntrl,
                          ),
                        ),
                       // _buildcategoryDropdown(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            autofocus: false,
                            keyboardType: TextInputType.number,
                            maxLength: 10,
                            decoration: InputDecoration(
                                prefixText: '+977 - ',
                                labelText: "Phone",
                                prefixIcon: Icon(Icons.phone)),
                            controller: _phoneCntrl,
                          ),
                        ),
                     //  _buildProvinceDropdown(),
                       // _buildDistrictDropdown(),
                        //_buildAreaDropdown(),
                       // _buildzone(),
                      //  _buildStreetDropdown(),
                      //   ElevatedButton(onPressed: (){
                      //
                      //
                      //       print( Get.find<OutletsController>()
                      //           .outletList.length
                      //            );
                      //       //print(Get.find<Routecontroller>().routeList.length);
                      //       //print(Get.find<ChannelController>().channelList.length);
                      //   }, child: Text("Press")),
                        // DropdownButtonHideUnderline(
                        //   child: ButtonTheme(
                        //     alignedDropdown: true,
                        //     child: DropdownButton<String>(
                        //       value: _myCity,
                        //       iconSize: 30,
                        //       icon: (null),
                        //       style: TextStyle(
                        //         color: Colors.black54,
                        //         fontSize: 16,
                        //       ),
                        //       hint: Text('Route'),
                        //       onChanged: (String newValue) {
                        //        Get.find<CategoriesController>().categoriesList.first.category  = newValue;
                        //       },
                        //       items: Get.find<CategoriesController>().categoriesList.map((item) {
                        //         return new DropdownMenuItem(
                        //           child: new Text(item.category),
                        //           value: item.toString(),
                        //         );
                        //       }).toList()
                        //
                        //     ),
                        //   ),
                        // ),
                       //  Constants.selectedRoute == null?
                       // _buildzoneDropdown(): SizedBox(),
                        Get.find<OutletsController>().outletList.isEmpty?
                        _buildtownDropdown() : SizedBox(),
                     //  _buildzoneDropdown(),
                        Get.find<OutletsController>().outletList.isEmpty?
            _buildzoneDropdown() : SizedBox(),
                        Get.find<OutletsController>().outletList.isEmpty?
                         _buildchanelDropdown() : SizedBox(),
                        Constants.selectedRoute == null?
                       _buildrouteDropdown() :SizedBox(),
                      // _buildtownDropdown(),
                        // Padding(
                        //   padding: const EdgeInsets.all(12.0),
                        //   child: TextField(
                        //     autofocus: false,
                        //     decoration: InputDecoration(
                        //         labelText: 'Zone',
                        //         prefixIcon: Icon(Icons.person)),
                        //     controller: _zoneCntrl,
                        //   ),
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.all(12.0),
                        //   child: TextField(
                        //     autofocus: false,
                        //     decoration: InputDecoration(
                        //         labelText: 'Town',
                        //         prefixIcon: Icon(Icons.person)),
                        //     controller: _townCntrl,
                        //   ),
                        // ),

                        //_buildtownDropdown(),
                        // Padding(
                        //   padding: const EdgeInsets.all(12.0),
                        //   child: TextField(
                        //     autofocus: false,
                        //     decoration: InputDecoration(
                        //         labelText: "Route",
                        //         // labelStyle: TextStyle(
                        //         //   color: Colors.black,
                        //         //   fontSize: 20
                        //         // ),
                        //         prefixIcon: Icon(Icons.route)),
                        //      controller:  _routeCntrl,
                        //     // onChanged: (String text){
                        //     //   text = Constants.selectedOutlets.route;
                        //     // },
                        //   ),
                        // ),

                        // Padding(
                        //   padding: const EdgeInsets.all(12.0),
                        //   child: TextField(
                        //     autofocus: false,
                        //     decoration: InputDecoration(
                        //         labelText: 'Channel',
                        //         prefixIcon: Icon(Icons.wifi_channel)),
                        //     controller: _channelCntrl ,
                        //   ),
                        // ),


                        // Padding(
                        //   padding: const EdgeInsets.all(12.0),
                        //   child: TextField(
                        //     autofocus: false,
                        //     decoration: InputDecoration(
                        //         labelText: 'Category',
                        //         prefixIcon: Icon(Icons.category)),
                        //     controller: _categoryCntrl ,
                        //   ),
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.all(12.0),
                        //   child:  DropdownButton<String>(
                        //     hint: Text("Visit Frequency"),
                        //     value: _selectedvalue,
                        //     items:  item.map((value) {
                        //       return DropdownMenuItem<String>(
                        //         value: value,
                        //         child: Text(value),
                        //       );
                        //     }).toList(),
                        //     onChanged: (newvalue) {
                        //         newvalue = _visitfrequencyCntrl.text;
                        //     },
                        //   ),
                        //   // TextField(
                        //   //   autofocus: false,
                        //   //   decoration: InputDecoration(
                        //   //       labelText: 'Visit Frequency',
                        //   //       prefixIcon: Icon(Icons.view_stream_outlined)),
                        //   //   controller: _visitfrequencyCntrl
                        //   // ),
                        // ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            autofocus: false,
                            decoration: InputDecoration(
                                labelText: 'Location',
                                prefixIcon: Icon(Icons.add_road)),
                            controller: _streetCntrl.value..text  ,
                          ),
                        ),
                        // Container(
                        //   padding: const EdgeInsets.all(12.0),
                        //   child: InputDecorator(
                        //     decoration: InputDecoration(
                        //       labelText: 'Shop Type',
                        //       border: OutlineInputBorder(
                        //         borderRadius: BorderRadius.circular(10.0),
                        //       ),
                        //     ),
                        //     child: Column(
                        //       children: [
                        //         Row(
                        //           children: <Widget>[
                        //             Radio(
                        //               value: SellerType.mart,
                        //               groupValue: _type,
                        //               onChanged: (newValue) =>
                        //                   setState(() => _type = newValue),
                        //               activeColor: Colors.red,
                        //             ),
                        //             Text(SellerType.mart),
                        //             SizedBox(
                        //               width: 65,
                        //             ),
                        //             Radio(
                        //               value: SellerType.wholeSeller,
                        //               groupValue: _type,
                        //               onChanged: (newValue) =>
                        //                   setState(() => _type = newValue),
                        //               activeColor: Colors.red,
                        //             ),
                        //             Text(SellerType.wholeSeller)
                        //           ],
                        //         ),
                        //         Row(
                        //           children: <Widget>[
                        //             Radio(
                        //               value: SellerType.retailer,
                        //               groupValue: _type,
                        //               onChanged: (newValue) =>
                        //                   setState(() => _type = newValue),
                        //               activeColor: Colors.red,
                        //             ),
                        //             Text(SellerType.retailer),
                        //             SizedBox(
                        //               width: 42,
                        //             ),
                        //             Radio(
                        //               value: SellerType.hawcker,
                        //               groupValue: _type,
                        //               onChanged: (newValue) =>
                        //                   setState(() => _type = newValue),
                        //               activeColor: Colors.red,
                        //             ),
                        //             Text(SellerType.hawcker)
                        //           ],
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        Container(
                          height: 100,
                          child: _imageFile == null
                              ? Center(
                            child: Text("No Image Selected"),
                          )
                              : Image.file(File(_imageFile.path)),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5.0),
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(),
                            onPressed: () {
                              pickImage();
                            },
                            child: Text("Select Image"),
                          ),
                        ),
                        // view on map
                        buildMapContainer(),
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
                                 latitude:position.latitude.toString(),
                                  name: _nameCntrl.text,
                                  ownerName: _ownerCntrl.text,
                           distributorId: '',
                           //Get.find<SalesReportController>().salesReportList.first.distributorId.toString(),
                          // distributer_id == null ? Get.find<AuthController().: distributer_id,
                               salesOfficer:  Get.find<AuthController>().user.id.toString(),
                               townId:
                               Get.find<TownController>().selectedtown== 0 ? Get.find<OutletsController>().outletList.first.town_id:
                               Get.find<TownController>().selectedtown.toString(),

                                // Get.find<OutletsController>().outletList.first.town_id== null
                                //     ? Get.find<TownController>().selectedtown.toString(): Get.find<OutletsController>().outletList.first.town_id,
                           //    Get.find<TownController>().selectedtown,
                               //Constants.selectedRoute.id.toString(),
                             //  Get.find<TownController>().selectedtown,
                              //  : Get.find<TownController>().selectedZone,
                                channelId:
                                Get.find<ChannelController>().selectedid   == 0 ?Get.find<OutletsController>().outletList.first.channel_id:
                                Get.find<ChannelController>().selectedid.toString(),
                                // Get.find<OutletsController>().outletList.first.channel_id== null ?
                                // Get.find<ChannelController>().selectedchannel.toString(): Get.find<OutletsController>().outletList.first.channel_id,
                                //Constants.selectedRoute.id.toString(),
                                //Get.find<ChannelController>().selectedchannel,
                                categoryId:
                                Get.find<CategoriesController>().selectedid.isEmpty ? Get.find<OutletsController>().outletList.first.category_id:
                                Get.find<CategoriesController>().selectedid,
                                // Get.find<OutletsController>().outletList.first.category_id == null ?Get.find<CategoriesController>().selectedCategory :
                                // Get.find<OutletsController>().outletList.first.category_id ,
                                //Constants.selectedRoute.id.toString(),
                                routeId:
                                Constants.selectedRoute.id.toString() == null ?   Get.find<OutletsController>().outletList.first.route_id:  Constants.selectedRoute.id.toString(),
                                //   Constants.selectedRoute.id.toString() == null? Get.find<Routecontroller>().selectedroute : Constants.selectedRoute.id.toString() ,
                             //   //route  ,
                                //"1",
                               // Constants.selectedRoute.id.toString(),
                                //Constants.selectedRoute.id.toString(),
                             //   Get.find<Routecontroller>().selectedroute,
                               visitFrequency:
                                visit_frequency == null ? "Weekly": visit_frequency,
                               image: base64Image,
                               // town: Get.find<TownController>().selectedtown,
                           //  zone:  zone,
                             // zone:  Constants.selectedzone.id.toString(),
                              // zon: Constants.selectedzone.id,
                               //   category: _categoryCntrl.text,
                                 // visitfrequency: _selectedvalue,
                               //   type: _type,
                                  longitude: position.longitude.toString(),
                                 // image: base64Image,
                                );
                                if (conn) {
                                  var response = await registerOutletPost(outlet);
                                  print( Get.find<CategoriesController>().selectedid.toString());
                                  print(town);
                                  print(channel);
                                   print( Get.find<CategoriesController>().selectedCategory);

                                  // print( Get.find<TownController>().selectedtown);
                                  // print( Get.find<Routecontroller>().selectedroute);
                                //  print(outlet.townId);
                           //       Get.find<TownController>().selectedtown
                                  // await DatabaseHelper.instance
                                  //     .insertOutlet(outlet);
                                //  Get.back();
                                  Utilities.showInToast(response.message,
                                      toastType: response.success
                                          ? ToastType.SUCCESS
                                          : ToastType.ERROR);

                                  if (response.success) {
                                   outlet.synced = true;
                                    Get.back();
                                  }
                                } else {
                                  Get.back();
                                 outlet.synced = false;
                                  Utilities.showInToast('Storing Offline',
                                      toastType: ToastType.INFO);
                                }
                                await DatabaseHelper.instance
                                    .insertOutlet(outlet);
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
                        ),
                        SizedBox(
                          height: Get.size.height * 0.02,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            "Warning: Please fill form if and only if you are in that shop.",
                            style: TextStyle(
                              color: Colors.red[900],
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Get.size.height * 0.02,
                        ),
                      ],
                    );

          },
        ),
      ),
    );
  }
  // List<Outletss> outs= [];
  // getuserdata( ) async{
  //   var response = await http.get(
  //     Uri.parse(ApiUrls.outlets),
  //   );
  //   // final  = List<dynamic>.from(Ambulances.ma)
  //   // Map<String, dynamic> jsondate = new Map<String, dynamic>.from(json.decode(response.body));
  //
  //   Map<String, dynamic> mapResponse = json.decode(response.body);
  //
  //   if (mapResponse["success"]) {
  //     final data = mapResponse["data"].cast<Map<String, dynamic>>();
  //     outs = await data
  //         .map<Outletss>((json) => Outletss.fromJson(json))
  //         .toList();
  //   }
  //   // foreach((u,d) in jsondate){
  //   //   Ambulances amb = Ambulances(d['deathvehicle_number'], u['fullname'], u['phone']);
  //   //   ambs.add(amb);
  //   //   print(ambs.length);
  //   // }
  //   print(outs.length);
  //   return outs;
  // }
  // List citiesList;


 // String cityInfoUrl =
    //  '';

}

// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';
// import 'dart:ui';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:mobitrack_dv_flutter/controller/address_controller.dart';
// import 'package:mobitrack_dv_flutter/controller/database_controller.dart';
// import 'package:mobitrack_dv_flutter/controller/location_controller.dart';
// import 'package:mobitrack_dv_flutter/controller/outlets_controller.dart';
// import 'package:mobitrack_dv_flutter/model/outlet.dart';
// import 'package:mobitrack_dv_flutter/utils/constants.dart';
// import 'package:mobitrack_dv_flutter/utils/utilities.dart';
// import 'package:geocoding/geocoding.dart';
//
// class RegisterShopPage extends StatefulWidget {
//   @override
//   _RegisterShopPageState createState() => _RegisterShopPageState();
// }
//
// class _RegisterShopPageState extends State<RegisterShopPage> {
//   final TextEditingController _nameCntrl = new TextEditingController();
//   final TextEditingController _ownerCntrl = new TextEditingController();
//   final TextEditingController _phoneCntrl = new TextEditingController();
//   var _streetCntrl = new TextEditingController().obs;
//
//  // var provinceLists = Get.find<AddressController>().provinceList.obs;
//
//   Completer<GoogleMapController> _controller = Completer();
//   Map<String, Marker> markers = <String, Marker>{};
//
//   final ImagePicker _picker = ImagePicker();
//
//   XFile _imageFile;
//
//   String _type = SellerType.mart; //dafault is mart
//   String base64Image;
//   var street = "".obs;
//   bool isProvinceSelected = false;
//
//   Position position;
//
//   @override
//   void initState() {
//   //  Get.find<AddressController>().districtList = [];
//    // Get.find<AddressController>().areaList = [];
//     determinePosition();
//     super.initState();
//   }
//
//   determineStreet(double lat, double lng) async {
//     try {
//       List<Placemark> placemarks =
//       await placemarkFromCoordinates(position.latitude, position.longitude);
//       street.value = placemarks[0].street;
//       _streetCntrl.value.text = street.value;
//       print("Place: " + placemarks[0].street);
//     } catch (e) {
//       Utilities.showInToast(
//           "No address information found for supplied coordinates! Please manually write street address",
//           toastType: ToastType.INFO);
//     }
//   }
//
//   determinePosition() async {
//     if (Get.find<LocationController>().userPosition == null) {
//       position = await GeolocatorPlatform.instance.getCurrentPosition(
//           );
//     } else {
//       position = Get.find<LocationController>().userPosition;
//     }
//     if (position != null) {
//       determineStreet(position.latitude, position.longitude);
//     }
//   }
//
//   bool validateInput() {
//     return _nameCntrl.text.isNotEmpty &&
//         _ownerCntrl.text.isNotEmpty &&
//         _phoneCntrl.text.isNotEmpty &&
//         _phoneCntrl.text.length == 10 ;
//     //&&
//         // _streetCntrl.value.text.isNotEmpty &&
//         // isProvinceSelected &&
//         // _imageFile != null;
//   }
//
//   InputDecoration decoration(String label) {
//     return InputDecoration(
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12.0),
//       ),
//       labelText: label,
//     );
//   }
//
//   void pickImage() async {
//     try {
//       final pickedFile = await _picker.pickImage(
//         source: ImageSource.camera,
//         imageQuality: 25,
//       );
//       if (pickedFile != null) {
//         setState(() {
//           _imageFile = pickedFile;
//         });
//         List<int> imageBytes = await pickedFile.readAsBytes();
//         base64Image = base64Encode(imageBytes);
//         print(base64Image);
//       }
//     } catch (e) {
//       Utilities.showInToast(e.message);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Widget _buildProvinceDropdown() {
//       return Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: GetBuilder<AddressController>(
//           builder: (builder) {
//             return Get.find<AddressController>().provinceList.isEmpty
//                 ? SizedBox()
//                 : InputDecorator(
//               decoration: decoration("Select Province"),
//               child: ButtonTheme(
//                 alignedDropdown: true,
//                 child: DropdownButton<String>(
//                   iconEnabledColor: Colors.green,
//                   iconDisabledColor: Colors.red,
//                   isDense: true,
//                   isExpanded: true,
//                   hint: Text(
//                       Get.find<AddressController>().selectedProvince),
//                   items:
//                   Get.find<AddressController>().provinceList.map((e) {
//                     return DropdownMenuItem<String>(
//                         value: e, child: Text(e));
//                   }).toList(),
//                   onChanged: (province) {
//                     isProvinceSelected = true;
//                     Get.find<AddressController>()
//                         .setSelectedProvince(province);
//                     Get.find<AddressController>()
//                         .getDistrictList(province);
//                   },
//                 ),
//               ),
//             );
//           },
//         ),
//       );
//     }
//
//     Widget _buildDistrictDropdown() {
//       return Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: GetBuilder<AddressController>(
//           builder: (builder) {
//             return Get.find<AddressController>().districtList.isEmpty
//                 ? SizedBox()
//                 : InputDecorator(
//               decoration: decoration("Select District"),
//               child: ButtonTheme(
//                 alignedDropdown: true,
//                 child: DropdownButton<String>(
//                   iconEnabledColor: Colors.green,
//                   iconDisabledColor: Colors.red,
//                   isDense: true,
//                   isExpanded: true,
//                   hint: Text(
//                       Get.find<AddressController>().selectedDistrict),
//                   items:
//                   Get.find<AddressController>().districtList.map((e) {
//                     return DropdownMenuItem<String>(
//                         value: e, child: Text(e));
//                   }).toList(),
//                   onChanged: (district) {
//                     Get.find<AddressController>()
//                         .setSelectedDistrict(district);
//                     Get.find<AddressController>().getAreaList(district);
//                   },
//                 ),
//               ),
//             );
//           },
//         ),
//       );
//     }
//
//     Widget _buildAreaDropdown() {
//       return Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: GetBuilder<AddressController>(
//           builder: (builder) {
//             return Get.find<AddressController>().areaList.isEmpty
//                 ? SizedBox()
//                 : InputDecorator(
//               decoration: decoration("Select Area"),
//               child: ButtonTheme(
//                 alignedDropdown: true,
//                 child: DropdownButton<String>(
//                   iconEnabledColor: Colors.green,
//                   iconDisabledColor: Colors.red,
//                   isDense: true,
//                   isExpanded: true,
//                   hint: Text(Get.find<AddressController>().selectedArea),
//                   items: Get.find<AddressController>().areaList.map((e) {
//                     return DropdownMenuItem<String>(
//                         value: e, child: Text(e));
//                   }).toList(),
//                   onChanged: (area) {
//                     Get.find<AddressController>().setSelectedArea(area);
//                   },
//                 ),
//               ),
//             );
//           },
//         ),
//       );
//     }
//
//     Widget buildMapContainer() {
//       return Container(
//         height: Get.size.height * 0.2,
//         child: position == null
//             ? Center(
//           child: CircularProgressIndicator(),
//         )
//             : GoogleMap(
//           initialCameraPosition: CameraPosition(
//               target: LatLng(position.latitude, position.longitude),
//               zoom: 16),
//           onMapCreated: (GoogleMapController controller) {
//             _controller.complete(controller);
//           },
//           markers: Set<Marker>.of(markers.values),
//           mapType: MapType.normal,
//           zoomGesturesEnabled: true,
//           myLocationEnabled: true,
//           myLocationButtonEnabled: true,
//           gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
//             new Factory<OneSequenceGestureRecognizer>(
//                   () => new EagerGestureRecognizer(),
//             ),
//           ].toSet(),
//           onLongPress: (LatLng latlng) {
//             print(latlng.latitude.toString() +
//                 "," +
//                 latlng.longitude.toString());
//             setState(() {
//               markers["outletMarker"] = Marker(
//                 markerId: MarkerId("outletMarker"),
//                 position: new LatLng(latlng.latitude, latlng.longitude),
//               );
//             });
//
//             position = Position(
//                 longitude: latlng.longitude,
//                 latitude: latlng.latitude,
//                 timestamp: DateTime.now(),
//                 accuracy: 0.0,
//                 altitude: 0.0,
//                 heading: 0.0,
//                 speed: 0.0,
//                 speedAccuracy: 0.0);
//             determineStreet(position.latitude, position.longitude);
//           },
//         ),
//       );
//     }
//
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('Register Sales Outlet'),
//         ),
//         body: GetBuilder<LocationController>(
//           builder: (locationController) {
//             return Get.find<LocationController>().userPosition == null
//                 ? Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text("Please enable location"),
//                   CupertinoActivityIndicator(),
//                 ],
//               ),
//             )
//                 : ListView(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: TextField(
//                     autofocus: false,
//                     decoration: InputDecoration(
//                         labelText: 'Shop Name',
//                         prefixIcon: Icon(Icons.shopping_bag_outlined)),
//                     controller: _nameCntrl,
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(12.0),
//                   child: TextField(
//                     autofocus: false,
//                     decoration: InputDecoration(
//                         labelText: 'Owner Name',
//                         prefixIcon: Icon(Icons.person)),
//                     controller: _ownerCntrl,
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: TextField(
//                     autofocus: false,
//                     keyboardType: TextInputType.number,
//                     maxLength: 10,
//                     decoration: InputDecoration(
//                         prefixText: '+977 - ',
//                         labelText: 'Phone',
//                         prefixIcon: Icon(Icons.phone)),
//                     controller: _phoneCntrl,
//                   ),
//                 ),
//                 // _buildProvinceDropdown(),
//                 // _buildDistrictDropdown(),
//                 // _buildAreaDropdown(),
//                 // _buildStreetDropdown(),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: TextField(
//                     autofocus: false,
//                     decoration: InputDecoration(
//                         labelText: 'Location',
//                         prefixIcon: Icon(Icons.add_road)),
//                     controller: _streetCntrl.value,
//                     onChanged: (value) {
//                       street.value = value;
//                     },
//                   ),
//                 ),
//                 Container(
//                   padding: const EdgeInsets.all(12.0),
//                   child: InputDecorator(
//                     decoration: InputDecoration(
//                       labelText: 'Shop Type',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10.0),
//                       ),
//                     ),
//                     child: Column(
//                       children: [
//                         Row(
//                           children: <Widget>[
//                             Radio(
//                               value: SellerType.mart,
//                               groupValue: _type,
//                               onChanged: (newValue) =>
//                                   setState(() => _type = newValue),
//                               activeColor: Colors.red,
//                             ),
//                             Text(SellerType.mart),
//                             SizedBox(
//                               width: 65,
//                             ),
//                             Radio(
//                               value: SellerType.wholeSeller,
//                               groupValue: _type,
//                               onChanged: (newValue) =>
//                                   setState(() => _type = newValue),
//                               activeColor: Colors.red,
//                             ),
//                             Text(SellerType.wholeSeller)
//                           ],
//                         ),
//                         Row(
//                           children: <Widget>[
//                             Radio(
//                               value: SellerType.retailer,
//                               groupValue: _type,
//                               onChanged: (newValue) =>
//                                   setState(() => _type = newValue),
//                               activeColor: Colors.red,
//                             ),
//                             Text(SellerType.retailer),
//                             SizedBox(
//                               width: 42,
//                             ),
//                             Radio(
//                               value: SellerType.hawcker,
//                               groupValue: _type,
//                               onChanged: (newValue) =>
//                                   setState(() => _type = newValue),
//                               activeColor: Colors.red,
//                             ),
//                             Text(SellerType.hawcker)
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 // view on map
//                 buildMapContainer(),
//
//                 Padding(
//                   padding: EdgeInsets.symmetric(
//                       horizontal: 20.0, vertical: 5.0),
//                   child: OutlinedButton(
//                     style: OutlinedButton.styleFrom(),
//                     onPressed: () {
//                       pickImage();
//                     },
//                     child: Text("Select Image"),
//                   ),
//                 ),
//                 Container(
//                   child: _imageFile == null
//                       ? Center(
//                     child: Text("No Image Selected"),
//                   )
//                       : Image.file(File(_imageFile.path)),
//                 ),
//                 Padding(
//                   padding:
//                   EdgeInsets.symmetric(horizontal: 80, vertical: 5),
//                   child: MaterialButton(
//                     onPressed: () async {
//                       FocusScope.of(context).unfocus(); //dismiss keyboard
//
//                       if (validateInput()) {
//                         var conn = await Utilities.isInternetWorking();
//                         showDialog(
//                             barrierDismissible: false,
//                             context: context,
//                             builder: (context) {
//                               return CupertinoAlertDialog(
//                                 title: Text('Please Wait'),
//                                 content: Column(
//                                   children: [
//                                     Divider(),
//                                     Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: Text(conn
//                                           ? 'Registering new Sales Outlet'
//                                           : 'Saving offline'),
//                                     ),
//                                     CupertinoActivityIndicator(
//                                       radius: 17,
//                                     )
//                                   ],
//                                 ),
//                               );
//                             });
//                         var outlet = Outlet(
//                           id: DateTime.now().millisecondsSinceEpoch,
//                           outid: DateTime.now().millisecondsSinceEpoch,
//                           contact: _phoneCntrl.text,
//                           latitude: position.latitude,
//                           name: _nameCntrl.text,
//                           ownerName: _ownerCntrl.text,
//                   //        type: _type,
//                           longitude: position.longitude,
//                           // addressId: Get.find<AddressController>()
//                           //     .selectedAreaId,
//                           // street: street.value,
//                           image: base64Image,
//                           // distributorId:
//                           // Constants.selectedDistributor.id.toString(),
//                         );
//
//                         if (conn) {
//                           var response = await registerOutlet(outlet);
//                           Get.back();
//
//                           Utilities.showInToast(response.message,
//                               toastType: response.success
//                                   ? ToastType.SUCCESS
//                                   : ToastType.ERROR);
//
//                           if (response.success) {
//                             outlet.synced = true;
//                             Get.back();
//                           }
//                         } else {
//                           Get.back();
//                           outlet.synced = false;
//
//                           Utilities.showInToast('Storing Offline',
//                               toastType: ToastType.INFO);
//                         }
//                         await DatabaseHelper.instance
//                             .insertOutlet(outlet);
//                       //  Get.find<OutletsController>().addOutlet(outlet);
//                         Get.back();
//                       } else {
//                         Utilities.showInToast('Please complete the form',
//                             toastType: ToastType.ERROR);
//                       }
//                     },
//                     color: Colors.blue,
//                     textColor: Colors.white,
//                     child: Text('Submit'),
//                   ),
//                 ),
//                 SizedBox(
//                   height: Get.size.height * 0.02,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(12.0),
//                   child: Text(
//                     "Warning: Please fill form if and only if you are in that shop.",
//                     style: TextStyle(
//                       color: Colors.red[900],
//                       fontStyle: FontStyle.italic,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: Get.size.height * 0.02,
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
//

// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';
// import 'dart:ui';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:mobitrack_dv_flutter/controller/address_controller.dart';
// import 'package:mobitrack_dv_flutter/controller/database_controller.dart';
// import 'package:mobitrack_dv_flutter/controller/location_controller.dart';
// import 'package:mobitrack_dv_flutter/controller/outlets_controller.dart';
// import 'package:mobitrack_dv_flutter/model/outlet.dart';
// import 'package:mobitrack_dv_flutter/utils/constants.dart';
// import 'package:mobitrack_dv_flutter/utils/utilities.dart';
// import 'package:geocoding/geocoding.dart';
//
// class RegisterShopPage extends StatefulWidget {
//   @override
//   _RegisterShopPageState createState() => _RegisterShopPageState();
// }
//
// class _RegisterShopPageState extends State<RegisterShopPage> {
//   final TextEditingController _nameCntrl = new TextEditingController();
//   final TextEditingController _ownerCntrl = new TextEditingController();
//   final TextEditingController _phoneCntrl = new TextEditingController();
//   var _streetCntrl = new TextEditingController().obs;
//
//  ///var provinceLists = Get.find<AddressController>().provinceList.obs;
//
//   Completer<GoogleMapController> _controller = Completer();
//   Map<String, Marker> markers = <String, Marker>{};
//
//   final ImagePicker _picker = ImagePicker();
//
//   XFile _imageFile;
//
//   String _type = SellerType.mart; //dafault is mart
//   String base64Image;
//   var street = "".obs;
//   bool isProvinceSelected = false;
//
//   Position position;
//
//   @override
//   void initState() {
//     // Get.find<AddressController>().districtList = [];
//     // Get.find<AddressController>().areaList = [];
//     determinePosition();
//     super.initState();
//   }
//
//   determineStreet(double lat, double lng) async {
//     try {
//       List<Placemark> placemarks =
//       await placemarkFromCoordinates(position.latitude, position.longitude);
//       street.value = placemarks[0].street;
//       _streetCntrl.value.text = street.value;
//       print("Place: " + placemarks[0].street);
//     } catch (e) {
//       Utilities.showInToast(
//           "No address information found for supplied coordinates! Please manually write street address",
//           toastType: ToastType.INFO);
//     }
//   }
//
//   determinePosition() async {
//     if (Get.find<LocationController>().userPosition == null) {
//       position = await GeolocatorPlatform.instance.getCurrentPosition(
//
//       );
//     } else {
//       position = Get.find<LocationController>().userPosition;
//     }
//     if (position != null) {
//       determineStreet(position.latitude, position.longitude);
//     }
//   }
//
//   bool validateInput() {
//     return _nameCntrl.text.isNotEmpty &&
//         _ownerCntrl.text.isNotEmpty &&
//         _phoneCntrl.text.isNotEmpty &&
//         _phoneCntrl.text.length == 10 &&
//         //_streetCntrl.value.text.isNotEmpty &&
//        // isProvinceSelected &&
//         _imageFile != null;
//   }
//
//   InputDecoration decoration(String label) {
//     return InputDecoration(
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12.0),
//       ),
//       labelText: label,
//     );
//   }
//
//   void pickImage() async {
//     try {
//       final pickedFile = await _picker.pickImage(
//         source: ImageSource.camera,
//         imageQuality: 25,
//       );
//       if (pickedFile != null) {
//         setState(() {
//           _imageFile = pickedFile;
//         });
//         List<int> imageBytes = await pickedFile.readAsBytes();
//         base64Image = base64Encode(imageBytes);
//         print(base64Image);
//       }
//     } catch (e) {
//       Utilities.showInToast(e.message);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Widget _buildProvinceDropdown() {
//       return Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: GetBuilder<AddressController>(
//           builder: (builder) {
//             return Get.find<AddressController>().provinceList.isEmpty
//                 ? SizedBox()
//                 : InputDecorator(
//               decoration: decoration("Select Province"),
//               child: ButtonTheme(
//                 alignedDropdown: true,
//                 child: DropdownButton<String>(
//                   iconEnabledColor: Colors.green,
//                   iconDisabledColor: Colors.red,
//                   isDense: true,
//                   isExpanded: true,
//                   hint: Text(
//                       Get.find<AddressController>().selectedProvince),
//                   items:
//                   Get.find<AddressController>().provinceList.map((e) {
//                     return DropdownMenuItem<String>(
//                         value: e, child: Text(e));
//                   }).toList(),
//                   onChanged: (province) {
//                     isProvinceSelected = true;
//                     Get.find<AddressController>()
//                         .setSelectedProvince(province);
//                     Get.find<AddressController>()
//                         .getDistrictList(province);
//                   },
//                 ),
//               ),
//             );
//           },
//         ),
//       );
//     }
//
//     Widget _buildDistrictDropdown() {
//       return Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: GetBuilder<AddressController>(
//           builder: (builder) {
//             return Get.find<AddressController>().districtList.isEmpty
//                 ? SizedBox()
//                 : InputDecorator(
//               decoration: decoration("Select District"),
//               child: ButtonTheme(
//                 alignedDropdown: true,
//                 child: DropdownButton<String>(
//                   iconEnabledColor: Colors.green,
//                   iconDisabledColor: Colors.red,
//                   isDense: true,
//                   isExpanded: true,
//                   hint: Text(
//                       Get.find<AddressController>().selectedDistrict),
//                   items:
//                   Get.find<AddressController>().districtList.map((e) {
//                     return DropdownMenuItem<String>(
//                         value: e, child: Text(e));
//                   }).toList(),
//                   onChanged: (district) {
//                     Get.find<AddressController>()
//                         .setSelectedDistrict(district);
//                     Get.find<AddressController>().getAreaList(district);
//                   },
//                 ),
//               ),
//             );
//           },
//         ),
//       );
//     }
//
//     Widget _buildAreaDropdown() {
//       return Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: GetBuilder<AddressController>(
//           builder: (builder) {
//             return Get.find<AddressController>().areaList.isEmpty
//                 ? SizedBox()
//                 : InputDecorator(
//               decoration: decoration("Select Area"),
//               child: ButtonTheme(
//                 alignedDropdown: true,
//                 child: DropdownButton<String>(
//                   iconEnabledColor: Colors.green,
//                   iconDisabledColor: Colors.red,
//                   isDense: true,
//                   isExpanded: true,
//                   hint: Text(Get.find<AddressController>().selectedArea),
//                   items: Get.find<AddressController>().areaList.map((e) {
//                     return DropdownMenuItem<String>(
//                         value: e, child: Text(e));
//                   }).toList(),
//                   onChanged: (area) {
//                     Get.find<AddressController>().setSelectedArea(area);
//                   },
//                 ),
//               ),
//             );
//           },
//         ),
//       );
//     }
//
//     Widget buildMapContainer() {
//       return Container(
//         height: Get.size.height * 0.2,
//         child: position == null
//             ? Center(
//           child: CircularProgressIndicator(),
//         )
//             : GoogleMap(
//           initialCameraPosition: CameraPosition(
//               target: LatLng(position.latitude, position.longitude),
//               zoom: 16),
//           onMapCreated: (GoogleMapController controller) {
//             _controller.complete(controller);
//           },
//           markers: Set<Marker>.of(markers.values),
//           mapType: MapType.normal,
//           zoomGesturesEnabled: true,
//           myLocationEnabled: true,
//           myLocationButtonEnabled: true,
//           gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
//             new Factory<OneSequenceGestureRecognizer>(
//                   () => new EagerGestureRecognizer(),
//             ),
//           ].toSet(),
//           onLongPress: (LatLng latlng) {
//             print(latlng.latitude.toString() +
//                 "," +
//                 latlng.longitude.toString());
//             setState(() {
//               markers["outletMarker"] = Marker(
//                 markerId: MarkerId("outletMarker"),
//                 position: new LatLng(latlng.latitude, latlng.longitude),
//               );
//             });
//
//             position = Position(
//                 longitude: latlng.longitude,
//                 latitude: latlng.latitude,
//                 timestamp: DateTime.now(),
//                 accuracy: 0.0,
//                 altitude: 0.0,
//                 heading: 0.0,
//                 speed: 0.0,
//                 speedAccuracy: 0.0);
//             determineStreet(position.latitude, position.longitude);
//           },
//         ),
//       );
//     }
//
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('Register Sales Outlet'),
//         ),
//         body: GetBuilder<LocationController>(
//           builder: (locationController) {
//             return Get.find<LocationController>().userPosition == null
//                 ? Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text("Please enable location"),
//                   CupertinoActivityIndicator(),
//                 ],
//               ),
//             )
//                 : ListView(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: TextField(
//                     autofocus: false,
//                     decoration: InputDecoration(
//                         labelText: 'Shop Name',
//                         prefixIcon: Icon(Icons.shopping_bag_outlined)),
//                     controller: _nameCntrl,
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(12.0),
//                   child: TextField(
//                     autofocus: false,
//                     decoration: InputDecoration(
//                         labelText: 'Owner Name',
//                         prefixIcon: Icon(Icons.person)),
//                     controller: _ownerCntrl,
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: TextField(
//                     autofocus: false,
//                     keyboardType: TextInputType.number,
//                     maxLength: 10,
//                     decoration: InputDecoration(
//                         prefixText: '+977 - ',
//                         labelText: 'Phone',
//                         prefixIcon: Icon(Icons.phone)),
//                     controller: _phoneCntrl,
//                   ),
//                 ),
//                 // _buildProvinceDropdown(),
//                 // _buildDistrictDropdown(),
//                 // _buildAreaDropdown(),
//                 // _buildStreetDropdown(),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: TextField(
//                     autofocus: false,
//                     decoration: InputDecoration(
//                         labelText: 'Location',
//                         prefixIcon: Icon(Icons.add_road)),
//                     controller: _streetCntrl.value,
//                     onChanged: (value) {
//                       street.value = value;
//                     },
//                   ),
//                 ),
//                 // Container(
//                 //   padding: const EdgeInsets.all(12.0),
//                 //   child: InputDecorator(
//                 //     decoration: InputDecoration(
//                 //       labelText: 'Shop Type',
//                 //       border: OutlineInputBorder(
//                 //         borderRadius: BorderRadius.circular(10.0),
//                 //       ),
//                 //     ),
//                 //     child: Column(
//                 //       children: [
//                 //         Row(
//                 //           children: <Widget>[
//                 //             Radio(
//                 //               value: SellerType.mart,
//                 //               groupValue: _type,
//                 //               onChanged: (newValue) =>
//                 //                   setState(() => _type = newValue),
//                 //               activeColor: Colors.red,
//                 //             ),
//                 //             Text(SellerType.mart),
//                 //             SizedBox(
//                 //               width: 65,
//                 //             ),
//                 //             Radio(
//                 //               value: SellerType.wholeSeller,
//                 //               groupValue: _type,
//                 //               onChanged: (newValue) =>
//                 //                   setState(() => _type = newValue),
//                 //               activeColor: Colors.red,
//                 //             ),
//                 //             Text(SellerType.wholeSeller)
//                 //           ],
//                 //         ),
//                 //         Row(
//                 //           children: <Widget>[
//                 //             Radio(
//                 //               value: SellerType.retailer,
//                 //               groupValue: _type,
//                 //               onChanged: (newValue) =>
//                 //                   setState(() => _type = newValue),
//                 //               activeColor: Colors.red,
//                 //             ),
//                 //             Text(SellerType.retailer),
//                 //             SizedBox(
//                 //               width: 42,
//                 //             ),
//                 //             Radio(
//                 //               value: SellerType.hawcker,
//                 //               groupValue: _type,
//                 //               onChanged: (newValue) =>
//                 //                   setState(() => _type = newValue),
//                 //               activeColor: Colors.red,
//                 //             ),
//                 //             Text(SellerType.hawcker)
//                 //           ],
//                 //         ),
//                 //       ],
//                 //     ),
//                 //   ),
//                 // ),
//                 // view on map
//                 buildMapContainer(),
//
//                 Padding(
//                   padding: EdgeInsets.symmetric(
//                       horizontal: 20.0, vertical: 5.0),
//                   child: OutlinedButton(
//                     style: OutlinedButton.styleFrom(),
//                     onPressed: () {
//                       pickImage();
//                     },
//                     child: Text("Select Image"),
//                   ),
//                 ),
//                 Container(
//                   child: _imageFile == null
//                       ? Center(
//                     child: Text("No Image Selected"),
//                   )
//                       : Image.file(File(_imageFile.path)),
//                 ),
//                 Padding(
//                   padding:
//                   EdgeInsets.symmetric(horizontal: 80, vertical: 5),
//                   child: MaterialButton(
//                     onPressed: () async {
//                       FocusScope.of(context).unfocus(); //dismiss keyboard
//
//                       if (validateInput()) {
//                         var conn = await Utilities.isInternetWorking();
//                         showDialog(
//                             barrierDismissible: false,
//                             context: context,
//                             builder: (context) {
//                               return CupertinoAlertDialog(
//                                 title: Text('Please Wait'),
//                                 content: Column(
//                                   children: [
//                                     Divider(),
//                                     Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: Text(conn
//                                           ? 'Registering new Sales Outlet'
//                                           : 'Saving offline'),
//                                     ),
//                                     CupertinoActivityIndicator(
//                                       radius: 17,
//                                     )
//                                   ],
//                                 ),
//                               );
//                             });
//                         var outlet = Outlet(
//                           id: DateTime.now().millisecondsSinceEpoch,
//                           outid: ,
//                           contact: _phoneCntrl.text,
//                           latitude: position.latitude,
//                           name: _nameCntrl.text,
//                           ownerName: _ownerCntrl.text,
//                         //  type: _type,
//                           longitude: position.longitude ,
//                           // addressId: Get.find<AddressController>()
//                           //     .selectedAreaId,
//                          //  street: street.value,
//                           image: base64Image,
//                           // distributorId:
//                           // Constants.selectedDistributor.id.toString(),
//                         );
//
//                         if (conn) {
//                           var response = await registerOutlet(outlet);
//                           Get.back();
//
//                           Utilities.showInToast(response.message,
//                               toastType: response.success
//                                   ? ToastType.SUCCESS
//                                   : ToastType.ERROR);
//
//                           if (response.success) {
//                           //  outlet.synced = true;
//                             Get.back();
//                           }
//                         } else {
//                           Get.back();
//                        //   outlet.synced = false;
//
//                           Utilities.showInToast('Storing Offline',
//                               toastType: ToastType.INFO);
//                         }
//                         // await DatabaseHelper.instance
//                         //     .insertOutlet(outlet);
//                        // Get.find<OutletsController>().addOutlet(outlet);
//                         Get.back();
//                       } else {
//                         Utilities.showInToast('Please complete the form',
//                             toastType: ToastType.ERROR);
//                       }
//                     },
//                     color: Colors.blue,
//                     textColor: Colors.white,
//                     child: Text('Submit'),
//                   ),
//                 ),
//                 SizedBox(
//                   height: Get.size.height * 0.02,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(12.0),
//                   child: Text(
//                     "Warning: Please fill form if and only if you are in that shop.",
//                     style: TextStyle(
//                       color: Colors.red[900],
//                       fontStyle: FontStyle.italic,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: Get.size.height * 0.02,
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
