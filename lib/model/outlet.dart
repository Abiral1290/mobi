import 'dart:convert';

import 'package:get/instance_manager.dart';
import 'package:http/http.dart' as http;
import 'package:mobitrack_dv_flutter/controller/auth_controller.dart';
import 'package:mobitrack_dv_flutter/model/resp.dart';
import 'package:mobitrack_dv_flutter/utils/api_urls.dart';

class Outlet {
  String name;
  String ownerName;
  String contact;
  String type;
  int salesOfficerId;
  double latitude;
  double longitude;

  Outlet(
      {this.name,
      this.ownerName,
      this.contact,
      this.type,
      this.salesOfficerId,
      this.latitude,
      this.longitude});

  Outlet.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    ownerName = json['owner_name'];
    contact = json['contact'];
    type = json['type'];
    salesOfficerId = json['sales_officer_id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['owner_name'] = this.ownerName;
    data['contact'] = this.contact;
    data['type'] = this.type;
    data['sales_officer_id'] = this.salesOfficerId.toString();
    data['latitude'] = this.latitude.toString();
    data['longitude'] = this.longitude.toString();
    return data;
  }
}

Future<ApiResponse> registerOutlet(Outlet outlet) async {
  var body = outlet.toJson();
  var headers = {
    'Authorization': 'Bearer ' + Get.find<AuthController>().user.apiToken,
    'Accept': 'application/json'
  };

  try {
    var resp = await http.post(Uri.parse(ApiUrls.outlets),
        headers: headers, body: body);
    Map<String, dynamic> obj = json.decode(resp.body);

    if (resp.statusCode == 200) {
      return ApiResponse(obj['success'], obj['message'], null);
    } else {
      return ApiResponse(
          obj['success'] ?? false, obj['message'] ?? 'Unknown error', null);
    }
  } catch (e) {
    print(e.toString());
    return ApiResponse(false, e.toString(), null);
  }
}
