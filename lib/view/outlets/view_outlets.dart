import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobitrack_dv_flutter/controller/address_controller.dart';
import 'package:mobitrack_dv_flutter/controller/outlets_controller.dart';
import 'package:mobitrack_dv_flutter/utils/utilities.dart';
import 'package:mobitrack_dv_flutter/view/products/sell_products.dart';

class ViewOutletsPage extends StatelessWidget {
  bool _lock = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          label: Row(
            children: [
              Icon(Icons.sync),
              Text("Sync Outlets"),
            ],
          ),
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
            return ListView.builder(
              itemCount: Get.find<OutletsController>().outletList.length,
              itemBuilder: (context, index) {
                var list = Get.find<OutletsController>().outletList;
                print(list);
                var item = Get.find<OutletsController>().outletList[index];
                print(Get.find<AddressController>().addressList);
                String province = Get.find<AddressController>()
                    .addressList
                    .where((element) => element.id == item.provinceId)
                    .toList()
                    .first
                    .name;
                String district = Get.find<AddressController>()
                    .addressList
                    .where((element) => element.id == item.provinceId)
                    .toList()
                    .first
                    .districts
                    .where((element) => element.id == item.districtId)
                    .toList()
                    .first
                    .name;
                String area = Get.find<AddressController>()
                    .addressList
                    .where((element) => element.id == item.provinceId)
                    .toList()
                    .first
                    .districts
                    .where((element) => element.id == item.districtId)
                    .toList()
                    .first
                    .areas
                    .where((element) => element.id == item.areaId)
                    .toList()
                    .first
                    .name;
                String street = Get.find<AddressController>()
                    .addressList
                    .where((element) => element.id == item.provinceId)
                    .toList()
                    .first
                    .districts
                    .where((element) => element.id == item.districtId)
                    .toList()
                    .first
                    .areas
                    .where((element) => element.id == item.areaId)
                    .toList()
                    .first
                    .streets
                    .where((element) => element.id == item.streetId)
                    .toList()
                    .first
                    .name;
                return Container(
                  child: Card(
                    elevation: 7,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
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
                                  province +
                                      ", " +
                                      district +
                                      ", " +
                                      area +
                                      ", " +
                                      street,
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
                        MaterialButton(
                          onPressed: () {
                            Get.to(() => SellProductPage(
                                outlet: Get.find<OutletsController>()
                                    .outletList[index]));
                          },
                          color: Colors.green[900],
                          minWidth: Get.size.width,
                          textColor: Colors.white,
                          padding: EdgeInsets.all(10.0),
                          child: Text("Sell Product"),
                        ),
                      ],
                    ),
                  ),
                );
              },

              // },
            );
          },
        ));
  }
}
