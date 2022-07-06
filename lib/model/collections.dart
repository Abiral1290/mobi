import 'dart:convert';

import 'package:get/get.dart';
import 'package:mobitrack_dv_flutter/controller/auth_controller.dart';
import 'package:mobitrack_dv_flutter/model/resp.dart';
import 'package:mobitrack_dv_flutter/utils/api_urls.dart';
import 'package:http/http.dart' as http;

class Collections {
  int? id;
  int? distributorId;
  String? mode;
  String? bankName;
  String? chequeNo;
  String? chequePhoto;
  int? amount;
  int? salesOfficerId;
  String? accountOf;
  String? remarks;
  String? deviceTime;
  String? createdAt;
  String? updatedAt;
  int? synced;

  Collections(
      {this.id,
      this.distributorId,
      this.mode,
      this.bankName = "",
      this.chequeNo = "",
      this.chequePhoto = "",
      this.amount = 0,
      this.salesOfficerId,
      this.accountOf,
      this.remarks = "",
      this.deviceTime,
      this.createdAt,
      this.updatedAt,
      this.synced});

  Collections.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    distributorId = int.parse(json['distributor_id'].toString());
    mode = json['mode'];
    bankName = json['bank_name'];
    chequeNo = json['cheque_no'];
    chequePhoto = json['cheque_photo'];
    amount = int.parse(json['amount'].toString());
    salesOfficerId = json['sales_officer_id'];
    accountOf = json['account_of'];
    remarks = json['remarks'];
    deviceTime = json['device_time'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    synced = json['synced'] ?? 0;
  }

  Map<String, dynamic> toJson([isLocal = false]) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id.toString();
    data['distributor_id'] = this.distributorId.toString();
    data['mode'] = this.mode.toString();
    data['bank_name'] = this.bankName.toString();
    data['cheque_no'] = this.chequeNo.toString();
    data['cheque_photo'] = this.chequePhoto.toString();
    data['amount'] = this.amount.toString();
    if (!isLocal) data['sales_officer_id'] = this.salesOfficerId.toString();
    data['account_of'] = this.accountOf.toString();
    data['remarks'] = this.remarks.toString();
    data['device_time'] = this.deviceTime.toString();
    data['created_at'] = this.createdAt.toString();
    data['updated_at'] = this.updatedAt.toString();
    if (isLocal) data['synced'] = this.synced;
    return data;
  }
}

Future<ApiResponse<List<Collections>>> fetchCollectionsAPI() async {
  var headers = {
    'Authorization': 'Bearer ' + Get.find<AuthController>().user.apiToken!,
    'Accept': 'application/json'
  };

  try {
    var res = await http.get(Uri.parse(ApiUrls.collections), headers: headers);
    Map<String, dynamic> obj = json.decode(res.body);

    if (res.statusCode == 200) {
      final data = obj["data"].cast<Map<String, dynamic>>();
      List<Collections> collections = await data.map<Collections>((json) {
        var collection = Collections.fromJson(json);
        print(collection);
        collection.synced = 1;
        return collection;
      }).toList();
      return ApiResponse(true, obj['message'], collections);
    } else {
      print(obj);
      return ApiResponse(
          obj['success'] ?? false, obj['message'] ?? 'Unknown error', null!);
    }
  } catch (e) {
    print(e.toString());
    return ApiResponse(false, e.toString(), null!);
  }
}

Future<ApiResponse> storeCollectionAPI(Collections collection) async {
  var body = collection.toJson();

  var headers = {
    'Authorization': 'Bearer ' + Get.find<AuthController>().user.apiToken!,
    'Accept': 'application/json'
  };

  try {
    var resp = await http.post(Uri.parse(ApiUrls.collections),
        headers: headers, body: body);
    Map<String, dynamic> obj = json.decode(resp.body);

    if (resp.statusCode == 200) {
      return ApiResponse(obj['success'], obj['message'], collection);
    } else {
      return ApiResponse(
          obj['success'] ?? false, obj['message'] ?? 'Unknown error', null);
    }
  } catch (e) {
    print(e.toString());
    return ApiResponse(false, e.toString(), null);
  }
}
