import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobitrack_dv_flutter/controller/outlets_controller.dart';
import 'package:mobitrack_dv_flutter/utils/utilities.dart';

class ViewOutletsPage extends StatelessWidget {
  bool _lock = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.sync),
          onPressed: () async {
            if (_lock) return;
            var conn = await Utilities.isInternetWorking();
            if (conn) {
              Utilities.showInToast('Syncing Data', toastType: ToastType.INFO);
              await Get.find<OutletsController>().syncData();
              Utilities.showInToast('Syncing Success',
                  toastType: ToastType.SUCCESS);

              _lock = false;
            } else {
              Utilities.showInToast('No internet services!',
                  toastType: ToastType.INFO);
            }
          },
        ),
        appBar: AppBar(
          title: Text('Outlets'),
        ),
        body: GetBuilder<OutletsController>(
          builder: (outletController) {
            return Container(
                child: GridView.count(
              childAspectRatio: 9 / 10,
              crossAxisCount: 2,
              shrinkWrap: true,
              mainAxisSpacing: 3,
              crossAxisSpacing: 1,
              children: Get.find<OutletsController>().outletList.map((item) {
                return Card(
                  elevation: 7,
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                              child: CircleAvatar(
                            backgroundColor:
                                item.synced ? Colors.green : Colors.grey,
                            child: Icon(
                              !item.synced
                                  ? Icons.cloud_off_outlined
                                  : Icons.shopping_bag_outlined,
                              color: Colors.white,
                            ),
                          )),
                        ),
                        Center(
                          child: Text(
                            item.name,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.person,
                                size: 16,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(item.ownerName),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.phone,
                                size: 16,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(item.contact),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 16,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: Text(
                                  item.address ?? 'N/A',
                                  overflow: TextOverflow.visible,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.category,
                                size: 16,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(item.type),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),

              // },
            ));
          },
        ));
  }
}
