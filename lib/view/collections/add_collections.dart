import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobitrack_dv_flutter/controller/auth_controller.dart';
import 'package:mobitrack_dv_flutter/model/collections.dart';
import 'package:mobitrack_dv_flutter/model/distributor.dart';
import 'package:mobitrack_dv_flutter/utils/constants.dart';
import 'package:mobitrack_dv_flutter/utils/utilities.dart';
import 'package:get/get.dart';

class AddCollectionsPage extends StatefulWidget {
  @override
  _AddCollectionsPageState createState() => _AddCollectionsPageState();
}

class _AddCollectionsPageState extends State<AddCollectionsPage> {
  var collection =
      Collection(mode: PaymentMode.cash, accountOf: AccountOf.gnp).obs;
  TextEditingController amtCntrl = new TextEditingController(text: '0');
  var db = Get.find<AuthController>().user.distributors.first.obs;

  bool validator() {
    return (collection.value.amount > 0) ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Store Collection'),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            FocusScope.of(context).unfocus();
            if (validator()) {
              Utilities.showPlatformSpecificAlert(
                  canclose: false,
                  title: 'Please wait',
                  body: 'Storing collection',
                  context: context,
                  dismissable: false);
              var conn = await Utilities.isInternetWorking();
              if (conn) {
                var resp = await storeCollectionAPI(collection.value);
                Get.back();
                if (resp.success) {
                  Utilities.showInToast('Collection Uploaded succesfully',
                      toastType: ToastType.SUCCESS);

                  Navigator.pop(context);
                } else {
                  Utilities.showInToast(resp.message,
                      toastType: ToastType.ERROR);
                }
              } else {
                //TODO: Store offline
              }
            } else {
              Utilities.showInToast('Please complete the form!',
                  toastType: ToastType.ERROR);
            }
          },
          label: Text('Collect')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Text("Select Ditributor"),
                Obx(
                  () => DropdownButton<Distributor>(
                    hint: Text(db.value.name),
                    items: Get.find<AuthController>()
                        .user
                        .distributors
                        .map((value) {
                      return DropdownMenuItem<Distributor>(
                          value: value,
                          child: Text(
                            value.name,
                            style: TextStyle(color: Colors.black),
                          ));
                    }).toList(),
                    onChanged: (Distributor dist) {
                      db.value = dist;
                      collection.value.distributorId = dist.id;
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (s) => collection.value.bankName = s,
                decoration: InputDecoration(
                    labelText: 'Bank Name',
                    prefixIcon: Icon(Icons.business_rounded)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (s) => collection.value.chequeNo = s,
                decoration: InputDecoration(
                    labelText: 'Cheque Number',
                    prefixIcon: Icon(Icons.credit_card)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: amtCntrl,
                maxLength: 7,
                onChanged: (s) {
                  try {
                    collection.value.amount = int.parse(s);
                  } catch (e) {
                    amtCntrl.clear();
                    collection.value.amount = 0;
                  }
                },
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                decoration: InputDecoration(
                    labelText: 'Amount', prefixIcon: Icon(Icons.money)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Obx(
                    () => DropdownButton<String>(
                      hint: Text(collection.value.mode),
                      items:
                          [PaymentMode.cash, PaymentMode.cheque].map((value) {
                        return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(color: Colors.black),
                            ));
                      }).toList(),
                      onChanged: (s) {
                        collection.value.mode = s;
                      },
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Obx(
                    () => DropdownButton<String>(
                      hint: Text(collection.value.accountOf),
                      items: [AccountOf.gnp, AccountOf.gsi].map((value) {
                        return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(color: Colors.black),
                            ));
                      }).toList(),
                      onChanged: (s) {
                        collection.value.accountOf = s;
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (s) => collection.value.remarks = s,
                decoration: InputDecoration(
                    labelText: 'Remarks',
                    prefixIcon: Icon(Icons.textsms_outlined)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
