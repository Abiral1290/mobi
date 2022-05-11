

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobitrack_dv_flutter/controller/database_controller.dart';
import 'package:mobitrack_dv_flutter/controller/preference_controller.dart';
import 'package:mobitrack_dv_flutter/model/products.dart';
import 'package:mobitrack_dv_flutter/model/punched.dart';

class PunchedProduct extends StatelessWidget{
  List<String> punched;

  PunchedProduct ({Key key, this.punched}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(),
      body:  Container(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: punched.length,
            itemBuilder: (context, index) {
          return ListTile(
            title: Text(punched[index]),
          );
        }),
        ),
      );
      // ListView.builder(
      //   itemCount:  role.length,
      //     itemBuilder: (context, index) {
      //     return ListTile(
      //       title:  role[index],
      //     );
      // })
  }
  
}