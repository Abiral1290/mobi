import 'dart:convert';

import 'package:get/get.dart';
import 'package:mobitrack_dv_flutter/model/resp.dart';
import 'package:http/http.dart' as http;

import '../controller/auth_controller.dart';
import '../utils/api_urls.dart';

class Products {
  int id;
  String name;
  String unit;
  int value;
  String createdAt;
  String updatedAt;
  List<Batches> batches;

  Products(
      {this.id,
      this.name,
      this.unit,
      this.value,
      this.createdAt,
      this.updatedAt,
      this.batches});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    unit = json['unit'];
    value = json['value'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['batches'] != null) {
      batches = [];
      json['batches'].forEach((v) {
        batches.add(Batches.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['unit'] = this.unit;
    data['value'] = this.value;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.batches != null) {
      data['batches'] = this.batches.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Batches {
  int id;
  int productId;
  String expiredAt;
  String manufacturedAt;
  int stock;
  String createdAt;
  String updatedAt;

  Batches(
      {this.id,
      this.productId,
      this.expiredAt,
      this.manufacturedAt,
      this.stock,
      this.createdAt,
      this.updatedAt});

  Batches.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    expiredAt = json['expired_at'];
    manufacturedAt = json['manufactured_at'];
    stock = json['stock'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['expired_at'] = this.expiredAt;
    data['manufactured_at'] = this.manufacturedAt;
    data['stock'] = this.stock;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Sales {
  int distributorId;
  int batchId;
  int productId;
  int quantity;
  String soldAt;
  int outletId;
  int salesOfficerId;
  String updatedAt;
  String createdAt;
  int id;

  Sales(
      {this.distributorId,
      this.batchId,
      this.productId,
      this.quantity,
      this.soldAt,
      this.outletId,
      this.salesOfficerId,
      this.updatedAt,
      this.createdAt,
      this.id});

  Sales.fromJson(Map<String, dynamic> json) {
    distributorId = json['distributor_id'];
    batchId = json['batch_id'];
    productId = json['product_id'];
    quantity = json['quantity'];
    soldAt = json['sold_at'];
    outletId = json['outlet_id'];
    salesOfficerId = json['sales_officer_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson([bool isLocalStorage = false]) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['distributor_id'] = this.distributorId.toString();
    data['batch_id'] = this.batchId.toString();
    data['product_id'] = this.productId.toString();
    data['quantity'] = this.quantity.toString();
    data['sold_at'] = this.soldAt.toString();
    data['outlet_id'] = this.outletId.toString();
    if (isLocalStorage) {
      data['sales_officer_id'] = this.salesOfficerId;
      data['updated_at'] = this.updatedAt;
      data['created_at'] = this.createdAt;
      data['id'] = this.id;
    }

    return data;
  }
}

Future<ApiResponse<List<Products>>> fetchProducts() async {
  var headers = {
    'Authorization': 'Bearer ' + Get.find<AuthController>().user.apiToken,
    'Accept': 'application/json'
  };

  try {
    var res = await http.get(Uri.parse(ApiUrls.products), headers: headers);
    Map<String, dynamic> obj = json.decode(res.body);

    if (res.statusCode == 200) {
      final data = obj["data"].cast<Map<String, dynamic>>();
      List<Products> products = await data.map<Products>((json) {
        return Products.fromJson(json);
      }).toList();
      return ApiResponse(true, obj['message'], products);
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

Future<ApiResponse<Sales>> sellProductApi(Sales sales) async {
  var body = sales.toJson();
  var headers = {
    'Authorization': 'Bearer ' + Get.find<AuthController>().user.apiToken,
    'Accept': 'application/json'
  };

  try {
    var resp =
        await http.post(Uri.parse(ApiUrls.sales), headers: headers, body: body);
    print(resp);
    Map<String, dynamic> obj = json.decode(resp.body);

    if (resp.statusCode == 200) {
      return ApiResponse(obj['success'], obj['message'], null);
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
