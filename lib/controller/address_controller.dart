import 'dart:convert';

import 'package:get/get.dart';
import 'package:mobitrack_dv_flutter/controller/database_controller.dart';
import 'package:mobitrack_dv_flutter/controller/preference_controller.dart';
import 'package:mobitrack_dv_flutter/model/address.dart';
import 'package:mobitrack_dv_flutter/utils/utilities.dart';

class AddressController extends GetxController {
  List<Address> addressList = [];

  DatabaseHelper databaseHelper = DatabaseHelper.instance;

  AddressController() {
    getAddressList();
  }

  getAddressList() async {
    var conn = await Utilities.isInternetWorking();
    if (conn) {
      // await fetchAddressApi().then((value) async {
      //   print(value.response);
      //   if (value.success) {
      //     addressList = value.response;
      //     update();
      //   }
      // });
      await fetchAddressApi().then((value) async {
        print(value.response);
        if (value.success) {
          print(value.response);
          Get.find<PreferenceController>()
              .saveAddress(jsonEncode(value.response));
        }
      });
    }
    Get.find<PreferenceController>().getAddress().then((value) {
      if (value != null) {
        var data = jsonDecode(value);
        // addressList = jsonDecode(value);
        addressList = data.map<Address>((json) {
          return Address.fromJson(json);
        }).toList();
        print(value);
        update();
      } else {
        addressList = [];
        update();
      }
    });
    print(addressList);
  }
}
