import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mobitrack_dv_flutter/model/resp.dart';
import 'package:mobitrack_dv_flutter/utils/api_urls.dart';
import 'package:http/http.dart' as http;

import '../controller/auth_controller.dart';

class Distributor_route{
  int? Distributor_id;
  int? Route_id;

  Distributor_route.fromJson(Map<String, dynamic> json){
    Distributor_id = int.parse(json['dis_id'].toString());
    Route_id = int.parse(json['route_id'].toString());
  }

   Map<String,dynamic> toJson(){
    final Map<String,dynamic> data = new Map<String,dynamic>();
    data['distributor_id'] = this.Distributor_id.toString();
    data["route_id"] =this.Route_id.toString();
    return data;
   }
}

Future<ApiResponse> registerOutlet(Distributor_route dis_route) async {
  var body = dis_route.toJson();
  var headers = {
    'Authorization': 'Bearer ' + Get.find<AuthController>().user.apiToken!,
    'Accept': 'application/json'
  };

  try {
    var resp = await http.post(Uri.parse(ApiUrls.route),
        headers: headers, body: body);
    Map<String, dynamic> obj = json.decode(resp.body);

    if (resp.statusCode == 200) {
   //   Distributor_route.synced = true;
      return ApiResponse(obj['success'], obj['message'], null);
    } else {
      return ApiResponse(obj['success'] ?? false, obj['message'], null);
    }
  } catch (e) {
    print(e.toString());
    return ApiResponse(false, e.toString(), null);
  }
}
