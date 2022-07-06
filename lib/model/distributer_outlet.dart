import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mobitrack_dv_flutter/model/distributor.dart';
import 'package:mobitrack_dv_flutter/model/resp.dart';
import 'package:mobitrack_dv_flutter/utils/api_urls_group.dart';

import '../controller/auth_controller.dart';
import '../utils/api_urls.dart';
import 'package:http/http.dart' as http;

import '../utils/constants.dart';


class Outletss{
  int? id;
  int? outletId;
  String? name;
  String? ownerName;
  String? addressId;
  String? street;
  String? contact;
  String? type;
  String? latitude;
  String? longitude;
  String? salesOfficerId;
  String? createdAt;
  String? updatedAt;
  int? distributorId;
  String? image;
  int? flag;
  String? zone;
  String? town;
  String? route;
  String? channel;
  String? category;
  String? dse;
  String? so;
  String? manager;
  String? visitFrequency;

  bool synced = true;

  Outletss(
      {this.id,
        this.outletId,
        this.name,
        this.ownerName,
        this.addressId,
        this.street,
        this.contact,
        this.type,
        this.latitude,
        this.longitude,
        this.salesOfficerId,
        this.createdAt,
        this.updatedAt,
        this.distributorId,
        this.image,
        this.flag,
        this.zone,
        this.town,
        this.route,
        this.channel,
        this.category,
        this.dse,
        this.so,
        this.manager,
        this.visitFrequency});

  Outletss.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    outletId = json['outlet_id'];
    name = json['name'];
    ownerName = json['owner_name'];
    addressId = json['address_id'];
    street = json['street'];
    contact = json['contact'];
    type = json['type'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    salesOfficerId = json['sales_officer_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    distributorId = json['distributor_id'];
    image = json['image'];
    flag = json['flag'];
    zone = json['zone'];
    town = json['town'];
    route = json['route'];
    channel = json['channel'];
    category = json['category'];
    dse = json['dse'];
    so = json['so'];
    manager = json['manager'];
    visitFrequency = json['visit_frequency'];
    synced = json['synced'] == null
        ? true
        : json['synced'] == "1"
        ? true
        : false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['outlet_id'] = this.outletId;
    data['name'] = this.name;
    data['owner_name'] = this.ownerName;
    data['address_id'] = this.addressId;
    data['street'] = this.street;
    data['contact'] = this.contact;
    data['type'] = this.type;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['sales_officer_id'] = this.salesOfficerId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['distributor_id'] = this.distributorId;
    data['image'] = this.image;
    data['flag'] = this.flag;
    data['zone'] = this.zone;
    data['town'] = this.town;
    data['route'] = this.route;
    data['channel'] = this.channel;
    data['category'] = this.category;
    data['dse'] = this.dse;
    data['so'] = this.so;
    data['manager'] = this.manager;
    data['visit_frequency'] = this.visitFrequency;
    data['synced'] = (this.synced ? 1 : 0).toString();

    return data;
  }
}


class UserApis {
  List<String>? outss;

  static Future<List<Outletss>> getUserSuggestionsa(String query) async {


    var headers = {
      'Authorization': 'Bearer ' + Get.find<AuthController>().user.apiToken!,
      'Accept': 'application/json'
    };
    final url = Uri.parse(ApiUrls.getoutlet);
    //final url_1 = Uri.parse(ApiUrls_Group.getoutlet);
    final response = await http.get(url, headers: headers);
   // final response_1 = await http.get(url_1, headers: headers);
    Map<String, dynamic> obj = json.decode(response.body);

    if (response.statusCode == 200 ) {
      final data = obj["data"].cast<Map<String, dynamic>>();

      List<Outletss> outs = await data.map<Outletss>((json) {
        // var out = Outletss.fromJson(json);
        // out.synced = true;
        // // final nameLower = jso
        // return out.ownerName = query;

        return Outletss.fromJson(json);
      }).toList();
      List.of(outs).where((element) {
        final out = element.name!.toLowerCase();
        final quey = query.toLowerCase();
        return out.contains(quey);
      }).toString();

      return outs;
      //   Outletss.map((json) => Outletss.fromJson(json)).where((user) {
      //   final nameLower = user.name.toLowerCase();
      //   final queryLower = query.toLowerCase();
      //
      //   return nameLower.contains(queryLower);
      // }).toList();
    } else {
      throw Exception();
    }
  }
  static Future<List<Outletss>> getUserSuggestionsaroute(String query) async {

    var headers = {
      'Authorization': 'Bearer ' + Get.find<AuthController>().user.apiToken!,
      'Accept': 'application/json'
    };
    final url = Uri.parse(ApiUrls.getoutlet);
//final url_1 = Uri.parse(ApiUrls_Group.getoutlet);
    final response = await http.get(url, headers: headers);
// final response_1 = await http.get(url_1, headers: headers);
    Map<String, dynamic> obj = json.decode(response.body);

    if (response.statusCode == 200 ) {
      final data = obj["data"].cast<Map<String, dynamic>>();

      List<Outletss> outs = await data.map<Outletss>((json) {
// var out = Outletss.fromJson(json);
// out.synced = true;
// // final nameLower = jso
// return out.ownerName = query;

        return Outletss.fromJson(json);
      }).toList();
      List.of(outs).where((element) {
        final out = element.route!.toLowerCase();
        final quey = query.toLowerCase();
        return out.contains(quey);
      }).toString();

      return outs;
//   Outletss.map((json) => Outletss.fromJson(json)).where((user) {
//   final nameLower = user.name.toLowerCase();
//   final queryLower = query.toLowerCase();
//
//   return nameLower.contains(queryLower);
// }).toList();
    } else {
      throw Exception();
    }
  }
}


Future<ApiResponse<List<Outletss>>> fetchOutlerAp() async {
  var headers = {
    'Authorization': 'Bearer ' + Get.find<AuthController>().user.apiToken!,
    'Accept': 'application/json'
  };

  // try {
  var res = await http.get(Uri.parse(ApiUrls.getoutlet), headers: headers);
  Map<String, dynamic> obj = json.decode(res.body);

  if (res.statusCode == 200) {
    final data = obj["data"].cast<Map<String, dynamic>>();
    List<Outletss> outlet = await data.map<Outletss>((json) {
      return Outletss.fromJson(json);
    }).toList();
    return ApiResponse(true, obj['message'], outlet);
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
