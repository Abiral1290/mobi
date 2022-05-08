// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_state_manager/src/simple/get_state.dart';
// import 'package:mobitrack_dv_flutter/model/outlet.dart';
//
// import '../../controller/outlets_controller.dart';
// import '../../utils/constants.dart';
//
//
//
// class Routes extends StatefulWidget{
//   @override
//   State<StatefulWidget> createState() {
//     // TODO: implement createState
//     return Route();
//   }
//
// }
// class Route extends State<Routes>{
//
//
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return
//     //   ElevatedButton(onPressed: (){
//     //   UserApi.getUserSuggestionsroute();
//     // }, child: Text('press'));
//       FutureBuilder<List<dynamic>>(
//       future:  UserApi.getUserSuggestionsroute(),
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           return Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: ListView.builder(
//               itemCount: snapshot.data.length,
//               itemBuilder: (context, index) {
//                 var route= snapshot.data[index]["route"];
//                 return Card(
//                   shape: RoundedRectangleBorder(
//                     side: BorderSide(
//                       color: Colors.green.shade300,
//                     ),
//                     borderRadius: BorderRadius.circular(15.0),
//                   ),
//                   child: ListTile(
//
//                     title: Text(route),
//
//                   ),
//                 );
//               },
//             ),
//           );
//         }
//         return CircularProgressIndicator();
//       },
//     );
// //       GetBuilder<OutletsController>(
// //       builder: (outletCOntroller){
// //         return Get.find<OutletsController>().outletList.isEmpty
// //             ? Center(
// //           child: Column(
// //             mainAxisAlignment: MainAxisAlignment.center,
// //             children: [
// //               Text("Distributor: " +
// //                   Constants.selectedDistributor.name.toString()),
// //               Text("No outlet found for selected distributor"),
// //             ],
// //           ),
// //         ):
// //             Scrollbar(child: ListView.builder(
// //             itemCount: Get.find<OutletsController>().outletList.length,
// //                 itemBuilder:(context, index){
// //               var list =   Get.find<OutletsController>().outletList;
// //               print(list);
// //               var item=  Get.find<OutletsController>().outletList[index];
// //               return Container(
// //         child: Column(
// //         children: [
// //           Text(item.route)
// //         ],
// //         ),
// //         );
// //
// //                 }
// //             ));
// //
// //
// // });
//   }
// }