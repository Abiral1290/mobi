import 'dart:convert';

import 'package:get/get.dart';
import 'package:mobitrack_dv_flutter/controller/auth_controller.dart';
import 'package:mobitrack_dv_flutter/model/resp.dart';
import 'package:mobitrack_dv_flutter/utils/api_urls.dart';
import 'package:http/http.dart' as http;

class SalesReport {
  int id;
  int salesOfficerId;
  int distributorId;
  int batchId;
  int productId;
  int quantity;
  String soldAt;
  int outletId;
  String createdAt;
  String updatedAt;

  SalesReport(
      {this.id,
      this.salesOfficerId,
      this.distributorId,
      this.batchId,
      this.productId,
      this.quantity,
      this.soldAt,
      this.outletId,
      this.createdAt,
      this.updatedAt});

  SalesReport.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    salesOfficerId = json['sales_officer_id'];
    distributorId = json['distributor_id'];
    batchId = json['batch_id'];
    productId = json['product_id'];
    quantity = json['quantity'];
    soldAt = json['sold_at'];
    outletId = json['outlet_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sales_officer_id'] = this.salesOfficerId;
    data['distributor_id'] = this.distributorId;
    data['batch_id'] = this.batchId;
    data['product_id'] = this.productId;
    data['quantity'] = this.quantity;
    data['sold_at'] = this.soldAt;
    data['outlet_id'] = this.outletId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

Future<ApiResponse<List<SalesReport>>> fetchSalesReport() async {
  var headers = {
    'Authorization': 'Bearer ' + Get.find<AuthController>().user.apiToken,
    'Accept': 'application/json'
  };

  try {
    var res = await http.get(Uri.parse(ApiUrls.sales), headers: headers);
    Map<String, dynamic> obj = json.decode(res.body);

    if (res.statusCode == 200) {
      final data = obj["data"].cast<Map<String, dynamic>>();
      List<SalesReport> sales = await data.map<SalesReport>((json) {
        return SalesReport.fromJson(json);
      }).toList();
      return ApiResponse(true, obj['message'], sales);
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
