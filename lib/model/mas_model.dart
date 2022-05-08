// import 'package:mobitrack_dv_flutter/model/resp.dart';
// import 'package:mobitrack_dv_flutter/utils/api_urls.dart';
// import 'package:http/http.dart' as http;
//
// Future<ApiResponse> register() async{
//   var body = ;
//
//   try{
//     var reponse = await http.post(Uri.parse(ApiUrls.address));
//     Map<String, dynamic > obj = json.decode(reponse.body);
//
//     if(reponse.statusCode == 200){
//       return ApiResponse(obj['success'], obj["message"], null);
//     }else{
//       return ApiResponse(obj["success"] ?? false , obj['message'], null);
//     }
//   }catch(e){
//     print(e.toString());
//     return ApiResponse(false, e.toString(), null);
//   }
// }