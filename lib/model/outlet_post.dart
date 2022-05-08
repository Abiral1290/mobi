import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mobitrack_dv_flutter/model/resp.dart';

import '../controller/auth_controller.dart';
import '../utils/api_urls.dart';
import 'package:http/http.dart' as http;

import '../utils/constants.dart';

class OutletPost{
  int id;
  String outletId;
  String name;
  String ownerName;
  String contact;
  String latitude;
  String longitude;
  String salesOfficer;
 // String image;
  String visitFrequency;
  String townId;
  String routeId;
  String channelId;
  String categoryId;
  String distributorId;
  bool selected;

 bool synced = true;

  OutletPost(
      {this.id,
        this.outletId,
        this.name,
        this.ownerName,
        this.salesOfficer,
        this.contact,
        this.latitude,
        this.longitude,this.distributorId,

   //     this.image,

        this.visitFrequency,
        this.townId,
        this.routeId,
        this.channelId,
        this.categoryId});

  OutletPost.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    outletId = json['outlet_id'];
    name = json['name'];
    ownerName = json['owner_name'];
    contact = json['contact'];
    salesOfficer = json['sales_officer_id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
   // image = json['image'];
    visitFrequency = json['visit_frequency'];
    townId = json['town_id'];
    routeId = json['route_id'];
    channelId = json['channel_id'];
    categoryId = json['category_id'];
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
    data['outlet_id'] = this.outletId;
    data['name'] = this.name;
    data['owner_name'] = this.ownerName;
    data['sales_officer_id'] = this.salesOfficer;
    data['contact'] = this.contact;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;


    //data['image'] = this.image;

    data['visit_frequency'] = this.visitFrequency;
    data['town_id'] = this.townId;
    data['route_id'] = this.routeId;
    data['channel_id'] = this.channelId;
    data['category_id'] = this.categoryId;
    data['distributor_id'] = this.distributorId.toString();

    data['synced'] = (this.synced ? 1 : 0).toString();


    return data;
  }
}


Future<ApiResponse> registerOutletPost(OutletPost outlet) async {
  var body = outlet.toJson();
  var headers = {
    'Authorization': 'Bearer ' + Get
        .find<AuthController>()
        .user
        .apiToken,
    'Accept': 'application/json'
  };

  try {
    var resp = await http.post(Uri.parse(ApiUrls.outlet_post),
        headers: headers, body: body);
    Map<String, dynamic> obj = json.decode(resp.body);

    if (resp.statusCode == 200) {
      // outlet.synced = true;
      return ApiResponse(obj['success'], obj['message'], null);
    } else {
      return ApiResponse(obj['success'] ?? false, obj['message'], null);
    }
  } catch (e) {
    print(e.toString());
    return ApiResponse(false, e.toString(), null);
  }
}

Future<ApiResponse<List<OutletPost>>> fetchOutletsApis() async {
  var headers = {
    'Authorization': 'Bearer ' + Get.find<AuthController>().user.apiToken,
    'Accept': 'application/json'
  };

  // try {
  var res = await http.get(
      Uri.parse(ApiUrls.outlets + Constants.selectedRoute.id.toString()),
      headers: headers);
  Map<String, dynamic> obj = json.decode(res.body);


  if (res.statusCode == 200) {
    final data = obj["data"].cast<Map<String, dynamic>>();

    List<OutletPost> outlets = await data.map<OutletPost>((json) {
      var out = OutletPost.fromJson(json);
      out.synced = true;
      return out;
    }).toSet().toList();
    return ApiResponse(true, obj['message'], outlets);
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