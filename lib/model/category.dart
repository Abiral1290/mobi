import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mobitrack_dv_flutter/model/resp.dart';

import '../controller/auth_controller.dart';
import '../utils/api_urls.dart';
import '../utils/constants.dart';
import 'package:http/http.dart' as http;

class Categories {
  int? id;
  String? category;

  Categories({this.id, this.category});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category'] = this.category;
    return data;
  }
}

Future<ApiResponse<List<Categories>>> fetchCategoryApi( ) async {
  var headers = {
    'Authorization': 'Bearer ' + Get.find<AuthController>().user.apiToken!,
    'Accept': 'application/json'
  };

  // try {
  var res = await http.get(Uri.parse(ApiUrls.category), headers: headers);
  //var res_1 = await http.get(Uri.parse(ApiUrls_Group.distributors), headers: headers);
  Map<String, dynamic> obj = json.decode(res.body);
  //Map<String, dynamic> obj_1 = json.decode(res_1.body);
  if (res.statusCode == 200) {
    final data = obj["data"].cast<Map<String, dynamic>>();
    List<Categories> categoreis = await data.map<Categories>((json) {
      return Categories.fromJson(json);
    }).toList();
    //
    // final data_1 = obj_1["data"].cast<Map<String, dynamic>>();
    // List<Distributor> distributor = await data_1.map<Distributor>((json) {
    //   return Distributor.fromJson(json);
    // }).toList();
    return
      ApiResponse(true, obj['message'], categoreis);
  } else {
    print(obj);
    return ApiResponse(
        obj['success'] ?? false, obj['message'] ?? 'Unknown error', null!);
  }
  // } catch (e) {
  //   print(e.toString());
  //   return ApiResponse(false, e.toString(), null);
  // }
}
// Future<ApiResponse<List<Distributor>>> fetchDistributorsApis() async {
//   var headers = {
//     'Authorization': 'Bearer ' + Get.find<AuthController>().user.apiToken!,
//     'Accept': 'application/json'
//   };
//
//   // try {
//   var res = await http.get(Uri.parse(ApiUrls_Group.distributors), headers: headers);
//   Map<String, dynamic> obj = json.decode(res.body);
//
//   if (res.statusCode == 200) {
//     final data = obj["data"].cast<Map<String, dynamic>>();
//     List<Distributor> distributors = await data.map<Distributor>((json) {
//       return Distributor.fromJson(json);
//     }).toList();
//     return ApiResponse(true, obj['message'], distributors);
//   } else {
//     print(obj);
//     return ApiResponse(
//         obj['success'] ?? false, obj['message'] ?? 'Unknown error', null);
//   }
//   // } catch (e) {
//   //   print(e.toString());
//   //   return ApiResponse(false, e.toString(), null);
//   // }
// }

