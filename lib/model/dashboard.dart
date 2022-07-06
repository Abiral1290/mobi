import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mobitrack_dv_flutter/model/resp.dart';

import '../controller/auth_controller.dart';
import '../utils/api_urls.dart';
import '../utils/constants.dart';
import 'outlet.dart';
import 'package:http/http.dart' as http;



class DashBoard {
  int? totalcall;
  int? productivityCall;
  int? unsuccessCall;
  int? remainingcall;
  String? target_value;
  String? target_month;
  int? orderRecevied;
  String? target;
  int? achivement;

  DashBoard(
      {this.totalcall,
        this.productivityCall,
        this.unsuccessCall,
        this.remainingcall,
        this.target_value,
        this.target_month,
        this.orderRecevied,
        this.target,
        this.achivement});

  DashBoard.fromJson(Map<String, dynamic> json) {
    totalcall = json['totalcall'] == null ? "0":json['totalcall'];
    productivityCall = json['productivity_call'];
    unsuccessCall = json['unsuccess_call'];
    remainingcall = json['remainingcall'];
    target_value = json['value'] == null ? "0" : json['value'] ;
    target_month = json['month']== null ? "0":json['month'];
    orderRecevied = json['orderRecevied'];
    target =  json['target'];
    achivement = json['achivement'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalcall'] = this.totalcall;
    data['productivity_call'] = this.productivityCall;
    data['unsuccess_call'] = this.unsuccessCall;
    data['remainingcall'] = this.remainingcall;
    data['value'] = this.target_value;
    data['month'] = this.target_month;
    data['orderRecevied'] = this.orderRecevied;
    data['target'] = this.target;
    data['achivement'] = this.achivement;
    return data;
  }
}
Future<ApiResponse<List<DashBoard>>> fetchDashboardApi() async {
  var headers = {
    'Authorization': 'Bearer ' + Get.find<AuthController>().user.apiToken!,
    'Accept': 'application/json'
  };

  // try {
  var res = await http.get(
      Uri.parse(ApiUrls.dashboard + Constants.salesoficer_id!),
      headers: headers);
  Map<String, dynamic> obj = json.decode(res.body);
  if (res.statusCode == 200) {
    final data = obj["data"].cast<Map<String, dynamic>>();

    List<DashBoard> dashborad = await data.map<DashBoard>((json) {
      var out = DashBoard.fromJson(json);
  //    out.synced = true;
      return out;
    }).toSet().toList();
    return ApiResponse(true, obj['message'], dashborad);
  } else {
    print(obj);
    return ApiResponse(
        obj['success'] ?? false, obj['message'] ?? 'Unknown error', null!);
  }
  // } catch (e) {
  //   print(e.toString());
  //   return ApiResponse(false, e.toString(), null);
  // }
}