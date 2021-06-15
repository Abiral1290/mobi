import 'package:get/get.dart';
import 'package:mobitrack_dv_flutter/controller/database_controller.dart';
import 'package:mobitrack_dv_flutter/model/outlet.dart';
import 'package:mobitrack_dv_flutter/utils/utilities.dart';

class OutletsController extends GetxController {
  List<Outlet> outletList = [];
  List<Outlet> searchList = [];

  OutletsController() {
    fetchOutlets();
  }

  addOutlet(Outlet o) {
    outletList.add(o);
    update();
  }

  Future<bool> syncData() async {
    var offlineList = outletList.where((element) => !element.synced).toList();
    for (var i = 0; i < offlineList.length; i++) {
      var item = offlineList[i];
      var res = await registerOutlet(item);
      if (res.success) {
        await DatabaseHelper.instance.updateOutlet(item);
        outletList
            .where((element) => element.id == item.id)
            .toList()
            .first
            .synced = true;
        update();
        // await DatabaseHelper.instance.deleteOutlet(item);
        // await DatabaseHelper.instance.insertOutlet(item);
      }
    }
    update();
    return true;
  }

  fetchOutlets() async {
    var conn = await Utilities.isInternetWorking();
    if (conn) {
      await fetchOutletsApi().then((value) async {
        if (value.success) {
          await DatabaseHelper.instance.deleteSyncedOutlet();
          // await DatabaseHelper.instance.clearOutletData();
          // value.response.forEach((o) {
          //   DatabaseHelper.instance.insertOutlet(o);
          // });
          outletList = value.response;
          outletList.forEach((o) {
            DatabaseHelper.instance.insertOutlet(o);
          });
          update();
        } else {
          Utilities.showInToast(value.message, toastType: ToastType.ERROR);
          outletList = [];
          update();
        }
      });
    }

    outletList = await DatabaseHelper.instance.getAllOutletData();
    update();
    print(outletList);
  }

  searchOutlets(String text) {
    if (outletList != null && outletList.isNotEmpty) {
      searchList = outletList
          .where((element) =>
              element.name.toLowerCase().contains(text.toLowerCase()))
          .toList();
      update();
    }
  }
}
