import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobitrack_dv_flutter/controller/auth_controller.dart';
import 'package:mobitrack_dv_flutter/model/app_version.dart';
import 'package:mobitrack_dv_flutter/utils/constants.dart';
import 'package:mobitrack_dv_flutter/utils/downloader.dart';
import 'package:mobitrack_dv_flutter/utils/utilities.dart';
import 'package:mobitrack_dv_flutter/view/credentials/checkauth.dart';
import 'package:path_provider/path_provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    if (Platform.isAndroid) {
      initFunction();
    } else {
      Future.delayed(
          Duration(seconds: 2), () => Get.off(() => CheckAuthPage()));
    }
    super.initState();
  }

  initFunction() async {
    var tempPath = await getTemporaryDirectory();
    var downloadPath = tempPath.path + '/' + Constants.tempApkName;

    //delete previous apk if exists
    var apk = File(downloadPath);
    if (apk.existsSync()) {
      apk.delete();
    }

    var conn = await Utilities.isInternetWorking();
    var auth = Get.find<AuthController>().isLoggedIn;
    if (conn && auth) {
      var resp = await checkForUpdate();
      if (resp.success) {
        if (resp.response.versionId > Constants.appVerId) {
          downloadApk(resp.response.url, downloadPath, context);
        } else {
          Future.delayed(
              Duration(seconds: 2), () => Get.off(() => CheckAuthPage()));
        }
      } else {
        Utilities.showInToast('Failed to check for update.\n' + resp.message);
        Future.delayed(
            Duration(seconds: 2), () => Get.off(() => CheckAuthPage()));
      }
    } else {
      Future.delayed(
          Duration(seconds: 2), () => Get.off(() => CheckAuthPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset("assets/DV_banner.png"),
      ),
    );
  }
}
