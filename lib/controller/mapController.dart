// import 'package:get/get.dart';
//
// class MapCOntroller extends GetxController{
//
//
//   Future<dynamic> fetchOutletsApi() async {
//     var headers = {
//       'Authorization': 'Bearer ' + Get.find<AuthController>().user.apiToken,
//       'Accept': 'application/json'
//     };
//
//     // try {
//     var res = await http.get(
//         Uri.parse(ApiUrls.outlets + Constants.selectedRoute.id.toString()),
//         headers: headers);
//     Map<String, dynamic> obj = json.decode(res.body);
//
//
//     if (res.statusCode == 200) {
//       final data = obj["data"].cast<Map<String, dynamic>>();
//
//       List<Outlet> outlets = await data.map<Outlet>((json) {
//         var out = Outlet.fromJson(json);
//         out.synced = true;
//         return out;
//       }).toSet().toList();
//       return ApiResponse(true, obj['message'], outlets);
//     } else {
//       print(obj);
//       return ApiResponse(
//           obj['success'] ?? false, obj['message'] ?? 'Unknown error', null);
//     }
//     // } catch (e) {
//     //   print(e.toString());
//     //   return ApiResponse(false, e.toString(), null);
//     // }
//   }
// }