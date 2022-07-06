import 'package:get/get.dart';
import 'package:mobitrack_dv_flutter/model/dashboard.dart';

import '../utils/utilities.dart';

class DashBoard_Controller extends GetxController{

  List<DashBoard> dashboard = [];


  DashBoard_Controller(){
    fetchdashboard();
  }

  fetchdashboard() async {

    var conn = await Utilities.isInternetWorking();
    if (conn) {
      await fetchDashboardApi().then((value) async {
        if (value.success!) {
       //   await DatabaseHelper.instance.deleteSyncedOutlet();
          dashboard = value.response!;
          update();
        } else {
          Utilities.showInToast(value.message!, toastType: ToastType.ERROR);
          dashboard = [];
          update();
        }
      });
    }

  }
}