import 'dart:convert';

import 'package:get/get.dart';
import 'package:mobitrack_dv_flutter/controller/auth_controller.dart';
import 'package:mobitrack_dv_flutter/model/resp.dart';
import 'package:mobitrack_dv_flutter/utils/api_urls.dart';
import 'package:http/http.dart' as http;

class
Address {
  int? id;
  String? province;
  String? district;
  String? localLevelEn;
  String? route;

  Address({this.id, this.province, this.district, this.localLevelEn});

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    province = json['province'];
    district = json['district'];
    localLevelEn = json['local_level_en'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['province'] = this.province;
    data['district'] = this.district;
    data['local_level_en'] = this.localLevelEn;
    return data;
  }
}

class Districts {
  int? id;
  int? provinceId;
  String? name;
  List<Areas>? areas;

  Districts({this.id, this.provinceId, this.name, this.areas});

  Districts.fromJson(Map<String, dynamic> json) {
    id = (json['id'] != null) ? json['id'] : '' ;
    provinceId = (json['province_id'] != null) ?json['province_id'] :'';
    name = (json['name'] != null) ? json['name'] : '';
    if (json['areas'] != null) {
      areas = [];
      json['areas'].forEach((v) {
        areas!.add(new Areas.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['province_id'] = this.provinceId;
    data['name'] = this.name;
    if (this.areas != null) {
      data['areas'] = this.areas!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Areas {
  int? id;
  int? districtId;
  String? name;
  List<Streets>? streets;

  Areas({this.id, this.districtId, this.name, this.streets});

  Areas.fromJson(Map<String, dynamic> json) {
    id = (json['id'] != null) ? json['id']: '';
    districtId = (json['district_id'] != null) ? json['district_id'] : '';
    name = (json['name'] != null) ? json['name'] : '';
    if (json['streets'] != null) {
      streets = [];
      json['streets'].forEach((v) {
        streets!.add(new Streets.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['district_id'] = this.districtId;
    data['name'] = this.name;
    if (this.streets != null) {
      data['streets'] = this.streets!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Route{
  int? id;
  String? route_name;

  Route({this.id,this.route_name});
  Route.fromJson(Map<String,dynamic> json){
    id = (json['id'] != null) ? json['id']:'';
    route_name = (json['route_name'] != null) ? json['route_name'] : '';
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['route_name'] = this.route_name;
    return data;
  }
}

class Streets {
  int? id;
  int? areaId;
  String? name;

  Streets({this.id, this.areaId, this.name});

  Streets.fromJson(Map<String, dynamic> json) {
    id = (json['id'] != null) ? json['id'] : '';
    areaId = (json['area_id'] != null) ? json['area_id'] : '' ;
    name = (json['name'] != null) ? json['name'] : '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['area_id'] = this.areaId;
    data['name'] = this.name;
    return data;
  }
}

Future<ApiResponse<List<Address>>> fetchAddressApi() async {
  var headers = {
    'Authorization': 'Bearer ' + Get.find<AuthController>().user.apiToken!,
    'Accept': 'application/json'
  };

  try {
    var res = await http.get(Uri.parse(ApiUrls.address), headers: headers);
    Map<String, dynamic> obj = json.decode(res.body);

    if (res.statusCode == 200) {
      final data = obj["data"].cast<Map<String, dynamic>>();
      List<Address> address = await data.map<Address>((json) {
        return Address.fromJson(json);
      }).toList();
      return ApiResponse(true, obj['message'], address);
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
