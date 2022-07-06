import 'dart:convert';

import 'package:get/instance_manager.dart';
import 'package:http/http.dart' as http;
import 'package:mobitrack_dv_flutter/controller/auth_controller.dart';
import 'package:mobitrack_dv_flutter/model/resp.dart';
import 'package:mobitrack_dv_flutter/utils/api_urls.dart';

class CheckInOut {
  int? id;
  int? salesOfficerId;
  double? checkinLatitude;
  double? checkinLongitude;
  String? createdAt;
  String? updatedAt;
  DateTime? checkinDeviceTime;
  double? checkoutLatitude;
  double? checkoutLongitude;
  DateTime? checkoutDeviceTime;

  /// Check in/out check out time
  String? date;

  CheckInOut(
      {this.id,
      this.salesOfficerId,
      this.checkinLatitude,
      this.checkinLongitude,
      this.createdAt,
      this.updatedAt,
      this.checkinDeviceTime,
      this.checkoutLatitude,
      this.checkoutLongitude,
      this.checkoutDeviceTime,
      this.date});

  CheckInOut.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    salesOfficerId = json['sales_officer_id'];
    checkinLatitude = json['checkin_latitude'];
    checkinLongitude = json['checkin_longitude'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    checkinDeviceTime = json['checkin_device_time'] == null
        ? null
        : DateTime.parse(json['checkin_device_time']);
    checkoutLatitude = json['checkout_latitude'];
    checkoutLongitude = json['checkout_longitude'];
    checkoutDeviceTime = json['checkout_device_time'] == null
        ? null
        : DateTime.parse(json['checkout_device_time']);

    date = checkinDeviceTime != null
        ? "${checkinDeviceTime!.year}-${checkinDeviceTime!.month}-${checkinDeviceTime!.day}"
        : "${checkoutDeviceTime!.year}-${checkoutDeviceTime!.month}-${checkoutDeviceTime!.day}";
    // createdAt = json['created_at'];
    // updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sales_officer_id'] = this.salesOfficerId;
    data['checkin_latitude'] = this.checkinLatitude;
    data['checkin_longitude'] = this.checkinLongitude;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['checkin_device_time'] = this.checkinDeviceTime;
    data['checkout_latitude'] = this.checkoutLatitude;
    data['checkout_longitude'] = this.checkoutLongitude;
    data['checkout_device_time'] = this.checkoutDeviceTime;
  //  data['device_time'] = this.deviceTime.toString();
    return data;
  }
}

Future<ApiResponse<List<CheckInOut>>> fetchcheckDataApi() async {
  var headers = {
    'Authorization': 'Bearer ' + Get.find<AuthController>().user.apiToken!,
    'Accept': 'application/json'
  };

  // try {
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
        obj['success'] ?? false, obj['message'] ?? 'Unknown error', null!);
  }
  // } catch (e) {
  //   print(e.toString());
  //   return ApiResponse(false, e.toString(), null);
  // }
}

Future<ApiResponse<int>> checkInAPI(String lat, String long) async {
  var body = {
    'checkin_latitude': lat,
    'checkin_longitude': long,
    'checkin_device_time': DateTime.now().toString()
  };
  var headers = {
    'Authorization': 'Bearer ' + Get.find<AuthController>().user.apiToken!,
    'Accept': 'application/json'
  };

  try {
    var resp = await http.post(Uri.parse(ApiUrls.checkInOuts),
        headers: headers, body: body);
    Map<String, dynamic> obj = json.decode(resp.body);

    var data = obj["data"];

    if (resp.statusCode == 200) {
      return ApiResponse(obj['success'], obj['message'], data["id"]);
    } else {
      return ApiResponse(
          obj['success'] ?? false, obj['message'] ?? 'Unknown error', null!);
    }
  } catch (e) {
    print(e.toString());
    return ApiResponse(false, e.toString(), null!);
  }
}

Future<ApiResponse> checkOutAPI(String lat, String long, String id) async {
  var body = {
    'checkout_latitude': lat,
    'checkout_longitude': long,
    'checkout_device_time': DateTime.now().toString(),
    'id': id,
  };
  var headers = {
    'Authorization': 'Bearer ' + Get.find<AuthController>().user.apiToken!,
    'Accept': 'application/json'
  };

  try {
    var resp = await http.post(Uri.parse(ApiUrls.checkOut),
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
