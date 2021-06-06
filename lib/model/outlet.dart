import 'dart:convert';

import 'package:get/instance_manager.dart';
import 'package:http/http.dart' as http;
import 'package:mobitrack_dv_flutter/controller/auth_controller.dart';
import 'package:mobitrack_dv_flutter/model/resp.dart';
import 'package:mobitrack_dv_flutter/utils/api_urls.dart';

class Outlet {
  int id;
  String name;
  String ownerName;
  String contact;
  String type;
  int salesOfficerId;
  double latitude;
  double longitude;
  String address;

  ///flag to check if the outlet is synced with backend
  bool synced = false;

  Outlet({
    this.id,
    this.name,
    this.ownerName,
    this.contact,
    this.type,
    this.salesOfficerId,
    this.latitude,
    this.longitude,
    this.address,
  });

  Outlet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    ownerName = json['owner_name'];
    contact = json['contact'];
    type = json['type'];
    salesOfficerId = json['sales_officer_id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    synced = json['synced'] == null
        ? false
        : json['synced'] == 1
            ? true
            : false;

    address = json['address'] ?? '';
    if (address.isEmpty) {
      var street = json['street'] != null ? json['street']['name'] + ', ' : '';
      var area = json['area'] != null ? json['area']['name'] + ', ' : '';
      var district = json['district'] != null ? json['district']['name'] : '';

      address = '$street$area$district';
    }
  }

  Map<String, dynamic> toJson([bool isLocalStorage = false]) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id.toString();
    data['name'] = this.name;
    data['owner_name'] = this.ownerName;
    data['contact'] = this.contact;
    data['type'] = this.type;
    data['synced'] = (this.synced ? 1 : 0).toString();
    data['sales_officer_id'] = this.salesOfficerId.toString();
    data['latitude'] = this.latitude.toString();
    data['longitude'] = this.longitude.toString();
    if (this.address != null) data['address'] = this.address;
    return data;
  }
}

Future<ApiResponse> registerOutlet(Outlet outlet) async {
  var body = outlet.toJson();
  var headers = {
    'Authorization': 'Bearer ' + Get.find<AuthController>().user.apiToken,
    'Accept': 'application/json'
  };

  // try {
  var resp =
      await http.post(Uri.parse(ApiUrls.outlets), headers: headers, body: body);
  Map<String, dynamic> obj = json.decode(resp.body);

  if (resp.statusCode == 200) {
    outlet.synced = true;
    return ApiResponse(obj['success'], obj['message'], null);
  } else {
    return ApiResponse(
        obj['success'] ?? false, obj['message'] ?? 'Unknown error', null);
  }
  // } catch (e) {
  //   print(e.toString());
  //   return ApiResponse(false, e.toString(), null);
  // }
}

Future<ApiResponse<List<Outlet>>> fetchOutletsApi() async {
  var headers = {
    'Authorization': 'Bearer ' + Get.find<AuthController>().user.apiToken,
    'Accept': 'application/json'
  };

  try {
    var res = await http.get(Uri.parse(ApiUrls.outlets), headers: headers);
    Map<String, dynamic> obj = json.decode(res.body);

    if (res.statusCode == 200) {
      final data = obj["data"].cast<Map<String, dynamic>>();
      List<Outlet> outlets = await data.map<Outlet>((json) {
        var out = Outlet.fromJson(json);
        out.synced = true;
        return out;
      }).toList();
      return ApiResponse(true, obj['message'], outlets);
    } else {
      print(obj);
      return ApiResponse(
          obj['success'] ?? false, obj['message'] ?? 'Unknown error', null);
    }
  } catch (e) {
    print(e.toString());
    return ApiResponse(false, e.toString(), null);
  }
}
