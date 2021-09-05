import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobitrack_dv_flutter/controller/bank_controller.dart';
import 'package:mobitrack_dv_flutter/controller/collections_controller.dart';
import 'package:mobitrack_dv_flutter/model/bank.dart';
import 'package:mobitrack_dv_flutter/model/collections.dart';
import 'package:mobitrack_dv_flutter/utils/constants.dart';
import 'package:mobitrack_dv_flutter/utils/utilities.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddCollectionsPage extends StatefulWidget {
  @override
  _AddCollectionsPageState createState() => _AddCollectionsPageState();
}

class _AddCollectionsPageState extends State<AddCollectionsPage> {
  var collection =
      Collections(mode: PaymentMode.cash, accountOf: AccountOf.gnp).obs;
  TextEditingController amtCntrl = new TextEditingController(text: '0');

  var chequeImage = "".obs;
  var bankName = "Select Bank".obs;

  bool validator() {
    return collection.value.mode == PaymentMode.cheque
        ? (collection.value.chequePhoto.isNotEmpty &&
                collection.value.chequeNo.isNotEmpty)
            ? true
            : false
        : true;
  }

  Future<String> _getImg(ImageSource src) async {
    String base64Image = '';
    var img = await ImagePicker().pickImage(source: src, imageQuality: 25);
    if (img != null) {
      List<int> imageBytes = await img.readAsBytes();
      base64Image = base64Encode(imageBytes);
    }
    Navigator.pop(context, base64Image);

    //1400

    return base64Image;
  }

  Future<String> _showPicker(context) async {
    return await showModalBottomSheet<String>(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () async {
                        var resp = await _getImg(ImageSource.gallery);
                        return resp;
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () async {
                      var resp = await _getImg(ImageSource.camera);
                      return resp;
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Collection'),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            FocusScope.of(context).unfocus();
            if (validator() &&
                collection.value.amount > 0 &&
                collection.value.bankName.isNotEmpty) {
              if (Constants.selectedDistributor != null) {
                Utilities.showPlatformSpecificAlert(
                    canclose: false,
                    title: 'Please wait',
                    body: 'Storing collection',
                    context: context,
                    dismissable: false);
                collection.value.distributorId =
                    Constants.selectedDistributor.id;
                collection.value.id = DateTime.now().microsecondsSinceEpoch;
                collection.value.deviceTime = DateTime.now().toString();
                collection.value.createdAt = DateTime.now().toString();
                collection.value.updatedAt = DateTime.now().toString();

                var conn = await Utilities.isInternetWorking();
                if (conn) {
                  collection.value.synced = 1;

                  Get.find<CollectionController>()
                      .storeCollection(collection.value);
                } else {
                  collection.value.synced = 0;
                  Utilities.showInToast('Storing Offline',
                      toastType: ToastType.INFO);
                  Get.find<CollectionController>()
                      .storeOfflineCollection(collection.value);
                }
                Get.back();
              } else {
                Utilities.showInToast('Please select your distributor first!',
                    toastType: ToastType.ERROR);
              }
            } else {
              Utilities.showInToast('Please complete the form!',
                  toastType: ToastType.ERROR);
            }
          },
          label: Text('Collect')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              // distributor name field
              Text(
                "Distributor: ${Constants.selectedDistributor.name}",
                style: TextStyle(fontSize: 20.0),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: TextField(
              //     onChanged: (s) => collection.value.bankName = s,
              //     decoration: InputDecoration(
              //         labelText: 'Bank Name',
              //         prefixIcon: Icon(Icons.business_rounded)),
              //   ),
              // ),

              // bank dropdown field
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Obx(
                  () => DropdownButton<Bank>(
                    hint: Text(bankName.value),
                    items: Get.find<BankController>().bankList.map((value) {
                      return DropdownMenuItem<Bank>(
                          value: value,
                          child: Text(
                            value.bankName,
                            style: TextStyle(color: Colors.black),
                          ));
                    }).toList(),
                    onChanged: (s) {
                      collection.value.bankName = s.bankName;
                      bankName.value = s.bankName;
                    },
                  ),
                ),
              ),

              // cheque number textfield
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (s) => collection.value.chequeNo = s,
                  decoration: InputDecoration(
                      labelText: 'Cheque Number',
                      prefixIcon: Icon(Icons.credit_card)),
                ),
              ),

              // cheque photo picker field
              Container(
                padding: const EdgeInsets.all(12.0),
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'Cheque Photo',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Obx(() => GestureDetector(
                        onTap: () async {
                          var res = await _showPicker(context);
                          if (res != null) {
                            chequeImage.value = res;
                            collection.value.chequePhoto = res;
                          }
                        },
                        child: chequeImage.value != null &&
                                chequeImage.value.isNotEmpty
                            ? Image.memory(base64Decode(chequeImage.value))
                            : Row(children: [
                                Icon(Icons.photo),
                                SizedBox(width: 6),
                                Text('Tap to Choose Image')
                              ]),
                      )),
                ),
              ),

              // amount text field
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: amtCntrl,
                  maxLength: 9,
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

              // payment mode and accountof dropdown field
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
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

              // remarks dropdown field
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
      ),
    );
  }
}
