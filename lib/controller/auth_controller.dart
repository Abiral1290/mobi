import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobitrack_dv_flutter/model/sales_officer.dart';
import 'package:mobitrack_dv_flutter/utils/api_urls.dart';
import 'package:mobitrack_dv_flutter/utils/api_urls_group.dart';
//import 'package:mobitrack_dv_flutter/view/credentials/login.dart';

import '../view/credentials/login.dart';
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
        print(_officer.apiToken);
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
      debugPrint(e.toString());
      return 'Unknown error occured';
    }
  }
  Future<dynamic> signIn_1(String phone) async {
    var body = {'phone': phone};
    try {
      final response = await http.post(Uri.parse(ApiUrls_Group.login), body: body);
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
      debugPrint(e.toString());
      return 'Unknown error occured';
    }
  }


  void logout() async {
    await Get.find<PreferenceController>().clear();
    _officer = null;
    isLoggedIn = false;
    update();

    await Get.offAll(LoginPage());
  }
}
