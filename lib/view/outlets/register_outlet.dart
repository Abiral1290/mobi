import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:mobitrack_dv_flutter/controller/address_controller.dart';
import 'package:mobitrack_dv_flutter/controller/database_controller.dart';
import 'package:mobitrack_dv_flutter/controller/location_controller.dart';
import 'package:mobitrack_dv_flutter/controller/outlets_controller.dart';
import 'package:mobitrack_dv_flutter/model/address.dart';
import 'package:mobitrack_dv_flutter/model/outlet.dart';
import 'package:mobitrack_dv_flutter/utils/constants.dart';
import 'package:mobitrack_dv_flutter/utils/utilities.dart';

class RegisterShopPage extends StatefulWidget {
  @override
  _RegisterShopPageState createState() => _RegisterShopPageState();
}

class _RegisterShopPageState extends State<RegisterShopPage> {
  final TextEditingController _nameCntrl = new TextEditingController();
  final TextEditingController _ownerCntrl = new TextEditingController();
  final TextEditingController _phoneCntrl = new TextEditingController();
  final TextEditingController _streetCntrl = new TextEditingController();
  String _type = SellerType.mart; //dafault is mart

  static var selectedProvince =
      Get.find<AddressController>().addressList.first.obs;
  static var selectedDistrict = selectedProvince.value.districts.first.obs;
  static var selectedArea = selectedDistrict.value.areas.first.obs;
  static var selectedStreet = selectedArea.value.streets.first.obs;

  var provinceLists = Get.find<AddressController>().addressList.obs;
  var districtLists = [].obs;
  var areaLists = [].obs;
  var streetLists = [].obs;

  @override
  void initState() {
    Get.find<LocationController>().getCurrentPosition();
    super.initState();
  }

  bool validateInput() {
    return _nameCntrl.text.isNotEmpty &&
        _ownerCntrl.text.isNotEmpty &&
        _phoneCntrl.text.isNotEmpty &&
        _phoneCntrl.text.length == 10 &&
        _streetCntrl.text.isNotEmpty &&
        districtLists.isNotEmpty &&
        areaLists.isNotEmpty;
  }

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
        child: InputDecorator(
          decoration: decoration("Select Province"),
          child: Obx(
            () => ButtonTheme(
              alignedDropdown: true,
              child: DropdownButton<Address>(
                iconEnabledColor: Colors.green,
                iconDisabledColor: Colors.red,
                isDense: true,
                isExpanded: true,
                hint: Text(selectedProvince.value.name),
                items: provinceLists.map((e) {
                  return DropdownMenuItem<Address>(
                      value: e, child: Text(e.name));
                }).toList(),
                onChanged: (province) {
                  selectedProvince.value = province;
                  districtLists.value = provinceLists
                          .where((element) =>
                              element.id == selectedProvince.value.id)
                          .toList()
                          .isEmpty
                      ? []
                      : Get.find<AddressController>()
                          .addressList
                          .where((element) =>
                              element.id == selectedProvince.value.id)
                          .toList()
                          .first
                          .districts;
                  if (districtLists.isEmpty) {
                    areaLists.value = [];
                    streetLists.value = [];
                  }
                },
              ),
            ),
          ),
        ),
      );
    }

    Widget _buildDistrictDropdown() {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: InputDecorator(
          decoration: decoration("Select District"),
          child: Obx(
            () => ButtonTheme(
              alignedDropdown: true,
              child: DropdownButton<Districts>(
                iconEnabledColor: Colors.green,
                iconDisabledColor: Colors.red,
                isDense: true,
                isExpanded: true,
                hint: Text(selectedDistrict.value.name),
                items: districtLists.map((e) {
                  return DropdownMenuItem<Districts>(
                      value: e, child: Text(e.name));
                }).toList(),
                onChanged: (district) {
                  selectedDistrict.value = district;
                  areaLists.value = districtLists.isNotEmpty
                      ? districtLists
                          .where((element) =>
                              element.id == selectedDistrict.value.id)
                          .toList()
                          .first
                          .areas
                      : [];
                  if (areaLists.isEmpty) {
                    streetLists.value = [];
                  }
                },
              ),
            ),
          ),
        ),
      );
    }

    Widget _buildAreaDropdown() {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: InputDecorator(
          decoration: decoration("Select Area"),
          child: Obx(
            () => ButtonTheme(
              alignedDropdown: true,
              child: DropdownButton<Areas>(
                iconEnabledColor: Colors.green,
                iconDisabledColor: Colors.red,
                isDense: true,
                isExpanded: true,
                hint: Text(selectedArea.value.name),
                items: areaLists.map((e) {
                  return DropdownMenuItem<Areas>(value: e, child: Text(e.name));
                }).toList(),
                onChanged: (area) {
                  selectedArea.value = area;
                  streetLists.value = areaLists.isNotEmpty
                      ? areaLists
                          .where(
                              (element) => element.id == selectedArea.value.id)
                          .toList()
                          .first
                          .streets
                      : [];
                  if (areaLists.isEmpty) {
                    streetLists.value = [];
                  }
                },
              ),
            ),
          ),
        ),
      );
    }

    Widget _buildStreetDropdown() {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: InputDecorator(
          decoration: decoration("Select Street"),
          child: Obx(
            () => ButtonTheme(
              alignedDropdown: true,
              child: DropdownButton<Streets>(
                iconEnabledColor: Colors.green,
                iconDisabledColor: Colors.red,
                isDense: true,
                isExpanded: true,
                hint: Text(selectedStreet.value.name),
                items: streetLists.map((e) {
                  return DropdownMenuItem<Streets>(
                      value: e, child: Text(e.name));
                }).toList(),
                onChanged: (street) {
                  selectedStreet.value = street;
                },
              ),
            ),
          ),
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
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Please enable location"),
                      CupertinoActivityIndicator(),
                    ],
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
                              labelText: 'Street',
                              prefixIcon: Icon(Icons.add_road)),
                          controller: _streetCntrl,
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
                              var pos = await GeolocatorPlatform.instance
                                  .getCurrentPosition(
                                      desiredAccuracy:
                                          LocationAccuracy.bestForNavigation);
                              var outlet = Outlet(
                                id: DateTime.now().millisecondsSinceEpoch,
                                contact: _phoneCntrl.text,
                                latitude: pos.latitude,
                                name: _nameCntrl.text,
                                ownerName: _ownerCntrl.text,
                                type: _type,
                                // salesOfficerId:
                                //     Get.find<AuthController>().user.id,
                                longitude: pos.longitude,
                                provinceId: selectedProvince.value.id,
                                districtId: selectedDistrict.value.id,
                                areaId: selectedArea.value.id,
                                street: _streetCntrl.text,
                                distributorId: Constants.selectedDistributor.id.toString(),
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
