import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mobitrack_dv_flutter/model/resp.dart';

import '../controller/auth_controller.dart';
import '../utils/api_urls.dart';
import 'package:http/http.dart' as http;

class DeleteRequest{
  String? userId;
  String? outletId;
  String? remark;
   String? flag;
  // String updatedAt;
  // String createdAt;
  // int id;

  DeleteRequest(
      {this.userId,
        this.outletId,
        this.remark,
         this.flag,
        // this.updatedAt,
        // this.createdAt,
        // this.id
      });

  DeleteRequest.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    outletId = json['outlet_id'];
    remark = json['remark'];
     flag = json['flag'];
    // updatedAt = json['updated_at'];
    // createdAt = json['created_at'];
    // id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['outlet_id'] = this.outletId;
    data['remark'] = this.remark;
     data['flag'] = this.flag;
    // data['updated_at'] = this.updatedAt;
    // data['created_at'] = this.createdAt;
    // data['id'] = this.id;
    return data;
  }
}


Future<ApiResponse> DeleteOutletPost(DeleteRequest deleteRequest) async {
  var body = deleteRequest.toJson();
  var headers = {
    'Authorization': 'Bearer ' + Get
        .find<AuthController>()
        .user
        .apiToken!,
    'Accept': 'application/json'
  };

  try {
    var resp = await http.post(Uri.parse(ApiUrls.deleteRequest),
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
