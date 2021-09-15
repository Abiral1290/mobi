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
import 'package:mobitrack_dv_flutter/model/outlet.dart';
import 'package:mobitrack_dv_flutter/utils/constants.dart';
import 'package:mobitrack_dv_flutter/utils/utilities.dart';
import 'package:geocoding/geocoding.dart';

class RegisterShopPage extends StatefulWidget {
  @override
  _RegisterShopPageState createState() => _RegisterShopPageState();
}

class _RegisterShopPageState extends State<RegisterShopPage> {
  final TextEditingController _nameCntrl = new TextEditingController();
  final TextEditingController _ownerCntrl = new TextEditingController();
  final TextEditingController _phoneCntrl = new TextEditingController();
  var _streetCntrl = new TextEditingController().obs;

  var provinceLists = Get.find<AddressController>().provinceList.obs;

  Completer<GoogleMapController> _controller = Completer();
  Map<String, Marker> markers = <String, Marker>{};

  final ImagePicker _picker = ImagePicker();

  XFile _imageFile;

  String _type = SellerType.mart; //dafault is mart
  String base64Image;
  var street = "".obs;
  bool isProvinceSelected = false;

  Position position;

  @override
  void initState() {
    Get.find<AddressController>().districtList = [];
    Get.find<AddressController>().areaList = [];
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
          desiredAccuracy: LocationAccuracy.bestForNavigation);
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
        _streetCntrl.value.text.isNotEmpty &&
        isProvinceSelected &&
        _imageFile != null;
  }

  InputDecoration decoration(String label) {
    return InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      labelText: label,
    );
  }

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

    Widget _buildDistrictDropdown() {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: GetBuilder<AddressController>(
          builder: (builder) {
            return Get.find<AddressController>().districtList.isEmpty
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
                            Get.find<AddressController>().selectedDistrict),
                        items:
                            Get.find<AddressController>().districtList.map((e) {
                          return DropdownMenuItem<String>(
                              value: e, child: Text(e));
                        }).toList(),
                        onChanged: (district) {
                          Get.find<AddressController>()
                              .setSelectedDistrict(district);
                          Get.find<AddressController>().getAreaList(district);
                        },
                      ),
                    ),
                  );
          },
        ),
      );
    }

    Widget _buildAreaDropdown() {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: GetBuilder<AddressController>(
          builder: (builder) {
            return Get.find<AddressController>().areaList.isEmpty
                ? SizedBox()
                : InputDecorator(
                    decoration: decoration("Select Area"),
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton<String>(
                        iconEnabledColor: Colors.green,
                        iconDisabledColor: Colors.red,
                        isDense: true,
                        isExpanded: true,
                        hint: Text(Get.find<AddressController>().selectedArea),
                        items: Get.find<AddressController>().areaList.map((e) {
                          return DropdownMenuItem<String>(
                              value: e, child: Text(e));
                        }).toList(),
                        onChanged: (area) {
                          Get.find<AddressController>().setSelectedArea(area);
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
        height: Get.size.height * 0.2,
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
          title: Text('Register Sales Outlet'),
        ),
        body: GetBuilder<LocationController>(
          builder: (locationController) {
            return Get.find<LocationController>().userPosition == null
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Please enable location"),
                        CupertinoActivityIndicator(),
                      ],
                    ),
                  )
                : ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          autofocus: false,
                          decoration: InputDecoration(
                              labelText: 'Shop Name',
                              prefixIcon: Icon(Icons.shopping_bag_outlined)),
                          controller: _nameCntrl,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextField(
                          autofocus: false,
                          decoration: InputDecoration(
                              labelText: 'Owner Name',
                              prefixIcon: Icon(Icons.person)),
                          controller: _ownerCntrl,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          autofocus: false,
                          keyboardType: TextInputType.number,
                          maxLength: 10,
                          decoration: InputDecoration(
                              prefixText: '+977 - ',
                              labelText: 'Phone',
                              prefixIcon: Icon(Icons.phone)),
                          controller: _phoneCntrl,
                        ),
                      ),
                      _buildProvinceDropdown(),
                      _buildDistrictDropdown(),
                      _buildAreaDropdown(),
                      // _buildStreetDropdown(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          autofocus: false,
                          decoration: InputDecoration(
                              labelText: 'Location',
                              prefixIcon: Icon(Icons.add_road)),
                          controller: _streetCntrl.value,
                          onChanged: (value) {
                            street.value = value;
                          },
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(12.0),
                        child: InputDecorator(
                          decoration: InputDecoration(
                            labelText: 'Shop Type',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: <Widget>[
                                  Radio(
                                    value: SellerType.mart,
                                    groupValue: _type,
                                    onChanged: (newValue) =>
                                        setState(() => _type = newValue),
                                    activeColor: Colors.red,
                                  ),
                                  Text(SellerType.mart),
                                  SizedBox(
                                    width: 65,
                                  ),
                                  Radio(
                                    value: SellerType.wholeSeller,
                                    groupValue: _type,
                                    onChanged: (newValue) =>
                                        setState(() => _type = newValue),
                                    activeColor: Colors.red,
                                  ),
                                  Text(SellerType.wholeSeller)
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Radio(
                                    value: SellerType.retailer,
                                    groupValue: _type,
                                    onChanged: (newValue) =>
                                        setState(() => _type = newValue),
                                    activeColor: Colors.red,
                                  ),
                                  Text(SellerType.retailer),
                                  SizedBox(
                                    width: 42,
                                  ),
                                  Radio(
                                    value: SellerType.hawcker,
                                    groupValue: _type,
                                    onChanged: (newValue) =>
                                        setState(() => _type = newValue),
                                    activeColor: Colors.red,
                                  ),
                                  Text(SellerType.hawcker)
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      // view on map
                      buildMapContainer(),

                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 5.0),
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(),
                          onPressed: () {
                            pickImage();
                          },
                          child: Text("Select Image"),
                        ),
                      ),
                      Container(
                        child: _imageFile == null
                            ? Center(
                                child: Text("No Image Selected"),
                              )
                            : Image.file(File(_imageFile.path)),
                      ),
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
                              var outlet = Outlet(
                                id: DateTime.now().millisecondsSinceEpoch,
                                contact: _phoneCntrl.text,
                                latitude: position.latitude,
                                name: _nameCntrl.text,
                                ownerName: _ownerCntrl.text,
                                type: _type,
                                longitude: position.longitude,
                                addressId: Get.find<AddressController>()
                                    .selectedAreaId,
                                street: street.value,
                                image: base64Image,
                                distributorId:
                                    Constants.selectedDistributor.id.toString(),
                              );

                              if (conn) {
                                var response = await registerOutlet(outlet);
                                Get.back();

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
}
