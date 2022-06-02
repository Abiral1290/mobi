import 'dart:convert';

import 'package:get/instance_manager.dart';
import 'package:http/http.dart' as http;
import 'package:mobitrack_dv_flutter/controller/auth_controller.dart';
import 'package:mobitrack_dv_flutter/model/resp.dart';
import 'package:mobitrack_dv_flutter/utils/api_urls.dart';
import 'package:mobitrack_dv_flutter/utils/constants.dart';
import 'package:equatable/equatable.dart';

import 'distributer_outlet.dart';

class Outlets {
  int id;
  int outletId;
  String name;
  String ownerName;
  String addressId;
  String street;
  String contact;
  double latitude;
  double longitude;
  String salesOfficerId;
  String createdAt;
  String updatedAt;
  int distributorId;
  String image;
  int flag;
  String visitFrequency;
  int townId;
  int routeId;
  int channelId;
  int categoryId;

  Outlets(
      {this.id,
        this.outletId,
        this.name,
        this.ownerName,
        this.addressId,
        this.street,
        this.contact,
        this.latitude,
        this.longitude,
        this.salesOfficerId,
        this.createdAt,
        this.updatedAt,
        this.distributorId,
        this.image,
        this.flag,
        this.visitFrequency,
        this.townId,
        this.routeId,
        this.channelId,
        this.categoryId});

  Outlets.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    outletId = json['outlet_id'];
    name = json['name'];
    ownerName = json['owner_name'];
    addressId = json['address_id'];
    street = json['street'];
    contact = json['contact'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    salesOfficerId = json['sales_officer_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    distributorId = json['distributor_id'];
    image = json['image'];
    flag = json['flag'];
    visitFrequency = json['visit_frequency'];
    townId = json['town_id'];
    routeId = json['route_id'];
    channelId = json['channel_id'];
    categoryId = json['category_id'];


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['outlet_id'] = this.outletId;
    data['name'] = this.name;
    data['owner_name'] = this.ownerName;
    data['address_id'] = this.addressId;
    data['street'] = this.street;
    data['contact'] = this.contact;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['sales_officer_id'] = this.salesOfficerId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['distributor_id'] = this.distributorId;
    data['image'] = this.image;
    data['flag'] = this.flag;
    data['visit_frequency'] = this.visitFrequency;
    data['town_id'] = this.townId;
    data['route_id'] = this.routeId;
    data['channel_id'] = this.channelId;
    data['category_id'] = this.categoryId;
    return data;
  }
}

class Outlet  {
  int id;
  int outid;
  String name;
  String ownerName;
  String addressId;
  String street;
  String image;
  String contact;
  String type;
  String latitude;
  String longitude;
  String town_id;
  String route_id;
  String channel_id;
  String category_id;
  String visitfrequency;
  String createdAt;
  String updatedAt;
  String distributorId;
  bool selected;


 // String visitfrequency;



  ///flag to check if the outlet is synced with backend
  bool synced = true; //default is true for data fetched from api

  Outlet(
      {
        this.id,
      this.outid,
      this.name,
      this.ownerName,
      this.addressId,
      this.street,
      this.image,
      this.contact,
      this.type,
      this.latitude,
      this.longitude,
       // this.visitfrequency,
      this.createdAt,
      this.updatedAt,
      this.distributorId,
      this.route_id,
        this.town_id,
        this.category_id,
        this.channel_id,
        this.selected,
      this.visitfrequency,
      });

  Outlet.fromJson(Map<String, dynamic> json) {
    id =  json['id'] ;
    outid =  (json['outlet_id'] );
    name = json['name'];
    ownerName = json['owner_name'];
    addressId = json['address_id'].toString();
    street = json['street'].toString();
    selected = false;
    image = json["image"];
    contact = json['contact'];
    type = json['type'];
    latitude =  (json['latitude']) ;
   longitude =   (json['longitude'])  ;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
   distributorId = json['distributor_id'].toString();
    selected = false;
    town_id = json['town_id'].toString();
    route_id = json['route_id'].toString();
    channel_id = json['channel_id'].toString();
    category_id = json['category_id'].toString();
   visitfrequency =json["visit_frequency"].toString();

    synced = json['synced'] == null
        ? true
        : json['synced'] == "1"
            ? true
            : false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id.toString();
    data['outlet_id'] = this.outid.toString();
    data['name'] = this.name.toString();
    data['owner_name'] = this.ownerName.toString();
    data["image"] = this.image.toString();
    data['contact'] = this.contact.toString();

    data['latitude'] = this.latitude.toString();
    data['longitude'] = this.longitude.toString();
    data['distributor_id'] = this.distributorId.toString();

    data['town_id'] = this.town_id.toString();
    data['route_id'] = this.route_id.toString();
    data['channel_id'] = this.channel_id.toString();
    data['category_id'] = this.category_id.toString();
    data['visiting frequency'] = this.visitfrequency.toString();

    data['synced'] = (this.synced ? 1 : 0).toString();

    return data;
  }
}

class UserApi{


  List<String> outss;
  // static Future<List<Outlet>> getOutletSuggestions(String query) async {
  //   final url = Uri.parse(ApiUrls.outlets  + Constants.selectedDistributor.id.toString());
  //   final response = await http.get(url);
  //
  //   if (response.statusCode == 200) {
  //     final Map<String, dynamic> users = json.decode(response.body);
  //
  //     return
  //        List<Outlet> user = users.map((e, value) => Outlet.fromJson(json)).
  //
  //       users.map((json) => Outlet.fromJson(json)).where((user) {
  //       final nameLower = user.name.toLowerCase();
  //       final queryLower = query.toLowerCase();
  //
  //       return nameLower.contains(queryLower);
  //     }).toList();
  //   } else {
  //     throw Exception();
  //   }
  // }
  static Future<List<Outlet>> getUserSuggestionsa(String query) async {
    //
    var headers = {
      'Authorization': 'Bearer ' + Get.find<AuthController>().user.apiToken,
      'Accept': 'application/json'
    };
    final url = Uri.parse(ApiUrls.outlets  + Constants.selectedRoute.id.toString() );
    //final url_1 = Uri.parse(ApiUrls_Group.getoutlet);
    final response = await http.get(url, headers: headers);
    // final response_1 = await http.get(url_1, headers: headers);
    Map<String, dynamic> obj = json.decode(response.body);

    if (response.statusCode == 200 ) {
      final data = obj["data"].cast<Map<String, dynamic>>();
      // final routenames = obj['routenames'].cast<Map<String,dynamic>>();
      // final catagories = obj['categories'].cast<Map<String,dynamic>>();
      // final channels = obj['categories'].cast<Map<String,dynamic>>();
      // final town= obj['towns'].cast<Map<String,dynamic>>();
      // final zones = obj['zones'].cast<Map<String,dynamic>>();

      List<Outlet> out= await data.map<Outlet>((json) {
        // var out = Outletss.fromJson(json);
        // out.synced = true;
        // // final nameLower = jso
        // return out.ownerName = query;

        return Outlet.fromJson(json);
      }).toList();

      List<Outlet> outss =out.where((element) {
        //if (element.name == Constants.selectedOutlets.name) {
          final out = element.name.toLowerCase();
          // outlet_town.where((element) {
          //   final town = element.town;
          //
          //   return town;
          // }
          // );
          //Constants.selectedOutlets.name.toLowerCase();
          final quey = query.toLowerCase();
         // print(out);
        //  Constants.selectedOutlets.name = element.name.toLowerCase();
          return out.contains(quey);
        //} else {
          //element.route;
        //}
      }).toList();
      return outss;
    }
  }

  static Future<List<Outlet>> getlist(String query)async{
    final outl = Constants.selectedOutlets.name;
  }
  static Future<List<Outlet>> getUserSuggestionsroute() async {
    final url = Uri.parse(ApiUrls.outlets  + Constants.selectedRoute.id.toString());
    final response = await http.get(url);
    Map<String, dynamic> obj = json.decode(response.body);

    if (response.statusCode == 200) {
      final data = obj["data"].cast<Map<String, dynamic>>();

      List<Outlet> outlets = await data.map<Outlet>((json) {
        var out = Outlet.fromJson(json);
        out.synced = true;
        return out;
      }).toList();
      print(outlets.length);
      return outlets;
      //   Outlets.map((json) => Outlet.fromJson(json)).where((user) {
      //   final nameLower = user.name.toLowerCase();
      //   final queryLower = query.toLowerCase();
      //
      //   return nameLower.contains(queryLower);
      // }).toList();
    } else {
      throw Exception();
    }
  }
}

// Future<ApiResponse> registerOutlet(Outlet outlet) async {
//   var body = outlet.toJson();
//   var headers = {
//     'Authorization': 'Bearer ' + Get
//         .find<AuthController>()
//         .user
//         .apiToken,
//     'Accept': 'application/json'
//   };
//
//   try {
//     var resp = await http.post(Uri.parse(ApiUrls.outlet_post),
//         headers: headers, body: body);
//     Map<String, dynamic> obj = json.decode(resp.body);
//
//     if (resp.statusCode == 200) {
//       // outlet.synced = true;
//       return ApiResponse(obj['success'], obj['message'], null);
//     } else {
//       return ApiResponse(obj['success'] ?? false, obj['message'], null);
//     }
//   } catch (e) {
//     print(e.toString());
//     return ApiResponse(false, e.toString(), null);
//   }
// }

Future<ApiResponse> registerOutlet(Outlet outlet) async {
  var body = outlet.toJson();
  var headers = {
    'Authorization': 'Bearer ' + Get.find<AuthController>().user.apiToken,
    'Accept': 'application/json'
  };

  try {
    var resp = await http.post(Uri.parse(ApiUrls.outlet_post),
        headers: headers, body: body);
    Map<String, dynamic> obj = json.decode(resp.body);

    if (resp.statusCode == 200) {
      outlet.synced = true;
      return ApiResponse(obj['success'], obj['message'], null);
    } else {
      return ApiResponse(obj['success'] ?? false, obj['message'], null);
    }
  } catch (e) {
    print(e.toString());
    return ApiResponse(false, e.toString(), null);
  }
}

Future<ApiResponse<List<Outlet>>> fetchOutletsApi() async {
  var headers = {
    'Authorization': 'Bearer ' + Get.find<AuthController>().user.apiToken,
    'Accept': 'application/json'
  };

  // try {
  var res = await http.get(
      Uri.parse(ApiUrls.outlets + Constants.selectedRoute.id.toString()),
      headers: headers);
  Map<String, dynamic> obj = json.decode(res.body);


  if (res.statusCode == 200) {
    final data = obj["data"].cast<Map<String, dynamic>>();

    List<Outlet> outlets = await data.map<Outlet>((json) {
      var out = Outlet.fromJson(json);
      out.synced = true;
      return out;
    }).toSet().toList();
    return ApiResponse(true, obj['message'], outlets);
  } else {
    print(obj);
    return ApiResponse(
        obj['success'] ?? false, obj['message'] ?? 'Unknown error', null);
  }
  // } catch (e) {
  //   print(e.toString());
  //   return ApiResponse(false, e.toString(), null);
  // }
}
// Future<ApiResponse<List<Outlet>>> fetchOutletsApi() async {
//   var headers = {
//     'Authorization': 'Bearer ' + Get.find<AuthController>().user.apiToken,
//     'Accept': 'application/json'
//   };
//
//   // try {
//   var res = await http.get(
//       Uri.parse(ApiUrls.outlets + Constants.selectedDistributor.id.toString()),
//       headers: headers);
//   Map<String, dynamic> obj = json.decode(res.body);
//
//   if (res.statusCode == 200) {
//     final data = obj["data"].cast<Map<String, dynamic>>();
//     List<Outlet> outlets = await data.map<Outlet>((json) {
//       var out = Outlet.fromJson(json);
//       out.synced = true;
//       return out;
//     }).toSet().toList();
//     return ApiResponse(true, obj['message'], outlets);
//   } else {
//     print(obj);
//     return ApiResponse(
//         obj['success'] ?? false, obj['message'] ?? 'Unknown error', null);
//   }
//   // } catch (e) {
//   //   print(e.toString());
//   //   return ApiResponse(false, e.toString(), null);
//   // }
// }

