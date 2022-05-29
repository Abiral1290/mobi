import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mobitrack_dv_flutter/model/resp.dart';

import '../controller/auth_controller.dart';
import '../utils/api_urls.dart';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';
import 'outlet.dart';

class Routees {
  int id;
  String routename;

  Routees({this.id, this.routename});

  Routees.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    routename = json['routename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['routename'] = this.routename;
    return data;
  }
}




class Routes {
  int id;
  String routename;

  Routes({this.id, this.routename});

  Routes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    routename = json['routename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['routename'] = this.routename;
    return data;
  }
}


Future<ApiResponse<List<Routes>>> fetchRouteApi( ) async {
  var headers = {
    'Authorization': 'Bearer ' + Get.find<AuthController>().user.apiToken,
    'Accept': 'application/json'
  };
  // try {
  var res = await http.get(Uri.parse(ApiUrls.Day_routes), headers: headers);
  //var res_1 = await http.get(Uri.parse(ApiUrls_Group.distributors), headers: headers);
  Map<String, dynamic> obj = json.decode(res.body);
  //Map<String, dynamic> obj_1 = json.decode(res_1.body);
  if (res.statusCode == 200) {
    final data = obj["data"].cast<Map<String, dynamic>>();
    List<Routes> routees = await data.map<Routes>((json) {
      return Routes.fromJson(json);
    }).toList();
    return
      ApiResponse(true, obj['message'], routees);
  } else {
    print(obj);
    return ApiResponse(
        obj['success'] ?? false, obj['message'] ?? 'Unknown error', null);
  }
}
// Future<ApiResponse<Routes>> fetchRoutes() async {
//   var headers = {
//     'Authorization': 'Bearer ' + Get.find<AuthController>().user.apiToken,
//     'Accept': 'application/json'
//   };
//
//
//   try {
//     var resp =
//     await http.get(Uri.parse(ApiUrls.Day_routes), headers: headers);
//     Map<String, dynamic> obj = json.decode(resp.body);
//
//     if (resp.statusCode == 200) {
//       return ApiResponse(
//           obj['success'], obj['message'], Routes.fromJson(obj['data']));
//     } else {
//       return ApiResponse(
//           obj['success'] ?? false, obj['message'] ?? 'Unknown error', null);
//     }
//   } catch (e) {
//     print(e.toString());
//     return ApiResponse(false, e.toString(), null);
//   }
// }
// Future<ApiResponse<List<Routees>>> fetchDayWiseRouteApi( ) async {
//   var headers = {
//     'Authorization': 'Bearer ' + Get.find<AuthController>().user.apiToken,
//     'Accept': 'application/json'
//   };
//   // try {
//   var res = await http.get(Uri.parse(ApiUrls.Day_routes), headers: headers);
//   //var res_1 = await http.get(Uri.parse(ApiUrls_Group.distributors), headers: headers);
//   Map<String, dynamic> obj = json.decode(res.body);
//   //Map<String, dynamic> obj_1 = json.decode(res_1.body);
//   if (res.statusCode == 200) {
//     final data = obj["data"].cast<Map<String, dynamic>>();
//     List<Routees> routees = await data.map<Routees>((json) {
//       return Routees.fromJson(json);
//     }).toList();
//
//     return
//       ApiResponse(true, obj['message'], routees);
//   } else {
//     print(obj);
//     return ApiResponse(
//         obj['success'] ?? false, obj['message'] ?? 'Unknown error', null);
//   }
//
// }