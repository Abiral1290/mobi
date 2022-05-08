import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mobitrack_dv_flutter/model/resp.dart';

import '../controller/auth_controller.dart';
import '../utils/api_urls.dart';
import 'package:http/http.dart' as http;

class Channel {
  int id;
  String channel;

  Channel({this.id, this.channel});

  Channel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    channel = json['channel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['channel'] = this.channel;
    return data;
  }
}

Future<ApiResponse<List<Channel>>> fetchChannelApi() async {
  var headers = {
    'Authorization': 'Bearer ' + Get.find<AuthController>().user.apiToken,
    'Accept': 'application/json'
  };

  // try {
  var res = await http.get(
      Uri.parse(ApiUrls.channel  ),
      headers: headers);
  Map<String, dynamic> obj = json.decode(res.body);


  if (res.statusCode == 200) {
    final data = obj["data"].cast<Map<String, dynamic>>();

    List<Channel> channel = await data.map<Channel>((json) {
      var out = Channel.fromJson(json);
      // out.synced = true;
      return out;
    }).toSet().toList();
    return ApiResponse(true, obj['message'], channel);
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