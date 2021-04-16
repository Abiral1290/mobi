import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mobitrack_dv_flutter/controller/auth_controller.dart';
import 'package:mobitrack_dv_flutter/controller/outlets_controller.dart';
import 'package:mobitrack_dv_flutter/controller/products_controller.dart';
import 'package:mobitrack_dv_flutter/model/distributor.dart';
import 'package:mobitrack_dv_flutter/model/outlet.dart';
import 'package:mobitrack_dv_flutter/model/products.dart';
import 'package:mobitrack_dv_flutter/utils/constants.dart';
import 'package:mobitrack_dv_flutter/utils/utilities.dart';

class SellProductPage extends StatelessWidget {
  final Products products;
  final Batches batches;

  SellProductPage({@required this.products, @required this.batches});

  TextEditingController outletTextController = TextEditingController();
  TextEditingController quantityTextController = TextEditingController();

  Sales sales = Sales();
  int quantity = 0;

  var selectedOutlet = Outlet().obs;
  var selectedIndex = 0.obs;

  var distributor = Get.find<AuthController>().user.distributors.first.obs;

  @override
  Widget build(BuildContext context) {
    sales.distributorId = distributor.value.id;
    Widget buildOutletList() {
      return Expanded(
        child: GetBuilder<OutletsController>(
          init: OutletsController(),
          builder: (outletsController) {
            return outletsController.searchList.isEmpty
                ? outletsController.outletList == null
                    ? Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        itemCount: outletsController.outletList.length,
                        itemBuilder: (context, index) {
                          return Obx(
                            () => Card(
                              child: ListTile(
                                selected: index == selectedIndex.value,
                                title: Text(
                                    outletsController.outletList[index].name),
                                subtitle: Text(
                                    outletsController.outletList[index].type),
                                onTap: () {
                                  selectedOutlet.value =
                                      outletsController.outletList[index];
                                  sales.outletId =
                                      outletsController.outletList[index].id;
                                  selectedIndex.value = index;
                                },
                              ),
                            ),
                          );
                        })
                : ListView.builder(
                    itemCount: outletsController.searchList.length,
                    itemBuilder: (context, index) {
                      return Obx(
                        () => Card(
                          child: ListTile(
                            selected: index == selectedIndex.value,
                            title:
                                Text(outletsController.searchList[index].name),
                            subtitle:
                                Text(outletsController.searchList[index].type),
                            onTap: () {
                              selectedOutlet.value =
                                  outletsController.searchList[index];
                              sales.outletId =
                                  outletsController.searchList[index].id;
                              selectedIndex.value = index;
                            },
                            // selectedTileColor: Colors.green,
                          ),
                        ),
                      );
                    });
          },
        ),
      );
    }

    Widget buildDistributorDropdown() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Select Distributor"),
          SizedBox(
            width: Get.size.width * 0.1,
          ),
          Obx(
            () => DropdownButton<Distributor>(
              hint: Text(distributor.value.name),
              items: Get.find<AuthController>().user.distributors.map((value) {
                return DropdownMenuItem<Distributor>(
                    value: value,
                    child: Text(
                      value.name,
                      style: TextStyle(color: Colors.black),
                    ));
              }).toList(),
              onChanged: (Distributor dist) {
                distributor.value = dist;
                sales.distributorId = dist.id;
              },
            ),
          ),
        ],
      );
    }

    Widget buildQuantityField() {
      return Container(
        width: Get.size.width * 0.7,
        child: Row(
          children: <Widget>[
            Text("Quantity"),
            SizedBox(
              width: Get.size.width * 0.1,
            ),
            Expanded(
              flex: 1,
              child: TextField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(8.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (text) {
                  if (text.isNotEmpty) {
                    quantity = int.parse(quantityTextController.text);
                    sales.quantity = int.parse(quantityTextController.text);
                  }
                },
                controller: quantityTextController,
                keyboardType: TextInputType.numberWithOptions(
                  decimal: false,
                  signed: true,
                ),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
              ),
            ),
            Container(
              height: 38.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 0.5,
                        ),
                      ),
                    ),
                    child: InkWell(
                      child: Icon(
                        Icons.arrow_drop_up,
                        size: 18.0,
                      ),
                      onTap: () {
                        if (quantityTextController.text == "") {
                          quantityTextController.text = quantity.toString();
                        }
                        int currentValue =
                            int.parse(quantityTextController.text);

                        // if (currentValue < batches.stock) {
                        currentValue++;
                        quantity = currentValue;
                        sales.quantity = currentValue;

                        quantityTextController.text = (currentValue).toString();
                        // }
                      },
                    ),
                  ),
                  InkWell(
                    child: Icon(
                      Icons.arrow_drop_down,
                      size: 18.0,
                    ),
                    onTap: () {
                      if (quantityTextController.text == "") {
                        quantityTextController.text = quantity.toString();
                      }
                      int currentValue = int.parse(quantityTextController.text);
                      if (currentValue >= 0) {
                        currentValue--;
                        quantity = currentValue;
                        sales.quantity = currentValue;

                        quantityTextController.text =
                            (currentValue > 0 ? currentValue : 0).toString();
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Sell"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              children: [
                Text(
                  products.name,
                  style: TextStyle(fontSize: 20.0),
                ),
                Text(
                  "Batch Number: ${batches.id}",
                  style: TextStyle(fontSize: 18.0),
                ),
                Text(
                  "Distributor: ${Constants.selectedDistributor.name}",
                  style: TextStyle(fontSize: 18.0),
                ),
                Obx(() => selectedOutlet.value.name != null
                    ? Text("Selected Outlet: " + selectedOutlet.value.name)
                    : SizedBox()),
                SizedBox(
                  height: Get.size.height * 0.03,
                ),
                InputDecorator(
                  decoration: InputDecoration(
                      labelText: "Select Company",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0))),
                  child: Container(
                    height: Get.size.height * 0.45,
                    child: Column(
                      children: [
                        TextField(
                            controller: outletTextController,
                            decoration: InputDecoration(
                                enabled: true, hintText: "Search  Outlets"),
                            onChanged: (text) {
                              Get.find<OutletsController>().searchOutlets(text);
                            }),
                        buildOutletList(),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: Get.size.height * 0.02),
                // buildDistributorDropdown(),
                buildQuantityField(),
                ElevatedButton(
                  onPressed: () {
                    if (sales.outletId != null && sales.quantity != null) {
                      if (Constants.selectedDistributor != null) {
                        sales.distributorId = Constants.selectedDistributor.id;
                        sales.batchId = batches.id;
                        sales.productId = products.id;
                        sales.soldAt = DateTime.now().toString();
                        print(sales.toJson());
                        Get.find<ProductsController>().sellProducts(sales);
                        Utilities.showPlatformSpecificAlert(
                            canclose: false,
                            dismissable: false,
                            title: "Please wait",
                            body: "Your Transaction is being processed",
                            context: context);
                      } else {
                        Utilities.showInToast(
                            "Please choose your distributor first",
                            toastType: ToastType.ERROR);
                      }
                    } else {
                      Utilities.showInToast("Please Complete form",
                          toastType: ToastType.ERROR);
                    }
                    sales.distributorId =
                        Get.find<AuthController>().user.distributors.first.id;
                    sales.batchId = batches.id;
                    sales.productId = products.id;
                    sales.soldAt = DateTime.now().toString();
                    print(sales.toJson());
                    Get.find<ProductsController>().sellProducts(sales);
                    Utilities.showPlatformSpecificAlert(
                        canclose: false,
                        dismissable: false,
                        title: "Please wait",
                        body: "Your Transaction is being processed",
                        context: context);
                  },
                  child: Text("Save"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}