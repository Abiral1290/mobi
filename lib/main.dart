import 'package:flutter/services.dart';
import 'package:mobitrack_dv_flutter/utils/constants.dart';
import 'package:yaml/yaml.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobitrack_dv_flutter/controller_bindings.dart';
import 'package:mobitrack_dv_flutter/view/splash_screen.dart';

void main() {
  runApp(MyApp());
  setupAppVer();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'MobiTrack DV',
      initialBinding: ControllerBindings(),
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      home: SplashScreen(),
    );
  }
}

setupAppVer() async {
  var res = await rootBundle.loadString("pubspec.yaml");
  Map yaml = loadYaml(res);
  String ver = yaml['version'];
  Constants.appVerId = int.parse(ver.split('+').last);
  Constants.appVername = (ver.split('+').first);
}
