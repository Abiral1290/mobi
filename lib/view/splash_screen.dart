import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobitrack_dv_flutter/model/app_version.dart';
import 'package:mobitrack_dv_flutter/utils/constants.dart';
import 'package:mobitrack_dv_flutter/utils/downloader.dart';
import 'package:mobitrack_dv_flutter/utils/utilities.dart';
import 'package:mobitrack_dv_flutter/view/credentials/checkauth.dart';

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
    var conn = await Utilities.isInternetWorking();
    if (conn) {
      var resp = await checkForUpdate();
      if (resp.success) {
        if (resp.response.versionId > Constants.appVerId) {
          await downloadApk(resp.response.url, context, () {});
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
