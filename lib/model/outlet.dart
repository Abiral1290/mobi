import 'dart:convert';

import 'package:get/instance_manager.dart';
import 'package:http/http.dart' as http;
import 'package:mobitrack_dv_flutter/controller/auth_controller.dart';
import 'package:mobitrack_dv_flutter/model/resp.dart';
import 'package:mobitrack_dv_flutter/utils/api_urls.dart';
import 'package:mobitrack_dv_flutter/utils/constants.dart';

class Outlet {
  int id;
  String name;
  String ownerName;
  int provinceId;
  int districtId;
  int areaId;
  String street;
  String image;
  String contact;
  String type;
  double latitude;
  double longitude;
  int salesOfficerId;
  String createdAt;
  String updatedAt;
  String distributorId;

  ///flag to check if the outlet is synced with backend
  bool synced = true; //default is true for data fetched from api

  Outlet(
      {this.id,
      this.name,
      this.ownerName,
      this.provinceId,
      this.districtId,
      this.areaId,
      this.street,
      this.image,
      this.contact,
      this.type,
      this.latitude,
      this.longitude,
      this.salesOfficerId,
      this.createdAt,
      this.updatedAt,
      this.distributorId});

  Outlet.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    name = json['name'];
    ownerName = json['owner_name'];
    provinceId = int.parse(json['province_id'].toString());
    districtId = int.parse(json['district_id'].toString());
    areaId = int.parse(json['area_id'].toString());
    street = json['street'].toString();
    image = json["image"];
    contact = json['contact'];
    type = json['type'];
    latitude = double.parse(json['latitude'].toString());
    longitude = double.parse(json['longitude'].toString());
    salesOfficerId = json['sales_officer_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    distributorId = json['distributor_id'].toString();
    synced = json['synced'] == null
        ? true
        : json['synced'] == "1"
            ? true
            : false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id.toString();
    data['name'] = this.name.toString();
    data['owner_name'] = this.ownerName.toString();
    data['province_id'] = this.provinceId.toString();
    data['district_id'] = this.districtId.toString();
    data['area_id'] = this.areaId.toString();
    data['street'] = this.street.toString();
    data["image"] = this.image.toString();
    data['contact'] = this.contact.toString();
    data['type'] = this.type.toString();
    data['latitude'] = this.latitude.toString();
    data['longitude'] = this.longitude.toString();
    data['distributor_id'] = this.distributorId.toString();
    data['synced'] = (this.synced ? 1 : 0).toString();

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
      outlet.synced = true;
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

Future<ApiResponse<List<Outlet>>> fetchOutletsApi() async {
  var headers = {
    'Authorization': 'Bearer ' + Get.find<AuthController>().user.apiToken,
    'Accept': 'application/json'
  };

  try {
    var res = await http.get(
        Uri.parse(
            ApiUrls.outlets + Constants.selectedDistributor.id.toString()),
        headers: headers);
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
