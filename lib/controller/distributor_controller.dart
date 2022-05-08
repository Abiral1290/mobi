import 'package:get/get.dart';
import 'package:mobitrack_dv_flutter/model/distributor.dart';
import 'package:mobitrack_dv_flutter/utils/utilities.dart';

class DistributorController extends GetxController {
  List<Distributor> distributorList = [];
  List<Distributor> searchedDistributorList = [];

  DistributorController() {
    fetchDistributor();
  }

  fetchDistributor() {
    fetchDistributorsApi().then((value) {
      if (value.success) {
        distributorList = value.response;
        update();
      } else {
        Utilities.showInToast(value.message, toastType: ToastType.ERROR);
        distributorList = [];
        update();
      }
    });

  }
  Future<bool> syncData() async {
    var offlineList = distributorList.where((element) => !element.synced).toList();
    for (var i = 0; i < offlineList.length; i++) {
      var item = offlineList[i];

      // var res = await fetchDistributorsApi(item);
      // if (res.success) {
      //   await DatabaseHelper.instance.updateOutlet(item);
      //   outletList
      //       .where((element) => element.outid == item.outid)
      //       .toList()
      //       .first
      //       .synced = true;
      //   update();
      // }
    }
    update();
    return true;
  }

  searchDistributor(String text) {
    if (distributorList.isNotEmpty) {
      searchedDistributorList = distributorList
          .where((element) =>
              element.name.toLowerCase().contains(text.toLowerCase()))
          .toList();
      update();
    }
  }
}
