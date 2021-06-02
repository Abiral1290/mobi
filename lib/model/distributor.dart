import 'dart:convert';

import 'package:get/get.dart';
import 'package:mobitrack_dv_flutter/controller/auth_controller.dart';
import 'package:mobitrack_dv_flutter/model/resp.dart';
import 'package:mobitrack_dv_flutter/utils/api_urls.dart';
import 'package:http/http.dart' as http;

class Distributor {
  int id;
  String name;
  String email;
  String contact;
  String location;
  double latitude;
  double longitude;
  int salesOfficerId;
  String createdAt;
  String updatedAt;

  Distributor(
      {this.id,
      this.name,
      this.email,
      this.contact,
      this.location,
      this.latitude,
      this.longitude,
      this.salesOfficerId,
      this.createdAt,
      this.updatedAt});

  Distributor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'].toString();
    contact = json['contact'].toString();
    location = json['location'].toString();
    latitude = json['latitude'] == null ? 0.0 : json['latitude'].toDouble();
    longitude = json['longitude'] == null ? 0.0 : json['longitude'].toDouble();
    salesOfficerId = json['sales_officer_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['contact'] = this.contact;
    data['location'] = this.location;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['sales_officer_id'] = this.salesOfficerId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

Future<ApiResponse<List<Distributor>>> fetchDistributorsApi() async {
  var headers = {
    'Authorization': 'Bearer ' + Get.find<AuthController>().user.apiToken,
    'Accept': 'application/json'
  };

  // try {
  var res = await http.get(Uri.parse(ApiUrls.distributors), headers: headers);
  Map<String, dynamic> obj = json.decode(res.body);

  if (res.statusCode == 200) {
    final data = obj["data"].cast<Map<String, dynamic>>();
    List<Distributor> distributors = await data.map<Distributor>((json) {
      return Distributor.fromJson(json);
    }).toList();
    return ApiResponse(true, obj['message'], distributors);
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
