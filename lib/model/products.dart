import 'dart:convert';

import 'package:get/get.dart';
import 'package:mobitrack_dv_flutter/model/resp.dart';
import 'package:http/http.dart' as http;

import '../controller/auth_controller.dart';
import '../utils/api_urls.dart';

class Product {
  int id;
  String name;
  String unit;
  int value;
  bool selected;
  String createdAt;
  String updatedAt;
  List<Batches> batches;

  Product(
      {this.id,
      this.name,
      this.unit,
      this.value,
      this.selected,
      this.createdAt,
      this.updatedAt,
      this.batches});

  Product.fromJson(Map<String, dynamic> json, {bool isLocalDB = false}) {
    id = json['id'];
    name = json['name'];
    unit = json['unit'];
    value = json['value'];
    selected = false;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['batches'] != null) {
      batches = [];

      if (isLocalDB) {
        var data = jsonDecode(json['batches']);
        batches = data.map<Batches>((json) {
          return Batches.fromJson(json);
        }).toList();
      } else {
        json['batches'].forEach((v) {
          batches.add(Batches.fromJson(v));
        });
      }
    }
  }

  bachesAsString() {
    return json.encode(this.batches);
  }

  Map<String, dynamic> toJson({bool isLocalDB = false}) {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['unit'] = this.unit;
    data['value'] = this.value;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.batches != null) {
      if (isLocalDB) {
        data['batches'] = this.bachesAsString();
      } else
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

  Batches.fromJson(
    Map<String, dynamic> json,
  ) {
    id = json['id'];
    productId = json['product_id'];
    expiredAt = json['expired_at'];
    manufacturedAt = json['manufactured_at'];
    stock = json['stock'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
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
  String distributorId;
  String soldAt;
  String outletId;
  String orders;
  String outletLatitude;
  String outletLongitude;
  int id;

  Sales(
      {this.distributorId,
      this.soldAt,
      this.outletId,
      this.orders,
      this.outletLongitude,
      this.outletLatitude,
      this.id});

  Sales.fromJson(Map<String, dynamic> json, [isLocalStorage = false]) {
    distributorId = json['distributor_id'];
    soldAt = json['sold_at'];
    outletId = json['outlet_id'];
    orders = json['orders'];

    if (isLocalStorage) {
      id = json['id'];
      outletLatitude = json["outlet_latitude"];
      outletLongitude = json["outlet_longitude"];
    }
  }

  Map<String, dynamic> toJson([bool isLocalStorage = false]) {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['distributor_id'] = this.distributorId;
    data['sold_at'] = this.soldAt;
    data['outlet_id'] = this.outletId;
    data['orders'] = this.orders;
    if (isLocalStorage) {
      data['id'] = this.id;
      data['outlet_latitude'] = this.outletLatitude;
      data['outlet_longitude'] = this.outletLongitude;
    }

    return data;
  }
}

Future<ApiResponse<List<Product>>> fetchProducts() async {
  var headers = {
    'Authorization': 'Bearer ' + Get.find<AuthController>().user.apiToken,
    'Accept': 'application/json'
  };

  try {
    var res = await http.get(Uri.parse(ApiUrls.products), headers: headers);
    Map<String, dynamic> obj = json.decode(res.body);

    if (res.statusCode == 200) {
      final data = obj["data"].cast<Map<String, dynamic>>();
      List<Product> products = await data.map<Product>((json) {
        return Product.fromJson(json);
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

Future<ApiResponse<Sales>> addStockCountApi(
    String stock, String distributorId, String type) async {
  var body = {
    "stock": stock,
    "type": type,
    "date": DateTime.now().toString(),
    "distributor_id": distributorId,
  };
  var headers = {
    'Authorization': 'Bearer ' + Get.find<AuthController>().user.apiToken,
    'Accept': 'application/json'
  };

  try {
    var resp = await http.post(Uri.parse(ApiUrls.stockCounts),
        headers: headers, body: body);
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

Future<ApiResponse<String>> fetchStockStatus(String distributorId) async {
  var headers = {
    'Authorization': 'Bearer ' + Get.find<AuthController>().user.apiToken,
    'Accept': 'application/json'
  };

  try {
    var res = await http.get(
        Uri.parse(ApiUrls.stockCounts + "?distributor_id=$distributorId"),
        headers: headers);
    Map<String, dynamic> obj = json.decode(res.body);

    if (res.statusCode == 200) {
      final data = obj["data"];

      return ApiResponse(true, obj['message'], data);
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
