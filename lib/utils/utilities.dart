import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_flexible_toast/flutter_flexible_toast.dart';
import 'package:get/get.dart';

class Utilities {
  static double calculateDistance(
      double lat1, double lon1, double lat2, double lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  static Future<bool> isInternetWorking() async {
    bool condition1 = false;
    bool condition2 = false;

    try {
      final result = await InternetAddress.lookup('google.com');

      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        condition1 = true;
      }
    } on SocketException catch (_) {
      condition1 = false;
    }

    //----------------------------------------------------------------------//

    try {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile) {
        condition2 = true;
      } else if (connectivityResult == ConnectivityResult.wifi) {
        condition2 = true;
      } else
        condition2 = false;
    } on SocketException {
      condition2 = false;
    }

    return condition1 & condition2;
  }

  static bool handleStatus(int statusCode) {
    bool res = false;
    switch (statusCode) {
      case HttpStatus.ok:
        res = true;
        break;

      case HttpStatus.internalServerError:
        break;

      case HttpStatus.connectionClosedWithoutResponse:
        //  showInToast("Connection closed.");
        break;

      case HttpStatus.tooManyRequests:
        //  showInToast("Too many requests.");
        break;

      case HttpStatus.requestTimeout:
        //  showInToast("Request time out.");
        break;

      default:
      // showInToast(MessagePrompts.TRY_AGAIN);
    }

    return res;
  }

  static void alertdialog(){

  }
  ///0 is top
  ///
  ///1 is centre
  ///
  ///2 is bottom and default
  static void showInToast(String message,
      {ToastType? toastType, int toastPos = 2}) {
    FlutterFlexibleToast.cancel();
    FlutterFlexibleToast.showToast(
        message: " " + message,
        toastLength: Toast.LENGTH_SHORT,
        toastGravity: toastPos == 2
            ? ToastGravity.BOTTOM
            : toastPos == 1
                ? ToastGravity.CENTER
                : ToastGravity.TOP,
        icon: toastType == null
            ? null
            : toastType == ToastType.ERROR
                ? ICON.ERROR
                : toastType == ToastType.INFO
                    ? ICON.INFO
                    : ICON.SUCCESS,
        radius: 12,
        elevation: 10,
        imageSize: 35,
        textColor: Colors.white,
        fontSize: 14,
        backgroundColor: toastType == null
            ? Colors.black
            : toastType == ToastType.ERROR
                ? Colors.red
                : toastType == ToastType.INFO
                    ? Colors.blue
                    : Colors.green,
        timeInSeconds: 2);
  }

  static showPlatformSpecificAlert(
      {@required String? title,
      @required String? body,
      @required context,
      Function? onDismiss,
      DialogAction? addionalAction,
       Widget? additional,
      bool? canclose = true,
      bool? dismissable}) async {
    return await showDialog(
      barrierDismissible: dismissable == null ? false : dismissable,
      context: context,
      builder: (BuildContext context) {
        return Platform.isIOS
            ? CupertinoAlertDialog(
                title: Text(
                  title!,
                  textAlign: TextAlign.left,
                ),
                content: Text(body!),
                actions: <Widget>[
                  CupertinoDialogAction(
                    child:
                    (additional!)
                         ,
                    onPressed: () {
                      if (onDismiss != null) {
                        onDismiss();
                      }
                      if (canclose!) {
                        Get.back();
                      }
                    },
                  ),
                  if (addionalAction != null)
                    CupertinoDialogAction(
                      child: Text(addionalAction.label!),
                      onPressed: addionalAction.onPressed,
                    )
                ],
              )
            : AlertDialog(
                title: new Text(
                  title!,
                  textAlign: TextAlign.left,
                ),
                content: Text(body!),
                actions: <Widget>[
                  TextButton(
                    child:
                       additional!
                         ,
                    onPressed: () {
                      if (onDismiss != null) {
                        onDismiss();
                      }
                      if (canclose!) {
                        Get.back();
                      }
                    },
                  ),
                  if (addionalAction != null)
                    TextButton(
                      child: Text(addionalAction.label!),
                      onPressed: addionalAction.onPressed,
                    ),
                ],
              );
      },
    );
  }
}

class DialogAction {
  final Function()? onPressed;
  final String? label;

  DialogAction({@required this.label, @required this.onPressed});
}

enum ToastType { INFO, ERROR, SUCCESS }
