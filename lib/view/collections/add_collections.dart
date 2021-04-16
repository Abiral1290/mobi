import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      Collection(mode: PaymentMode.cash, accountOf: AccountOf.gnp).obs;
  TextEditingController amtCntrl = new TextEditingController(text: '0');

  var chequeImage = "".obs;

  bool validator() {
    return (collection.value.amount > 0 &&
            collection.value.chequePhoto.isNotEmpty)
        ? true
        : false;
  }

  Future<String> _getImg(ImageSource src) async {
    String base64Image = '';
    var img = await ImagePicker().getImage(source: src, imageQuality: 25);
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
            if (validator()) {
              if (Constants.selectedDistributor != null) {
                Utilities.showPlatformSpecificAlert(
                    canclose: false,
                    title: 'Please wait',
                    body: 'Storing collection',
                    context: context,
                    dismissable: false);
                collection.value.distributorId =
                    Constants.selectedDistributor.id;
                var conn = await Utilities.isInternetWorking();
                if (conn) {
                  var resp = await storeCollectionAPI(collection.value);
                  Get.back();
                  if (resp.success) {
                    Utilities.showInToast('Collection Uploaded succesfully',
                        toastType: ToastType.SUCCESS);

                    Get.back();
                  } else {
                    print(resp.message);
                    Utilities.showInToast(resp.message,
                        toastType: ToastType.ERROR);
                  }
                } else {
                  //TODO: Store offline
                }
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
              Text(
                "Distributor: ${Constants.selectedDistributor.name}",
                style: TextStyle(fontSize: 20.0),
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: amtCntrl,
                  maxLength: 6,
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
