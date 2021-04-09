import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:mobitrack_dv_flutter/controller/auth_controller.dart';
import 'package:mobitrack_dv_flutter/controller/location_controller.dart';
import 'package:mobitrack_dv_flutter/model/outlet.dart';
import 'package:mobitrack_dv_flutter/utils/constants.dart';
import 'package:mobitrack_dv_flutter/utils/utilities.dart';

class RegisterShopPage extends StatefulWidget {
  @override
  _RegisterShopPageState createState() => _RegisterShopPageState();
}

class _RegisterShopPageState extends State<RegisterShopPage> {
  final TextEditingController _nameCntrl = new TextEditingController();
  final TextEditingController _ownerCntrl = new TextEditingController();
  final TextEditingController _phoneCntrl = new TextEditingController();
  String _type = SellerType.mart; //dafault is mart

  @override
  void initState() {
    Get.find<LocationController>().getCurrentPosition();
    super.initState();
  }

  bool validateInput() {
    return _nameCntrl.text.isNotEmpty &&
        _ownerCntrl.text.isNotEmpty &&
        _phoneCntrl.text.isNotEmpty &&
        _phoneCntrl.text.length == 10;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Register Sales Outlet'),
        ),
        body: GetBuilder<LocationController>(
          builder: (locationController) {
            return Get.find<LocationController>().userPosition == null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Please enable location"),
                      CupertinoActivityIndicator(),
                    ],
                  )
                : ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          autofocus: false,
                          decoration: InputDecoration(
                              labelText: 'Shop Name',
                              prefixIcon: Icon(Icons.shopping_bag_outlined)),
                          controller: _nameCntrl,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextField(
                          autofocus: false,
                          decoration: InputDecoration(
                              labelText: 'Owner Name',
                              prefixIcon: Icon(Icons.person)),
                          controller: _ownerCntrl,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          autofocus: false,
                          keyboardType: TextInputType.number,
                          maxLength: 10,
                          decoration: InputDecoration(
                              prefixText: '+977 - ',
                              labelText: 'Phone',
                              prefixIcon: Icon(Icons.phone)),
                          controller: _phoneCntrl,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(12.0),
                        child: InputDecorator(
                          decoration: InputDecoration(
                            labelText: 'Shop Type',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: <Widget>[
                                  Radio(
                                    value: SellerType.mart,
                                    groupValue: _type,
                                    onChanged: (newValue) =>
                                        setState(() => _type = newValue),
                                    activeColor: Colors.red,
                                  ),
                                  Text(SellerType.mart),
                                  SizedBox(
                                    width: 65,
                                  ),
                                  Radio(
                                    value: SellerType.wholeSeller,
                                    groupValue: _type,
                                    onChanged: (newValue) =>
                                        setState(() => _type = newValue),
                                    activeColor: Colors.red,
                                  ),
                                  Text(SellerType.wholeSeller)
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Radio(
                                    value: SellerType.retailer,
                                    groupValue: _type,
                                    onChanged: (newValue) =>
                                        setState(() => _type = newValue),
                                    activeColor: Colors.red,
                                  ),
                                  Text(SellerType.retailer),
                                  SizedBox(
                                    width: 42,
                                  ),
                                  Radio(
                                    value: SellerType.hawcker,
                                    groupValue: _type,
                                    onChanged: (newValue) =>
                                        setState(() => _type = newValue),
                                    activeColor: Colors.red,
                                  ),
                                  Text(SellerType.hawcker)
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 80, vertical: 5),
                        child: MaterialButton(
                          onPressed: () async {
                            FocusScope.of(context).unfocus(); //dismiss keyboard

                            if (validateInput()) {
                              var conn = await Utilities.isInternetWorking();
                              showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (context) {
                                    return CupertinoAlertDialog(
                                      title: Text('Please Wait'),
                                      content: Column(
                                        children: [
                                          Divider(),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(conn
                                                ? 'Registering new Sales Outlet'
                                                : 'Saving offline'),
                                          ),
                                          CupertinoActivityIndicator(
                                            radius: 17,
                                          )
                                        ],
                                      ),
                                    );
                                  });
                              await Future.delayed(Duration(seconds: 2));
                              if (conn) {
                                //online store
                                var pos = await GeolocatorPlatform.instance
                                    .getCurrentPosition(
                                        desiredAccuracy:
                                            LocationAccuracy.bestForNavigation);

                                var response = await registerOutlet(Outlet(
                                    contact: _phoneCntrl.text,
                                    latitude: pos.latitude,
                                    name: _nameCntrl.text,
                                    ownerName: _ownerCntrl.text,
                                    type: _type,
                                    salesOfficerId:
                                        Get.find<AuthController>().user.id,
                                    longitude: pos.longitude));
                                Navigator.of(context).pop();
                                Utilities.showInToast(response.message,
                                    toastType: response.success
                                        ? ToastType.SUCCESS
                                        : ToastType.ERROR);

                                if (response.success) {
                                  Navigator.of(context).pop();
                                }
                              } else {
                                //TODO: offline db storage

                              }
                            } else {
                              Utilities.showInToast('Please complete the form',
                                  toastType: ToastType.ERROR);
                            }
                          },
                          color: Colors.blue,
                          textColor: Colors.white,
                          child: Text('Submit'),
                        ),
                      ),
                      SizedBox(
                        height: Get.size.height * 0.02,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          "Warning: Please fill form if and only if you are in that shop.",
                          style: TextStyle(
                            color: Colors.red[900],
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Get.size.height * 0.02,
                      ),
                      // Center(
                      //   child: Text(
                      //     Get.find<LocationController>()
                      //             .userPosition
                      //             .latitude
                      //             .toString() +
                      //         ", " +
                      //         Get.find<LocationController>()
                      //             .userPosition
                      //             .longitude
                      //             .toString(),
                      //     style: TextStyle(
                      //       color: Colors.red[900],
                      //       fontStyle: FontStyle.italic,
                      //       fontWeight: FontWeight.bold,
                      //     ),
                      //   ),
                      // ),
                    ],
                  );
          },
        ),
      ),
    );
  }
}
