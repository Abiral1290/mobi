import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mobitrack_dv_flutter/model/resp.dart';

import '../controller/auth_controller.dart';
import '../utils/api_urls.dart';
import 'package:http/http.dart' as http;



class Town {
  int id;
  String town;
  String zone;
  int zoneid;

  Town({this.id, this.town, this.zone, this.zoneid});

  Town.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    town = json['town'];
    zone = json['zone'];
    zoneid = json['zoneid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['town'] = this.town;
    data['zone'] = this.zone;
    data['zoneid'] = this.zoneid;
    return data;
  }
}

Future<ApiResponse<List<Town>>> fetchTownApi() async {
  var headers = {
    'Authorization': 'Bearer ' + Get.find<AuthController>().user.apiToken,
    'Accept': 'application/json'
  };

  // try {
  var res = await http.get(
      Uri.parse(ApiUrls.town  ),
      headers: headers);
  Map<String, dynamic> obj = json.decode(res.body);


  if (res.statusCode == 200) {
    final data = obj["data"].cast<Map<String, dynamic>>();

    List<Town> categorise = await data.map<Town>((json) {
      var out = Town.fromJson(json);
      // out.synced = true;
      return out;
    }).toSet().toList();
    return ApiResponse(true, obj['message'], categorise);
  } else {
    print(obj);
    return ApiResponse(
        obj['success'] ?? false, obj['message'] ?? 'Unknown error', null);
  }
  // } catch (e) {
  //   print(e.toString());
  //   return ApiResponse(false, e.toString(), null);
  // }
}