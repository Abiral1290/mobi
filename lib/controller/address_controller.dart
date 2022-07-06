import 'dart:convert';

import 'package:get/get.dart';
import 'package:mobitrack_dv_flutter/controller/database_controller.dart';
import 'package:mobitrack_dv_flutter/controller/preference_controller.dart';
import 'package:mobitrack_dv_flutter/model/address.dart';
import 'package:mobitrack_dv_flutter/utils/utilities.dart';
import "package:collection/collection.dart";

class AddressController extends GetxController {
  List<Address> addressList = [];
  List<String> provinceList = [];
  List<String> districtList = [];
  List<String> areaList = [];
  List<String> zonelist = [];
  List<String> townlist = [];
  List<String> routelist = [];

  String selectedProvince = "";
  String selectedDistrict = "";
  String selectedArea = "";
  String selectedzone = "";
  String selectedtown = "";
  String selectedroute = "";

  String selectedAreaId = "";

  // var districtList = {};
  // var areaList = {};

  DatabaseHelper databaseHelper = DatabaseHelper.instance;

  AddressController() {
    getAddressList();
  }

  getSelectedAreaId(String area) {
    var newList =
        addressList.where((element) => element.localLevelEn == selectedArea);
    selectedAreaId = newList.first.id.toString();
    update();
  }

  setSelectedProvince(String province) {
    selectedProvince = province;
    update();
  }
  setSelectedroute(String route) {
    selectedroute = route;
    update();
  }

  setSelectedDistrict(String district) {
    selectedDistrict = district;
    update();
  }

  setSelectedArea(String area) {
    selectedArea = area;
    getSelectedAreaId(area);
    update();
  }

  getProvinceList() {
    var newprovinceList =
        addressList.groupListsBy((element) => element.province);
    for (var list in newprovinceList.keys) {
      provinceList.add(list!);
    }
    setSelectedProvince(provinceList.first);

    getDistrictList(provinceList.first);

    update();
  }

  getzoneList() {
    var newprovinceList =
    addressList.groupListsBy((element) => element.province);
    for (var list in newprovinceList.keys) {
      provinceList.add(list!);
    }
    setSelectedProvince(provinceList.first);

    getDistrictList(provinceList.first);

    update();
  }

  getDistrictList(String selectedProvince) {
    districtList = [];
    var newList = addressList
        .where((element) => element.province == selectedProvince)
        .toList();
    var newdistrictList = newList.groupListsBy((element) => element.district);
    newdistrictList.keys.forEach((district) {
      districtList.add(district!);
    });
    setSelectedDistrict(districtList.first);

    getAreaList(districtList.first);

    update();
  }

  getAreaList(String selectedDistrict) {
    areaList = [];
    var newList = addressList
        .where((element) => element.district == selectedDistrict)
        .toList();
    print(newList);
    var newArealist = newList.groupListsBy((element) => element.localLevelEn);
    newArealist.keys.forEach((area) {
      areaList.add(area!);
    });
    setSelectedArea(areaList.first);

    update();
  }


  getroutelist(String selectedroute){
    routelist = [];

  }
  getAddressList() async {
    var conn = await Utilities.isInternetWorking();
    if (conn) {
      await fetchAddressApi().then((value) async {
        print(value.response);
        if (value.success!) {
          print(value.response);
          Get.find<PreferenceController>()
              .saveAddress(jsonEncode(value.response));
        }
      });
    }
    Get.find<PreferenceController>().getAddress().then((value) {
      if (value != null) {
        var data = jsonDecode(value);
        // addressList = jsonDecode(value);
        addressList = data.map<Address>((json) {
          return Address.fromJson(json);
        }).toList();
        getProvinceList();
        update();
      } else {
        addressList = [];
        update();
      }
    });
    print(addressList);
  }
}
