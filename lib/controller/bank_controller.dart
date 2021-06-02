import 'package:get/get.dart';
import 'package:mobitrack_dv_flutter/controller/database_controller.dart';
import 'package:mobitrack_dv_flutter/model/bank.dart';
import 'package:mobitrack_dv_flutter/utils/utilities.dart';

class BankController extends GetxController {
  List<Bank> bankList;
  DatabaseHelper databaseHelper = DatabaseHelper.instance;

  BankController() {
    getBankListFromAPI();
  }

  getBankListFromAPI() async {
    var conn = await Utilities.isInternetWorking();
    if (conn) {
      await fetchBanks().then((value) async {
        print(value.response);
        await databaseHelper.deleteAllBanks().then((res) {
          if (value.success) {
            for (var data in value.response) {
              databaseHelper.insertBank(data).then((value) => print(value));
            }
          } else {
            Utilities.showInToast(value.message, toastType: ToastType.ERROR);
          }
        });
      });
    }
    databaseHelper.getAllBankData().then((value) {
      if (value != null) {
        bankList = value;
        update();
      } else {
        bankList = [];
        update();
      }
    });
  }
}
