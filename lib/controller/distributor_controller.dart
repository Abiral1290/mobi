import 'package:get/get.dart';
import 'package:mobitrack_dv_flutter/model/distributor.dart';
import 'package:mobitrack_dv_flutter/utils/utilities.dart';

class DistributorController extends GetxController {
  List<Distributor> distributorList;
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
