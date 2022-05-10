

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobitrack_dv_flutter/controller/database_controller.dart';
import 'package:mobitrack_dv_flutter/controller/preference_controller.dart';
import 'package:mobitrack_dv_flutter/model/products.dart';

class PunchedProduct extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return  _PunchedProduct();
  }
}

class _PunchedProduct extends State<PunchedProduct>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(),
      body:FutureBuilder<List<Sales>>(
    future: DatabaseHelper.instance.getAllSalesData(),
    builder: (BuildContext context, AsyncSnapshot<List<Sales>> snapshot) {
    if (snapshot.hasData) {
    return ListView.builder(
    itemCount: snapshot.data.length,
    itemBuilder: (BuildContext context, int index) {
    Sales item = snapshot.data[index];
    return ListTile(
    title: Text(item.orders),
    leading: Text(item.id.toString()),
    // trailing: Checkbox(
    // onChanged: (bool value) {
    // DBProvider.db.blockClient(item);
    // setState(() {});
    // },
    // value: item.blocked,
    // ),
    );
    },
    );
    } else {
    return Center(child: CircularProgressIndicator());
    }
    },
      // GetBuilder<PreferenceController>(
      //   builder: (builder){
      //     return Row(
      //       children: [
      //         ElevatedButton(onPressed: (){setState(() {
      //       print( Get.find<PreferenceController>().getProduct());
      //     });
      //     Get.find<PreferenceController>().getProduct();
      //     }, child: Text("Press")),
      //         Text(Get.find<PreferenceController>().getProduct().toString())
      //       ],
      //     );
      //
      //   },
      // ),
    )
    );
  }
  
}