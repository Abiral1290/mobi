import 'package:get/get.dart';
import 'package:mobitrack_dv_flutter/controller/auth_controller.dart';
import 'package:mobitrack_dv_flutter/model/resp.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobitrack_dv_flutter/utils/api_urls.dart';

class AppVersion {
  int versionId;
  String versionName;
  String url;
  String remarks;
  String createdAt;
  String updatedAt;

  AppVersion(
      {this.versionId,
      this.versionName,
      this.url,
      this.remarks,
      this.createdAt,
      this.updatedAt});

  AppVersion.fromJson(Map<String, dynamic> json) {
    versionId = json['id'];
    versionName = json['version'];
    url = ApiUrls.downloadUrl + json['url'];
    remarks = json['remarks'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.versionId;
    data['version'] = this.versionName;
    data['url'] = this.url;
    data['remarks'] = this.remarks;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

Future<ApiResponse<AppVersion>> checkForUpdate() async {
  var headers = {
    'Authorization': 'Bearer ' +
        'UscHS7YoxAfzJ119HuhIQfY4eAt8W9rcetzxDaZ85CnxcJCKpiGpPdxdspeOcHLLX6MifKZfwfWwdRXZ',
    'Accept': 'application/json'
  };

  try {
    var resp =
        await http.get(Uri.parse(ApiUrls.checkForUpdate), headers: headers);
    Map<String, dynamic> obj = json.decode(resp.body);

    if (resp.statusCode == 200) {
      return ApiResponse(
          obj['success'], obj['message'], AppVersion.fromJson(obj['data']));
    } else {
      return ApiResponse(
          obj['success'] ?? false, obj['message'] ?? 'Unknown error', null);
    }
  } catch (e) {
    print(e.toString());
    return ApiResponse(false, e.toString(), null);
  }
}
