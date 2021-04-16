import 'dart:convert';

import 'package:get/get.dart';
import 'package:mobitrack_dv_flutter/model/resp.dart';
import 'package:mobitrack_dv_flutter/model/sales_officer.dart';
import 'package:mobitrack_dv_flutter/utils/api_urls.dart';

import 'preference_controller.dart';
import 'package:http/http.dart' as http;

class AuthController extends GetxController {
  bool isLoggedIn = false;
  SalesOfficer _officer;
  SalesOfficer get user => _officer;

  AuthController() {
    getLoggedInData();
  }

  getLoggedInData() {
    Get.find<PreferenceController>().getUser().then((value) {
      if (value != null) {
        isLoggedIn = true;
        _officer = SalesOfficer.fromJson(json.decode(value));
        print(_officer.toJson());
        update();
      }
    });
  }

  Future<dynamic> signIn(String phone) async {
    var body = {'phone': phone};
    try {
      final response = await http.post(Uri.parse(ApiUrls.login), body: body);
      Map<String, dynamic> obj = json.decode(response.body);
      if (obj.containsKey('success')) {
        if (obj['success']) {
          Get.find<PreferenceController>().saveUser(json.encode(obj['data']));
          isLoggedIn = true;
          _officer = SalesOfficer.fromJson(obj['data']);
          update();
          return SalesOfficer.fromJson(obj['data']);
        }
        return obj['message'];
      } else {
        return 'Unknown error occured';
      }
    } catch (e) {
      print('Error logging in');
      print(e.toString());
      return 'Unknown error occured';
    }
  }

  Future<ApiResponse> checkInOut(String type, String lat, String long) async {
    var body = {'check_type': type, 'latitude': lat, 'longitude': long};
    var headers = {
      'Authorization': 'Bearer ' + Get.find<AuthController>().user.apiToken,
      'Accept': 'application/json'
    };

    try {
      var resp = await http.post(Uri.parse(ApiUrls.checkInOuts),
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

  void logout() async {
    await Get.find<PreferenceController>().clear();
    _officer = null;
    isLoggedIn = false;
    update();
  }
}
