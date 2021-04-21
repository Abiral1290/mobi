import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobitrack_dv_flutter/controller/collections_controller.dart';
import 'package:mobitrack_dv_flutter/utils/utilities.dart';

class ViewCollectionPage extends StatelessWidget {
  bool _lock = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Collections")),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.sync),
          onPressed: () async {
            if (_lock) return;
            var conn = await Utilities.isInternetWorking();
            if (conn) {
              Utilities.showInToast('Syncing Data', toastType: ToastType.INFO);
              await Get.find<CollectionController>().syncCollectionData();
              Utilities.showInToast('Syncing Success',
                  toastType: ToastType.SUCCESS);

              _lock = false;
            } else {
              Utilities.showInToast('No internet services!',
                  toastType: ToastType.INFO);
            }
          },
        ),
        body: GetBuilder<CollectionController>(
          init: CollectionController(),
          builder: (collectionController) {
            return collectionController.collectionsList != null
                ? collectionController.collectionsList.isNotEmpty
                    ? ListView.builder(
                        itemCount: collectionController.collectionsList.length,
                        itemBuilder: (context, index) {
                          var item =
                              collectionController.collectionsList[index];
                          return Card(
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: item.synced == 1
                                    ? Colors.green
                                    : Colors.grey,
                                child: Icon(
                                  item.synced != 1
                                      ? Icons.cloud_off_outlined
                                      : Icons.collections_bookmark,
                                  color: Colors.white,
                                ),
                              ),
                              title: Text("Rs. " + item.amount.toString()),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Divider(),
                                  Text(item.accountOf.toString()),
                                  Text(item.createdAt.split('.').first),
                                  if (item.remarks.isNotEmpty)
                                    Text(item.remarks)
                                ],
                              ),
                              trailing: Text(item.mode),
                            ),
                          );
                        })
                    : Center(child: Text("No Collections Yet!!"))
                : Center(
                    child: CircularProgressIndicator(),
                  );
          },
        ));
  }
}
