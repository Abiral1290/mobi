import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mobitrack_dv_flutter/controller/database_controller.dart';
import 'package:mobitrack_dv_flutter/controller/preference_controller.dart';
import 'package:mobitrack_dv_flutter/model/address.dart';
import 'package:mobitrack_dv_flutter/model/category.dart';
import 'package:mobitrack_dv_flutter/utils/utilities.dart';
import "package:collection/collection.dart";

class CategoriesController extends GetxController {
  List<Categories> categoriesList = [];
   List<String> category = [];
   List <Categories> cat= [];
  // List<String> districtList = [];
  // List<String> areaList = [];
  // List<String> zonelist = [];
  // List<String> townlist = [];
  // List<String> routelist = [];
  String selectedCategory= "";


  int selectedid ;

  // var districtList = {};
  // var areaList = {};

//  DatabaseHelper databaseHelper = DatabaseHelper.instance;

  CategoriesController() {
    getCategoryList();
  }

  // getSelectedAreaId(String area) {
  //   var newList =
  //   categoriesList.where((element) => element.category == selectedArea);
  //   selectedAreaId = newList.first.id.toString();
  //   update();
  // }
  //
  setSelectedProvince( String category  ) {
    selectedCategory = category;
    // var newlist = cat.where((element) => element.category == category);
    // selectedid = newlist.first.id;
   // selectedid = category_id;
    update();
  }
  // setSelectedroute(String route) {
  //   selectedroute = route;
  //   update();
  // }
  //
  // setSelectedDistrict(String district) {
  //   selectedDistrict = district;
  //   update();
  // }
  //
  // setSelectedArea(String area) {
  //   selectedArea = area;
  //   getSelectedAreaId(area);
  //   update();
  // }

  // getProvinceList() {
  //   var newcategoryList =
  //   categoriesList.groupListsBy((element) => element.category);
  //   for (var list in newcategoryList.keys) {
  //     category.add(list);
  //   }
  //   setSelectedProvince(category.first);
  //
  //  // getDistrictList(provinceList.first);
  //
  //   update();
  // }


  getCategoryList() async {
    var conn = await Utilities.isInternetWorking();
    if (conn) {
      await fetchCategoryApi().then((value) async {
        print(value.response);
        if (value.success) {
          categoriesList = value.response;
          setSelectedProvince(categoriesList.first.id.toString() );
          update();
          print(categoriesList.length);
          // Get.find<PreferenceController>()
          //     .saveAddress(jsonEncode(value.response));
        }else{
          Utilities.showInToast(value.message, toastType: ToastType.ERROR);
          categoriesList = [];
          update();
        }
      });
    }
    // Get.find<PreferenceController>().getAddress().then((value) {
    //   if (value != null) {
    //     var data = jsonDecode(value);
    //     // addressList = jsonDecode(value);
    //     categoriesList = data.map<Address>((json) {
    //       return Address.fromJson(json);
    //     }).toList();
    //   //  getProvinceList();
    //     update();
    //   } else {
    //     categoriesList = [];
    //     update();
    //   }
    // });
    print(categoriesList);
  }
}
