import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobitrack_dv_flutter/controller/products_controller.dart';
import 'package:mobitrack_dv_flutter/model/products.dart';
import 'package:intl/intl.dart';
import 'package:mobitrack_dv_flutter/view/products/view_sales.dart';

class ViewProductsPage extends StatelessWidget {
  final TextStyle titleStyle = TextStyle(
    fontSize: 18,
  );
  final TextStyle contentStyle = TextStyle(
    fontSize: 17,
  );

  @override
  Widget build(BuildContext context) {
    Widget buildBatchTile(Batches batches, Product products) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text("Manufacture:", style: contentStyle),
                  Spacer(),
                  Text(
                    DateFormat.yMEd()
                        .format(DateTime.parse(batches.manufacturedAt)),
                    style: contentStyle,
                  ),
                ],
              ),
              Row(
                children: [
                  Text("Expire:", style: contentStyle),
                  Spacer(),
                  Text(
                    DateFormat.yMEd().format(DateTime.parse(batches.expiredAt)),
                    style: contentStyle,
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    Widget buildMainTile(Product products) {
      return Card(
        elevation: 7.0,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Name:",
                    style: titleStyle,
                  ),
                  Spacer(),
                  Expanded(
                    child: Text(
                      products.name,
                      overflow: TextOverflow.visible,
                      maxLines: null,
                      style: contentStyle,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text("Unit:", style: titleStyle),
                  Spacer(),
                  Text(
                    products.unit,
                    style: contentStyle,
                  ),
                ],
              ),
              Row(
                children: [
                  Text("Price:", style: titleStyle),
                  Spacer(),
                  Text(
                    products.value.toString(),
                    style: contentStyle.copyWith(
                        color: Colors.red[900], fontSize: 20),
                  ),
                ],
              ),
              ExpansionTile(
                title: Text("Batches"),
                children: products.batches.map((batch) {
                  return buildBatchTile(batch, products);
                }).toList(),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Products"),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Get.to(() => ViewSalesPage());
          },
          label: Text("Unsynced sales")),
      body: GetBuilder<ProductsController>(
        // init: ProductsController(),
        builder: (productsController) {
          return Get.find<ProductsController>().productList == null
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Get.find<ProductsController>().productList.isEmpty
                  ? Center(child: Text("No Products"))
                  : Scrollbar(
                      isAlwaysShown: true,
                      interactive: true,
                      thickness: 6.0,
                      child: ListView.builder(
                          itemCount:
                              Get.find<ProductsController>().productList.length,
                          itemBuilder: (context, index) {
                            return buildMainTile(Get.find<ProductsController>()
                                .productList[index]);
                          }),
                    );
        },
      ),
    );
  }
}
