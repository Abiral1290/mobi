// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_speed_dial/flutter_speed_dial.dart';
// import 'package:get/get.dart';
// import 'package:mobitrack_dv_flutter/controller/auth_controller.dart';
// import 'package:mobitrack_dv_flutter/utils/call_server.dart';
// import 'package:mobitrack_dv_flutter/utils/constants.dart';
// import 'package:mobitrack_dv_flutter/utils/utilities.dart';
// import 'package:mobitrack_dv_flutter/view/view_distributor.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// class LoginPage extends StatefulWidget {
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }
//
// class _LoginPageState extends State<LoginPage> {
//   String _callServerNum = '';
//   String _userNUmber = '';
//
//   @override
//   void initState() {
//     super.initState();
//     _initFunc();
//   }
//
//   _initFunc() async {
//     int count = 0;
//     do {
//       var value = await getCallServerNumber();
//       print('call server: ' + value);
//       if (value.isNotEmpty) {
//         setState(() => _callServerNum = value);
//         break;
//       } else {
//         count++;
//       }
//     } while (count < 3);
//     if (count == 3 && _callServerNum.isEmpty) {
//       Utilities.showInToast(
//           "Coundn't fetch call server number. Please try again",
//           toastType: ToastType.ERROR);
//     }
//   }
//
//   byPassCallServer() async {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) => WillPopScope(
//           child: CupertinoAlertDialog(
//             title: new Text("Please Wait"),
//             content: Column(
//               children: [new Text("Logging in."), CupertinoActivityIndicator()],
//             ),
//             actions: <Widget>[],
//           ),
//           onWillPop: () async {
//             return false;
//           }),
//     );
//
//     await Get.find<AuthController>().signIn(_userNUmber);
//     Get.back();
//     Utilities.showInToast(
//       Constants.looged,
//     );
//   }
//   showLoadingandCheckAPIs() async {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) => WillPopScope(
//           child: CupertinoAlertDialog(
//             title: new Text("Please Wait"),
//             content: Column(
//               children: [
//                 new Text("Your call is being validated."),
//                 CupertinoActivityIndicator()
//               ],
//             ),
//             actions: <Widget>[],
//           ),
//           onWillPop: () async {
//             return false;
//           }),
//     );
//
//     await Future.delayed(Duration(seconds: Constants.callWaitSec));
//
//     var res = await callServerVerify_1(_userNUmber, _callServerNum);
//     Get.back();
//
//     if (res) {
//       var resp = await Get.find<AuthController>().signIn_1(_userNUmber);
//       Utilities.showInToast(
//         resp,
//       );
//     } else {
//       showDialog(
//           context: context,
//           barrierDismissible: false,
//           builder: (BuildContext context) => CupertinoAlertDialog(
//             title: new Text("Error"),
//             content: new Text("Session Expired. Please call again"),
//             actions: <Widget>[
//               CupertinoDialogAction(
//                 child: Text('Close'),
//                 onPressed: () => Get.back(),
//               )
//             ],
//           ));
//       Utilities.showInToast("Couldn't validate your number. Please try again",
//           toastType: ToastType.ERROR);
//     }
//   }
//
//   showLoadingandCheckAPI() async {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) => WillPopScope(
//           child: CupertinoAlertDialog(
//             title: new Text("Please Wait"),
//             content: Column(
//               children: [
//                 new Text("Your call is being validated."),
//                 CupertinoActivityIndicator()
//               ],
//             ),
//             actions: <Widget>[],
//           ),
//           onWillPop: () async {
//             return false;
//           }),
//     );
//
//    // await Future.delayed(Duration(seconds: Constants.callWaitSec));
//
//     var res = await callServerVerify(_userNUmber, _callServerNum);
//     Get.back();
//
//     if (res){
//      var resp = await Get.find<AuthController>().signIn(_userNUmber);
//       Utilities.showInToast(
//         resp,
//       );
//     } else {
//       showDialog(
//           context: context,
//           barrierDismissible: false,
//           builder: (BuildContext context) => CupertinoAlertDialog(
//             title: new Text("Error"),
//             content: new Text("Session Expired. Please call again"),
//             actions: <Widget>[
//               CupertinoDialogAction(
//                 child: Text('Close'),
//                 onPressed: () => Get.back(),
//               )
//             ],
//           ));
//       Utilities.showInToast("Couldn't validate your number. Please try again",
//           toastType: ToastType.ERROR);
//     }
//   }
//  // ValueNotifier<bool> isDialOpen = ValueNotifier(false);
//
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.white10,
//           title: Text(Constants.server),
//           leading: IconButton(
//             onPressed: (){
//               Get.back();
//             },icon: Icon(Icons.arrow_back),
//           ),
//         ),
//         floatingActionButton:
//         // _callServerNum.isEmpty
//         //     ? CircularProgressIndicator()
//         //     :
//     //     SpeedDial(
//     //       animatedIcon: AnimatedIcons.home_menu,
//     //       //openCloseDial: isDialOpen,
//     //       backgroundColor: Colors.redAccent,
//     //       overlayColor: Colors.grey,
//     //       overlayOpacity: 0.5,
//     //       spacing: 15,
//     //       spaceBetweenChildren: 15,
//     //       closeManually: false,
//     //       children: [
//     //         // add multiple SpeedDialChild
//     //         SpeedDialChild(
//     //             child: Icon(Icons.call),
//     //             label: 'Server 1',
//     //             backgroundColor: Colors.blue,
//     //             onTap: () async {
//     // if (_userNUmber.length < 10) {
//     //       Utilities.showInToast('Please input 10 digit valid number.',
//     //           toastType: ToastType.ERROR);
//     //     } else {
//     //       var conn = await Utilities.isInternetWorking();
//     //       if (conn) {
//     //         // code to bypass call server
//     //         // byPassCallServer();
//     //         if (_userNUmber == '1122334455'|| _userNUmber == '9860999666') {
//     //           byPassCallServer();
//     //         } else {
//     //           // code to verify call server
//     //           launch('tel:$_callServerNum');
//     //           showLoadingandCheckAPI();
//     //         }
//     //       } else {
//     //         Utilities.showInToast('No internet',
//     //             toastType: ToastType.ERROR);
//     //       }
//     //     }
//     //             }
//     //         ),
//     //         SpeedDialChild(
//     //             child: Icon(Icons.call),
//     //             label: 'Server 2',
//     //             onTap: () async {
//     // if (_userNUmber.length < 10) {
//     //       Utilities.showInToast('Please input 10 digit valid number.',
//     //           toastType: ToastType.ERROR);
//     //     } else {
//     //       var conn = await Utilities.isInternetWorking();
//     //       if (conn) {
//     //         // code to bypass call server
//     //         // byPassCallServer();
//     //         if (_userNUmber == '9988776655'|| _userNUmber == '9851076298') {
//     //           byPassCallServer();
//     //         } else {
//     //           // code to verify call server
//     //           launch('tel:$_callServerNum');
//     //           showLoadingandCheckAPIs();
//     //         }
//     //       } else {
//     //         Utilities.showInToast('No internet',
//     //             toastType: ToastType.ERROR);
//     //       }
//     //     }
//     //             }
//     //         ),
//     //       ],
//     //     ),
//
//         FloatingActionButton(
//           backgroundColor: Colors.green,
//           child: Icon(Icons.call),
//           onPressed: () async {
//     //         if(Constants.server == Constants.server_1){
//     //           FocusScope.of(context).unfocus();
//     //           if (_userNUmber.length < 10) {
//     //             Utilities.showInToast('Please input 10 digit valid number.',
//     //             toastType: ToastType.ERROR);
//     //           } else {
//     //             var conn = await Utilities.isInternetWorking();
//     //             if (conn) {
//     // // code to bypass call server
//     // // byPassCallServer();
//     //           if (_userNUmber == '1122334455'|| _userNUmber == '9860999666') {
//     //             byPassCallServer();
//     //           } else {
//     // // code to verify call server
//     //          launch('tel:$_callServerNum');
//     //          showLoadingandCheckAPI();
//     //           }
//     //             } else {
//     //               Utilities.showInToast('No internet',
//     //               toastType: ToastType.ERROR);
//     //             }
//     //           }
//     //         }else if(Constants.server == Constants.server_2){
//     //           if (_userNUmber.length < 10) {
//     //             Utilities.showInToast('Please input 10 digit valid number.',
//     //                 toastType: ToastType.ERROR);
//     //           } else {
//     //             var conn = await Utilities.isInternetWorking();
//     //             if (conn) {
//     //               // code to bypass call server
//     //               // byPassCallServer();
//     //               if (_userNUmber == '1122334455'|| _userNUmber == '9860999666') {
//     //                 byPassCallServer();
//     //               } else {
//     //                 // code to verify call server
//     //                 launch('tel:$_callServerNum');
//     //                 showLoadingandCheckAPI();
//     //               }
//     //             } else {
//     //               Utilities.showInToast('No internet',
//     //                   toastType: ToastType.ERROR);
//     //             }
//     //           }
//     //         }
//             FocusScope.of(context).unfocus();
//             if (_userNUmber.length < 10) {
//               Utilities.showInToast('Please input 10 digit valid number.',
//                   toastType: ToastType.ERROR);
//             } else {
//     var conn = await Utilities.isInternetWorking();
//     if (conn) {
//       byPassCallServer();
//     // code to bypass call serverflu
//    // if (_userNUmber == '9801146967'|| _userNUmber == '9860999666') {
//    // byPassCallServer();
//     //showLoadingandCheckAPI();
//     //Get.off(ViewDistributorPage());
//    // }
//    //   else {
//    //  // code to verify call server
//    //  launch('tel:$_callServerNum');
//    //     showLoadingandCheckAPI();
//    //   }
//      }
//
//     else {
//     Utilities.showInToast('No internet',
//     toastType: ToastType.ERROR);
//     }
//     }})
// ,        backgroundColor: Colors.white,
//         body: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(22.0),
//               child: CircleAvatar(
//                 backgroundImage: AssetImage('assets/DV_logo.png'),
//                 backgroundColor: Colors.black12,
//                 radius: 80,
//               ),
//             ),
//             Container(
//               alignment: Alignment.center,
//               child: Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: TextField(
//                   onChanged: (s) => _userNUmber = s,
//                   maxLength: 10,
//                   style: TextStyle(fontSize: 25),
//                   keyboardType: TextInputType.number,
//                   inputFormatters: <TextInputFormatter>[
//                     FilteringTextInputFormatter.digitsOnly
//                   ],
//                   decoration: InputDecoration(
//                       labelText: "Phone Number",
//                       prefixText: '+977 ',
//                       prefixIcon: Icon(
//                         Icons.phone_android_rounded,
//                         color: Colors.black,
//                       )),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:mobitrack_dv_flutter/controller/auth_controller.dart';
// import 'package:mobitrack_dv_flutter/utils/call_server.dart';
// import 'package:mobitrack_dv_flutter/utils/constants.dart';
// import 'package:mobitrack_dv_flutter/utils/utilities.dart';
// import 'package:mobitrack_dv_flutter/view/dashboard.dart';
// import 'package:mobitrack_dv_flutter/view/view_distributor.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// class LoginPage extends StatefulWidget {
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }
//
// class _LoginPageState extends State<LoginPage> {
//   String _callServerNum = '';
//   String _userNUmber = '';
//   bool log = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _initFunc();
//   }
//
//   _initFunc() async {
//     int count = 0;
//     do {
//       var value = await getCallServerNumber();
//       print('call server: ' + value);
//       if (value.isNotEmpty) {
//         setState(() => _callServerNum = value);
//         break;
//       } else {
//         count++;
//       }
//     } while (count < 3);
//     if (count == 3 && _callServerNum.isEmpty) {
//       Utilities.showInToast(
//           "Coundn't fetch call server number. Please try again",
//           toastType: ToastType.ERROR);
//     }
//   }
//
//
//
//   byPassCallServer() async {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) => WillPopScope(
//           child: CupertinoAlertDialog(
//             title: new Text("Please Wait"),
//             content: Column(
//               children: [new Text("Logging in."), CupertinoActivityIndicator()],
//             ),
//             actions: <Widget>[],
//           ),
//           onWillPop: () async {
//             return false;
//           }),
//     );
//     var resp = await Get.find<AuthController>().signIn(_userNUmber);
//     Get.back();
//     Utilities.showInToast(
//       resp.toString(),
//     );
//   }
//   // byPassCallServer() async {
//   //   showDialog(
//   //     context: context,
//   //     barrierDismissible: false,
//   //     builder: (BuildContext context) => WillPopScope(
//   //         child: CupertinoAlertDialog(
//   //           title: new Text("Please Wait"),
//   //           content: Column(
//   //             children: [new Text("Logging in."), CupertinoActivityIndicator()],
//   //           ),
//   //           actions: <Widget>[],
//   //         ),
//   //         onWillPop: () async {
//   //           return false;
//   //         }),
//   //   );
//   //   // if( ){
//   //     log = true;
//   //     var resp = await Get.find<AuthController>().signIn(_userNUmber);
//   //     print("202.52.240");
//   //     Utilities.showInToast(
//   //       resp.toString(),
//   //     );
//   //     print("202.52.240.148:");
//   //     Get.to(()=> DashBoard());
//   //     //Get.offAll(View_route());
//   //   // }else if(Constants.server == Constants.server_2 ){
//   //   //   log = true;
//   //   //   var resp = await Get.find<AuthController>().signIn_1(_userNUmber);
//   //   //   print("202.52.240.148:5062/dv_manufacturing/public");
//   //   //   Utilities.showInToast(
//   //   //
//   //   //     resp.toString(),
//   //   //   );
//   //   // }
//   //  // Get.offAll(View_route());
//   // }
//
//   // showLoadingandCheckAPI() async {
//   //   showDialog(
//   //     context: context,
//   //     barrierDismissible: false,
//   //     builder: (BuildContext context) => WillPopScope(
//   //         child: CupertinoAlertDialog(
//   //           title: new Text("Please Wait"),
//   //           content: Column(
//   //             children: [
//   //               new Text("Your call is being validated."),
//   //               CupertinoActivityIndicator()
//   //             ],
//   //           ),
//   //           actions: <Widget>[],
//   //         ),
//   //         onWillPop: () async {
//   //           return false;
//   //         }),
//   //   );
//   //   if(Constants.server ==Constants.server_1){
//   //     await Future.delayed(Duration(seconds: Constants.callWaitSec));
//   //
//   //     var res = await callServerVerify(_userNUmber, _callServerNum);
//   //     Get.back();
//   //
//   //     if (res) {
//   //       var resp = await Get.find<AuthController>().signIn(_userNUmber);
//   //       Utilities.showInToast(
//   //         resp,
//   //       );
//   //     } else {
//   //       showDialog(
//   //           context: context,
//   //           barrierDismissible: false,
//   //           builder: (BuildContext context) => CupertinoAlertDialog(
//   //             title: new Text("Error"),
//   //             content: new Text("Session Expired. Please call again"),
//   //             actions: <Widget>[
//   //               CupertinoDialogAction(
//   //                 child: Text('Close'),
//   //                 onPressed: () => Get.back(),
//   //               )
//   //             ],
//   //           ));
//   //       Utilities.showInToast("Couldn't validate your number. Please try again",
//   //           toastType: ToastType.ERROR);
//   //     }
//   //   }
//   //
//   // }
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         floatingActionButton:
//         // _callServerNum.isEmpty
//         //     ? CircularProgressIndicator()
//         //     :
//         FloatingActionButton(
//           backgroundColor: Colors.green,
//           child: Icon(Icons.call),
//           onPressed: () async {
//             FocusScope.of(context).unfocus();
//             if (_userNUmber.length < 10) {
//               Utilities.showInToast('Please input 10 digit valid number.',
//                   toastType: ToastType.ERROR);
//             } else {
//               var conn = await Utilities.isInternetWorking();
//               if (conn) {
//                 // code to bypass call server
//                  byPassCallServer();
//                  //showLoadingandCheckAPI();
//                 // if (_userNUmber == "9801146967") {
//                 //   byPassCallServer();
//                 // } else {
//                 //   // code to verify call server
//                 //   launch('tel:$_callServerNum');
//                 //   showLoadingandCheckAPI();
//                 // }
//               } else {
//                 Utilities.showInToast('No internet',
//                     toastType: ToastType.ERROR);
//               }
//             }
//           },
//         ),
//         backgroundColor: Colors.white,
//         body: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(22.0),
//               child: CircleAvatar(
//                 backgroundImage: AssetImage('assets/DV_logo.png'),
//                 backgroundColor: Colors.black12,
//                 radius: 80,
//               ),
//             ),
//             Container(
//               alignment: Alignment.center,
//               child: Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: TextField(
//                   onChanged: (s) => _userNUmber = s,
//                   maxLength: 10,
//                   style: TextStyle(fontSize: 25),
//                   keyboardType: TextInputType.number,
//                   inputFormatters: <TextInputFormatter>[
//                     FilteringTextInputFormatter.digitsOnly
//                   ],
//                   decoration: InputDecoration(
//                       labelText: "Phone Number",
//                       prefixText: '+977 ',
//                       prefixIcon: Icon(
//                         Icons.phone_android_rounded,
//                         color: Colors.black,
//                       )),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mobitrack_dv_flutter/controller/auth_controller.dart';
import 'package:mobitrack_dv_flutter/utils/call_server.dart';
import 'package:mobitrack_dv_flutter/utils/constants.dart';
import 'package:mobitrack_dv_flutter/utils/utilities.dart';
import 'package:mobitrack_dv_flutter/view/view_distributor.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _callServerNum = '';
  String _userNUmber = '';

  @override
  void initState() {
    super.initState();
    // _initFunc();
  }

  // _initFunc() async {
  //   int count = 0;
  //   do {
  //     var value = await getCallServerNumber();
  //     print('call server: ' + value);
  //     if (value.isNotEmpty) {
  //       setState(() => _callServerNum = value);
  //       break;
  //     } else {
  //       count++;
  //     }
  //   } while (count < 3);
  //   if (count == 3 && _callServerNum.isEmpty) {
  //     Utilities.showInToast(
  //         "Coundn't fetch call server number. Please try again",
  //         toastType: ToastType.ERROR);
  //   }
  // }

  byPassCallServer() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => WillPopScope(
          child: CupertinoAlertDialog(
            title: new Text("Please Wait"),
            content: Column(
              children: [new Text("Logging in."), CupertinoActivityIndicator()],
            ),
            actions: <Widget>[],
          ),
          onWillPop: () async {
            return false;
          }),
    );

    var resp = await Get.find<AuthController>().signIn(_userNUmber);
    // Get.back();
    // Get.back();
       //if()
 //   var auth = Get.find<AuthController>().isLoggedIn;
       if(resp.success == false){
         Get.back();
         Utilities.showInToast("Not Found", toastType: ToastType.ERROR);
       }else{
         Get.to(View_route());

         Utilities.showInToast(resp.message, toastType: ToastType.SUCCESS);
       }
      // Get.to(View_route());
      // Utilities.showInToast("Login", toastType: ToastType.SUCCESS);


    // Utilities.showInToast(
    //   resp.toString(),
    // );
  }
  //
  // showLoadingandCheckAPI() async {
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) => WillPopScope(
  //         child: CupertinoAlertDialog(
  //           title: new Text("Please Wait"),
  //           content: Column(
  //             children: [
  //               new Text("Your call is being validated."),
  //               CupertinoActivityIndicator()
  //             ],
  //           ),
  //           actions: <Widget>[],
  //         ),
  //         onWillPop: () async {
  //           return false;
  //         }),
  //   );
  //
  //   await Future.delayed(Duration(seconds: Constants.callWaitSec));
  //
  //   var res = await callServerVerify(_userNUmber, _callServerNum);
  //   Get.back();
  //
  //   if (res) {
  //     var resp = await Get.find<AuthController>().signIn(_userNUmber);
  //     Utilities.showInToast(
  //       resp,
  //     );
  //   } else {
  //     showDialog(
  //         context: context,
  //         barrierDismissible: false,
  //         builder: (BuildContext context) => CupertinoAlertDialog(
  //           title: new Text("Error"),
  //           content: new Text("Session Expired. Please call again"),
  //           actions: <Widget>[
  //             CupertinoDialogAction(
  //               child: Text('Close'),
  //               onPressed: () => Get.back(),
  //             )
  //           ],
  //         ));
  //     Utilities.showInToast("Couldn't validate your number. Please try again",
  //         toastType: ToastType.ERROR);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton:
        // _callServerNum.isEmpty
        //     ? CircularProgressIndicator()
        //     :
        FloatingActionButton(
          backgroundColor: Colors.green,
          child: Icon(Icons.call),
          onPressed: () async {
            FocusScope.of(context).unfocus();
            if (_userNUmber.length < 10) {
              Utilities.showInToast('Please input 10 digit valid number.',
                  toastType: ToastType.ERROR);
            } else {
              var conn = await Utilities.isInternetWorking();
              if (conn) {
                // code to bypass call server
                 byPassCallServer();
                // if (_userNUmber ) {
                //   byPassCallServer();
                // } else {
                //   // code to verify call server
                //   // launch('tel:$_callServerNum');
                //   // showLoadingandCheckAPI();
                // }
              } else {
                Utilities.showInToast('No internet',
                    toastType: ToastType.ERROR);
              }
            }
          },
        ),
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(22.0),
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/DV_logo.png'),
                backgroundColor: Colors.black12,
                radius: 80,
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  onChanged: (s) => _userNUmber = s,
                  maxLength: 10,
                  style: TextStyle(fontSize: 25),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration: InputDecoration(
                      labelText: "Phone Number",
                      prefixText: '+977 ',
                      prefixIcon: Icon(
                        Icons.phone_android_rounded,
                        color: Colors.black,
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
