// import 'dart:convert';
//
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:mobitrack_dv_flutter/model/resp.dart';
//
// import '../controller/auth_controller.dart';
// import '../utils/api_urls.dart';
// import '';
//
// class ProductBrand {
//   List<ALMONDDRINK> aLMONDDRINK;
//
//   ProductBrand(
//       {this.aLMONDDRINK,
//         });
//
//   ProductBrand.fromJson(Map<String, dynamic> json) {
//     if (json['ALMOND DRINK'] != null) {
//       aLMONDDRINK = <ALMONDDRINK>[];
//       json['ALMOND DRINK'].forEach((v) {
//         aLMONDDRINK.add(new ALMONDDRINK.fromJson(v));
//       });
//     }
//     if (json['CHOCOLATE'] != null) {
//       aLMONDDRINK = <ALMONDDRINK>[];
//       json['CHOCOLATE'].forEach((v) {
//         aLMONDDRINK.add(new ALMONDDRINK.fromJson(v));
//       });
//     }
//     if (json['HALDIRAM PRODUCT'] != null) {
//       aLMONDDRINK = <ALMONDDRINK>[];
//       json['HALDIRAM PRODUCT'].forEach((v) {
//         aLMONDDRINK.add(new ALMONDDRINK.fromJson(v));
//       });
//     }
//     if (json['MALA ITEMS'] != null) {
//       aLMONDDRINK = <ALMONDDRINK>[];
//       json['MALA ITEMS'].forEach((v) {
//         aLMONDDRINK.add(new ALMONDDRINK.fromJson(v));
//       });
//     }
//     if (json['MILK'] != null) {
//       aLMONDDRINK = <ALMONDDRINK>[];
//       json['MILK'].forEach((v) {
//         aLMONDDRINK.add(new ALMONDDRINK.fromJson(v));
//       });
//     }
//     if (json['NESPERS PRODUCT'] != null) {
//       aLMONDDRINK = <ALMONDDRINK>[];
//       json['NESPERS PRODUCT'].forEach((v) {
//         aLMONDDRINK.add(new ALMONDDRINK.fromJson(v));
//       });
//     }
//     if (json['OXFORD BISCUITS'] != null) {
//       aLMONDDRINK = <ALMONDDRINK>[];
//       json['OXFORD BISCUITS'].forEach((v) {
//         aLMONDDRINK.add(new ALMONDDRINK.fromJson(v));
//       });
//     }
//     if (json['PRIYA GOLD'] != null) {
//       aLMONDDRINK = <ALMONDDRINK>[];
//       json['PRIYA GOLD'].forEach((v) {
//         aLMONDDRINK.add(new ALMONDDRINK.fromJson(v));
//       });
//     }
//     if (json['RASNA'] != null) {
//       aLMONDDRINK = <ALMONDDRINK>[];
//       json['RASNA'].forEach((v) {
//         aLMONDDRINK.add(new ALMONDDRINK.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.aLMONDDRINK != null) {
//       data['ALMOND DRINK'] = this.aLMONDDRINK.map((v) => v.toJson()).toList();
//     }
//     if (this.aLMONDDRINK != null) {
//       data['CHOCOLATE'] = this.aLMONDDRINK.map((v) => v.toJson()).toList();
//     }
//     if (this.aLMONDDRINK != null) {
//       data['HALDIRAM PRODUCT'] = this.aLMONDDRINK.map((v) => v.toJson()).toList();
//     }
//     if (this.aLMONDDRINK != null) {
//       data['MALA ITEMS'] = this.aLMONDDRINK.map((v) => v.toJson()).toList();
//     }
//     if (this.aLMONDDRINK != null) {
//       data['MILK'] = this.aLMONDDRINK.map((v) => v.toJson()).toList();
//     }
//     if (this.aLMONDDRINK != null) {
//       data['NESPERS PRODUCT'] = this.aLMONDDRINK.map((v) => v.toJson()).toList();
//     }
//     if (this.aLMONDDRINK != null) {
//       data['OXFORD BISCUITS'] = this.aLMONDDRINK.map((v) => v.toJson()).toList();
//     }
//     if (this.aLMONDDRINK != null) {
//       data['PRIYA GOLD'] = this.aLMONDDRINK.map((v) => v.toJson()).toList();
//     }
//     if (this.aLMONDDRINK != null) {
//       data['RASNA'] = this.aLMONDDRINK.map((v) => v.toJson()).toList();
//     }
//
//     return data;
//   }
// }
//
// class ALMONDDRINK {
//   int id;
//   String name;
//   String unit;
//   String brandName;
//   int value;
//   String catalog;
//   List<String> batches;
//
//   ALMONDDRINK(
//       {this.id,
//         this.name,
//         this.unit,
//         this.brandName,
//         this.value,
//         this.catalog,
//         this.batches});
//
//   ALMONDDRINK.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     unit = json['unit'];
//     brandName = json['brand_name'];
//     value = json['value'];
//     catalog = json['catalog'];
//     // if (json['batches'] != null) {
//     //   batches = <Null>[];
//     //   json['batches'].forEach((v) {
//     //     batches.add(new Null.fromJson(v));
//     //   });
//     // }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['unit'] = this.unit;
//     data['brand_name'] = this.brandName;
//     data['value'] = this.value;
//     data['catalog'] = this.catalog;
//     // if (this.batches != null) {
//     //   data['batches'] = this.batches!.map((v) => v.toJson()).toList();
//     // }
//     return data;
//   }
// }
//
//
// Future<ApiResponse<List<ProductBrand>>> fetchProducts() async {
//   var headers = {
//     'Authorization': 'Bearer ' + Get.find<AuthController>().user.apiToken!,
//     'Accept': 'application/json'
//   };
//
//   try {
//     var res = await http.get(Uri.parse(ApiUrls.products), headers: headers);
//     Map<String, dynamic> obj = json.decode(res.body);
//
//     if (res.statusCode == 200) {
//       final data = obj["data"].cast<Map<String, dynamic>>();
//       List<ProductBrand> products = await data.map<ProductBrand>((json) {
//         return ProductBrand.fromJson(json);
//       }).toList();
//       return ApiResponse(true, obj['message'], products);
//     } else {
//       print(obj);
//       return ApiResponse(
//           obj['success'] ?? false, obj['message'] ?? 'Unknown error', null);
//     }
//   } catch (e) {
//     print(e.toString());
//     return ApiResponse(false, e.toString(), null);
//   }
// }
