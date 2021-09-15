import 'dart:convert';

import 'package:get/get.dart';
import 'package:mobitrack_dv_flutter/controller/auth_controller.dart';
import 'package:mobitrack_dv_flutter/model/resp.dart';
import 'package:http/http.dart' as http;
import 'package:mobitrack_dv_flutter/utils/api_urls.dart';

class MonthlyTourApiData {
  String data;
  String year;
  String month;
  String deviceTime;

  MonthlyTourApiData({this.data, this.year, this.month, this.deviceTime});

  MonthlyTourApiData.fromJson(Map<String, dynamic> json) {
    json["data"] = data;
    json["year"] = year;
    json["month"] = month;
    json["devicetime"] = deviceTime;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonData = Map<String, dynamic>();
    jsonData["data"] = this.data;
    jsonData["year"] = this.year;
    jsonData["month"] = this.month;
    jsonData["devicetime"] = this.deviceTime;

    return jsonData;
  }
}

class MonthlyTour {
  int id;
  String day;
  String date;
  String town;
  String route;
  String nightHalt;
  String contactAddress;
  String stocklistPhone;
  String hotelPhone;

  MonthlyTour({
    this.id,
    this.day,
    this.date,
    this.town,
    this.route,
    this.nightHalt,
    this.contactAddress,
    this.stocklistPhone,
    this.hotelPhone,
  });
}

Future<ApiResponse> postMonthlyTours(
    MonthlyTourApiData monthlyTourApiData) async {
  var body = monthlyTourApiData.toJson();
  var headers = {
    "Accept": "Application/json",
    "Authorization": "Bearer ${Get.find<AuthController>().user.apiToken}"
  };

  try {
    var response = await http.post(Uri.parse(ApiUrls.monthlyTour),
        body: body, headers: headers);

    Map<String, dynamic> obj = json.decode(response.body);

    return ApiResponse(obj["success"], obj["message"], null);
  } catch (e) {
    return ApiResponse(false, e.message, null);
  }
}
