import 'package:get/get.dart';
import 'package:mobitrack_dv_flutter/model/app_version.dart';
import 'package:mobitrack_dv_flutter/utils/utilities.dart';

class AppVersion extends GetxController{
  List<AppVersion> appversion= [];

  getAppVersion() async{
    var conn = await Utilities.isInternetWorking();

    if(conn){
      await checkForUpdate().then((value){
       // print(value.response);
        if(value.success!){
        //  print(value.response);
       //   appversion = value.response;
          update();
        }else{
          Utilities.showInToast(value.message!, toastType: ToastType.ERROR);
          appversion =[];
          update();
        }
      });
    }
  }
}