

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobitrack_dv_flutter/controller/database_controller.dart';
import 'package:mobitrack_dv_flutter/controller/preference_controller.dart';
import 'package:mobitrack_dv_flutter/controller/productbrand_controller.dart';
import 'package:mobitrack_dv_flutter/model/products.dart';
import 'package:mobitrack_dv_flutter/model/punched.dart';
import 'package:mobitrack_dv_flutter/utils/constants.dart';

import '../../utils/utilities.dart';

class PunchedProduct extends StatelessWidget{
  List<String> punched;

  PunchedProduct ({Key key, this.punched}) : super(key: key);

  var selectedProduct = [].obs;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          selectedProduct.add({
            "product_id": Get.find<ProductBrandController>().selectedAreaId,
            "batch_id": "",
            "quantity": Get.find<ProductBrandController>().quantity,
            "discount": "0"
          });
          print(selectedProduct);
          var sales = Sales(
            route: Constants.selectedRoute.id.toString(),
            orders: jsonEncode(selectedProduct),
            soldAt:
            DateTime.now().toString(),
            remark: "",
            outletId: "12",
            latitude: "27.323",
            longitude:   "87.32",
          );
          print(sales);
          var response = await sellProductApi(sales);
          Utilities.showInToast(response.message,
              toastType: response.success
                  ? ToastType.SUCCESS
                  : ToastType.ERROR);
         // punched.remove();
          },
        child:  Text("Press"),
      ),
      body:  Container(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: punched.length,
            itemBuilder: (context, index) {
          return ListTile(
            title: Text(punched[index]),
            subtitle: Text(Get.find<ProductBrandController>().quantity.first),
          );
        }),
        ),
      );
      // ListView.builder(
      //   itemCount:  role.length,
      //     itemBuilder: (context, index) {
      //     return ListTile(
      //       title:  role[index],
      //     );
      // })
  }
  
}