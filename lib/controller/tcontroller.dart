// // import 'dart:convert';
// //
// // import 'package:get/get.dart';
// // import 'package:mobitrack_dv_flutter/controller/preference_controller.dart';
// // import 'package:mobitrack_dv_flutter/utils/utilities.dart';
// //
// // import '../model/products.dart';
// //
// // class ProductBrandController extends GetxController{
// //
// //   List<Product> productlist  = [];
// //   List<String> brandList = [];
// //   List<String> name= [];
// //   List<String> unit = [];
// //   List<String> value = [];
// //   List<String> catalog = [];
// //
// //   String selectedBrand = "";
// //   String selectedName = "";
// //   String selectedUnit = "";
// //   String selectedValue = "";
// //   String selectedCatalog = "";
// //
// //
// //
// //
// //   setSelectedProvince(String province) {
// //     selectedBrand= province;
// //     update();
// //   }
// //   getbrandList() {
// //     var newprovinceList =
// //     productlist.groupListsBy((element) => element.province);
// //     for (var list in newprovinceList.keys) {
// //      brandList.add(list);
// //     }
// //     setSelectedProvince(brandList.first);
// //
// //     //getDistrictList(provinceList.first);
// //
// //     update();
// //   }
// //
// //   getproductlist() async{
// //     var conn = await Utilities.isInternetWorking();
// //     if(conn){
// //       await fetchProducts().then((value) async {
// //         print(value.response);
// //         if(value.success){
// //           print(value.response);
// //           Get.find<PreferenceController>()
// //               .saveProduct(jsonEncode(value.response));
// //         }
// //       });
// //     }
// //     Get.find<PreferenceController>().getProduct().then((value) {
// //       if(value != null){
// //         var data = jsonDecode(value);
// //         productlist = jsonDecode(value);
// //         productlist = data.map<Product>((json){
// //           return Product.fromJson(json);
// //         }).toList();
// //         getbrandList();
// //         update();
// //       }else{
// //         productlist = [];
// //         update();
// //       }
// //     });
// //     print(productlist);
// //   }
// //
// // }
//
// import 'dart:convert';
//
// import 'package:get/get.dart';
// import 'package:mobitrack_dv_flutter/controller/database_controller.dart';
// import 'package:mobitrack_dv_flutter/controller/preference_controller.dart';
// import 'package:mobitrack_dv_flutter/model/address.dart';
// import 'package:mobitrack_dv_flutter/model/products.dart';
// import 'package:mobitrack_dv_flutter/model/town.dart';
// import 'package:mobitrack_dv_flutter/utils/utilities.dart';
// import "package:collection/collection.dart";
//
// class TController extends GetxController {
//   List<Town> productList = [];
//   List<String> brandList = [];
//   // List<String> districtList = [];
//   // List<String> areaList = [];
//   List<Product> names = [];
//   List<String> name= [];
//   List<String> unit = [];
//   List<String> value = [];
//   List<String> catalog = [];
//
//   String selectedBrand = "";
//   String selectedName = "";
//   String selectedUnit = "";
//   String selectedValue = "";
//   String selectedCatalog = "";
//
//
//   String selectedProvince = "";
//   String selectedname = "";
//   String selectedArea = "";
//
//   String selectedAreaId = "";
//
//   // var districtList = {};
//   // var areaList = {};
//
//   DatabaseHelper databaseHelper = DatabaseHelper.instance;
//
//   ProductBrandController() {
//     getBrandList();
//   }
//   //
//   // getSelectedAreaId(String area) {
//   //   var newList =
//   //   productList.where((element) => element.localLevelEn == selectedArea);
//   //   selectedAreaId = newList.first.id.toString();
//   //   update();
//   // }
//
//   setSelectedBrand(String brand) {
//     selectedBrand = brand;
//     update();
//   }
//
//   setSelectedName(String name) {
//     selectedName = name;
//     update();
//   }
//   setSelectedValue(String value) {
//     selectedValue = value;
//     update();
//   }
//
//   // setSelectedArea(String area) {
//   //   selectedArea = area;
//   //   getSelectedAreaId(area);
//   //   update();
//   // }
//
//   // getProductListFromAPI() async {
//   //   var conn = await Utilities.isInternetWorking();
//   //   if (conn) {
//   //     await fetchProducts().then((value) async {
//   //       print(value.response);
//   //       await databaseHelper.deleteAllProducts().then((res) {
//   //         if (value.success) {
//   //           for (var data in value.response) {
//   //             databaseHelper.insertProducts(data);
//   //           }
//   //         } else {
//   //           Utilities.showInToast(value.message, toastType: ToastType.ERROR);
//   //         }
//   //       });
//   //     });
//   //   }
//   //   databaseHelper.getAllProductsData().then((value) {
//   //     if (value != null) {
//   //       productList = value;
//   //    ///   setStockCountData();
//   //       // productList.forEach((element) {
//   //       //   stockCountList[element.id.toString()] = "0";
//   //       // });
//   //       update();
//   //     } else {
//   //       productList = [];
//   //       update();
//   //     }
//   //   });
//   // }
//   getProvinceList() {
//     var newprovinceList =
//     productList.groupListsBy((element) => element.brandname);
//     for (var list in newprovinceList.keys) {
//       brandList.add(list);
//     }
//     setSelectedBrand(brandList.first);
//
//     // getNameList(brandList.first);
//
//     update();
//   }
//
//   getSelectedId(String id){
//     var newlists = productList.where((element) => element.name == name.first);
//     selectedAreaId = newlists.first.id.toString();
//     update();
//   }
//   getNameList(String selectedBrand) {
//     // districtList = [];
//     name =[];
//     var newList = productList
//         .where((element) => element.brandname == selectedBrand)
//         .toList();
//     var newdistrictList = newList.groupListsBy((element) => element.name);
//     newdistrictList.keys.forEach((names) {
//       name.add(names.toString()) ;
//
//     });
//     var newlists = productList.where((element) => element.name == name.first);
//     selectedAreaId = newlists.first.id.toString();
//     // setSelectedName(name.first);
//     // selectedValue == name.first;
//     // setSelectedValue(value.first);
//
//     // var newdistrictLists = newList.groupListsBy((element) => element.id);
//     // newdistrictList.keys.forEach((names) {
//     //   name.add(names);
//     // });
//     //getAreaList(name.first);
//     update();
//   }
//
//
//   getBrandList() async {
//     var conn = await Utilities.isInternetWorking();
//     if (conn) {
//       await fetchTownApi().then((value) async {
//         print(value.response);
//         if (value.success) {
//           print(value.response);
//           Get.find<PreferenceController>()
//               .saveProduct(jsonEncode(value.response));
//         }
//       });
//     }
//     Get.find<PreferenceController>().getProduct().then((value) {
//       if (value != null) {
//         var data = jsonDecode(value);
//         // addressList = jsonDecode(value);
//         productList = data.map<Town>((json) {
//           return Product.fromJson(json);
//         }).toList();
//         //getProvinceList();
//         getProvinceList();
//         update();
//       } else {
//         productList = [];
//         update();
//       }
//     });
//     print(productList);
//   }
//
//
//
//
// }
