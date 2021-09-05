import 'dart:convert';

import 'package:get/get.dart';
import 'package:mobitrack_dv_flutter/controller/auth_controller.dart';
import 'package:mobitrack_dv_flutter/controller/preference_controller.dart';
import 'package:mobitrack_dv_flutter/model/resp.dart';
import 'package:http/http.dart' as http;
import 'package:mobitrack_dv_flutter/utils/api_urls.dart';

class LocationModel {
  String longitude;
  String latitude;
  String checkinoutId;
  String outletId;
  // int userId;
  String date;
  // String updatedAt;
  // String createdAt;
  String id;

  LocationModel(
      {this.longitude,
      this.latitude,
      this.checkinoutId,
      this.outletId,
      // this.userId,
      this.date,
      // this.updatedAt,
      // this.createdAt,
      this.id});

  LocationModel.fromJson(Map<String, dynamic> json) {
    longitude = json['longitude'];
    latitude = json['latitude'];
    checkinoutId = json['checkinout_id'];
    outletId = json['outlet_id'];
    // userId = json['user_id'];
    date = json['date'];
    // updatedAt = json['updated_at'];
    // createdAt = json['created_at'];
    id = json['id'].toString();
  }

  Map<String, dynamic> toJson(bool inOutlet) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['checkinout_id'] = this.checkinoutId;
    if (inOutlet) data['outlet_id'] = this.outletId;
    // data['user_id'] = this.userId;
    data['date'] = this.date;
    // data['updated_at'] = this.updatedAt;
    // data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}

Future<ApiResponse> postLocationApi(
  LocationModel locationModel,
  bool inOutlet,
) async {
  var body = locationModel.toJson(inOutlet);
  var headers = {
    'Accept': 'application/json',
    'Authorization': 'Bearer ' + Get.find<AuthController>().user.apiToken,
  };

  try {
    var resp = await http.post(Uri.parse(ApiUrls.dailyLocation),
        headers: headers, body: body);

    Map<String, dynamic> obj = json.decode(resp.body);

    if (obj["success"]) {
      
    }
    return ApiResponse(obj["success"], obj["message"], null);
  } catch (e) {
    print(e.toString());
    return ApiResponse(false, "Error occured", null);
  }
}
