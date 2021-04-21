import 'dart:convert';

import 'package:get/instance_manager.dart';
import 'package:http/http.dart' as http;
import 'package:mobitrack_dv_flutter/controller/auth_controller.dart';
import 'package:mobitrack_dv_flutter/model/resp.dart';
import 'package:mobitrack_dv_flutter/utils/api_urls.dart';

class CheckInOut {
  int id;
  int salesOfficerId;
  String checkType;
  double latitude;
  double longitude;
  // String createdAt;
  // String updatedAt;

  /// Check in/out check out time
  DateTime deviceTime;

  CheckInOut(
      {this.id,
      this.salesOfficerId,
      this.checkType,
      this.latitude,
      this.longitude,
      // this.createdAt,
      // this.updatedAt,
      this.deviceTime});

  CheckInOut.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    salesOfficerId = json['sales_officer_id'];
    checkType = json['check_type'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    deviceTime = DateTime.parse(json['device_time']);
    // createdAt = json['created_at'];
    // updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sales_officer_id'] = this.salesOfficerId;
    data['check_type'] = this.checkType;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['device_time'] = this.deviceTime.toString();
    return data;
  }
}

Future<ApiResponse<List<CheckInOut>>> fetchcheckDataApi() async {
  var headers = {
    'Authorization': 'Bearer ' + Get.find<AuthController>().user.apiToken,
    'Accept': 'application/json'
  };

  try {
    var res = await http.get(Uri.parse(ApiUrls.checkInOuts), headers: headers);
    Map<String, dynamic> obj = json.decode(res.body);

    if (res.statusCode == 200) {
      final data = obj["data"].cast<Map<String, dynamic>>();
      List<CheckInOut> checkData = await data.map<CheckInOut>((json) {
        return CheckInOut.fromJson(json);
      }).toList();
      return ApiResponse(true, obj['message'], checkData);
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