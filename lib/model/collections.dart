import 'dart:convert';

import 'package:get/get.dart';
import 'package:mobitrack_dv_flutter/controller/auth_controller.dart';
import 'package:mobitrack_dv_flutter/model/resp.dart';
import 'package:mobitrack_dv_flutter/utils/api_urls.dart';
import 'package:http/http.dart' as http;

class Collection {
  int distributorId;
  String mode;
  String bankName;
  String chequeNo;
  int amount;
  String accountOf;
  String remarks = '';

  Collection(
      {this.distributorId,
      this.mode,
      this.bankName = '',
      this.chequeNo = '',
      this.amount = 0,
      this.accountOf,
      this.remarks = ''});

  Collection.fromJson(Map<String, dynamic> json) {
    distributorId = json['distributor_id'];
    mode = json['mode'];
    bankName = json['bank_name'];
    chequeNo = json['cheque_no'];
    amount = json['amount'];
    accountOf = json['account_of'];
    remarks = json['remarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['distributor_id'] = this.distributorId.toString();
    data['mode'] = this.mode;
    data['bank_name'] = this.bankName;
    data['cheque_no'] = this.chequeNo;
    data['amount'] = this.amount.toString();
    data['account_of'] = this.accountOf;
    data['remarks'] = this.remarks;
    return data;
  }
}

Future<ApiResponse> storeCollectionAPI(Collection collection) async {
  var body = collection.toJson();
  var headers = {
    'Authorization': 'Bearer ' + Get.find<AuthController>().user.apiToken,
    'Accept': 'application/json'
  };

  try {
    var resp = await http.post(Uri.parse(ApiUrls.collections),
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
