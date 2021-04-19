import 'package:get/get.dart';
import 'package:mobitrack_dv_flutter/controller/database_controller.dart';
import 'package:mobitrack_dv_flutter/model/collections.dart';
import 'package:mobitrack_dv_flutter/utils/utilities.dart';

class CollectionController extends GetxController {
  List<Collections> collectionsList;
  DatabaseHelper databaseHelper = DatabaseHelper.instance;

  CollectionController() {
    fetchCollections();
  }

  fetchCollections() {
    fetchCollectionsAPI().then((value) {
      if (value.success) {
        collectionsList = value.response;
        update();
      } else {
        collectionsList = [];
        update();
        print(value.message);
        // Utilities.showInToast(value.message, toastType: ToastType.ERROR);
      }
    });
    databaseHelper.getAllCollectionData().then((value) {
      if (value.isNotEmpty) {
        for (var data in value) {
          collectionsList.add(data);
        }
        update();
      }
    });
  }

  Future<bool> syncCollectionData() async {
    for (var data
        in collectionsList.where((element) => element.synced == 0).toList()) {
      // var item = collectionsList[i];
      var res = await storeCollectionAPI(data);
      if (res.success) {
        await DatabaseHelper.instance.deleteCollection(data);
        fetchCollections();
      }
    }
    update();
    return true;
  }

  storeCollection(Collections collection) {
    if (collectionsList == null) {
      collectionsList = [];
    }
    storeCollectionAPI(collection).then((value) {
      if (value.success) {
        Utilities.showInToast('Collection Uploaded succesfully',
            toastType: ToastType.SUCCESS);

        collectionsList.add(value.response);
        update();
        Get.back();
      } else {
        print(value.message);
        Utilities.showInToast(value.message, toastType: ToastType.ERROR);
      }
    });
  }

  storeOfflineCollection(Collections collection) {
    if (collectionsList == null) {
      collectionsList = [];
    }
    databaseHelper.insertCollection(collection).then((value) {
      if (value) {
        collectionsList.add(collection);
        update();
        Utilities.showInToast('Collection stored locally',
            toastType: ToastType.SUCCESS);
        Get.back();
      } else {
        Utilities.showInToast("Error", toastType: ToastType.ERROR);
      }
    });
  }
}
