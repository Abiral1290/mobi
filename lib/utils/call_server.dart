import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobitrack_dv_flutter/utils/api_urls.dart';

import 'constants.dart';

Future<String> getCallServerNumber() async {
  var header = {
    'Authorization': 'Bearer ' + Constants.callServerToken,
    'Accept': 'application/json'
  };
  try {
    var resp = await http.get(Uri.parse(ApiUrls.getServerNum), headers: header);
    if (resp.statusCode == 200) {
      var jbody = json.decode(resp.body);
      var num = jbody['data']['server_number'];
      return num;
    } else {
      return '';
    }
  } catch (e) {
    print('❌ Error getting server number');
    print(e.toString());
    return '';
  }
}

Future<bool> callServerVerify(String client, String server) async {
  var header = {
    'Authorization': 'Bearer ' + Constants.callServerToken,
    'Accept': 'application/json'
  };
  try {
    var resp = await http.get(
        Uri.parse(
            ApiUrls.verifyCall + 'mobile_number=$client&server_number=$server'),
        headers: header);
    if (resp.statusCode == 200) {
      var jbody = json.decode(resp.body);
      bool res = jbody['success'];
      return res;
    } else {
      print(resp.body);
      return false;
    }
  } catch (e) {
    print('❌ Error verifying client number');
    print(e.toString());
    return false;
  }
}
