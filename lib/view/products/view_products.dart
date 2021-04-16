import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobitrack_dv_flutter/controller/products_controller.dart';
import 'package:mobitrack_dv_flutter/model/products.dart';
import 'package:intl/intl.dart';
import 'package:mobitrack_dv_flutter/view/products/sell_products.dart';

class ViewProductsPage extends StatelessWidget {
  final TextStyle titleStyle = TextStyle(
    fontSize: 18,
  );
  final TextStyle contentStyle = TextStyle(
    fontSize: 17,
  );

  @override
  Widget build(BuildContext context) {
    Widget buildBatchTile(Batches batches, Products products) {
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
              ElevatedButton(
                onPressed: () {
                  Get.to(() => SellProductPage(
                        products: products,
                        batches: batches,
                      ));
                },
                child: Text("Sell"),
              ),
            ],
          ),
        ),
      );
    }

    Widget buildMainTile(Products products) {
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
                  Text(
                    products.name,
                    style: contentStyle,
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
      body: GetBuilder<ProductsController>(
        init: ProductsController(),
        builder: (productsController) {
          return productsController.productList == null
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : productsController.productList.isEmpty
                  ? Center(child: Text("No Products"))
                  : ListView.builder(
                      itemCount: productsController.productList.length,
                      itemBuilder: (context, index) {
                        return buildMainTile(
                            productsController.productList[index]);
                      });
        },
      ),
    );
  }
}
