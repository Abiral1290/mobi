
import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mobitrack_dv_flutter/model/resp.dart';

import '../controller/auth_controller.dart';
import '../utils/api_urls.dart';
import 'package:http/http.dart' as http;

class AllOutlet {
  int? id;
  int? outletId;
  String? name;

  AllOutlet({this.id, this.outletId, this.name});

  AllOutlet.fromJson(Map<String, dynamic> json) {
    id = (json['id']!=null)? json['id'] : '';
    outletId = (json['outlet_id'] != null)?json['outlet_id']: '' ;
    name = (json['name'] != null) ? json['name'] : '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['outlet_id'] = this.outletId;
    data['name'] = this.name;
    return data;
  }
}

Future<ApiResponse<List<AllOutlet>>> fetchAllOutletsApi() async {
  var headers = {
    'Authorization': 'Bearer ' + Get.find<AuthController>().user.apiToken!,
    'Accept': 'application/json'
  };

  // try {
  var res = await http.get(
      Uri.parse(ApiUrls.getoutlet),
      headers: headers);
  Map<String, dynamic> obj = json.decode(res.body);

  if (res.statusCode == 200) {
    final data = obj["data"].cast<Map<String, dynamic>>();

    List<AllOutlet> outlets = await data.map<AllOutlet>((json) {
      var out = AllOutlet.fromJson(json);
      //  out.synced = true;
      return out;
    }).toList();
    return ApiResponse(true, obj['message'], outlets);
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
// Future<ApiResponse<List<Outlet>>> fetchOutletsApi() async {
//   var headers = {
//     'Authorization': 'Bearer ' + Get.find<AuthController>().user.apiToken!,
//     'Accept': 'application/json'
//   };
//
//   // try {
//   var res = await http.get(
//       Uri.parse(ApiUrls.outlets + Constants.selectedDistributor.id.toString()),
//       headers: headers);
//   Map<String, dynamic> obj = json.decode(res.body);
//
//   if (res.statusCode == 200) {
//     final data = obj["data"].cast<Map<String, dynamic>>();
//     List<Outlet> outlets = await data.map<Outlet>((json) {
//       var out = Outlet.fromJson(json);
//       out.synced = true;
//       return out;
//     }).toSet().toList();
//     return ApiResponse(true, obj['message'], outlets);
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
