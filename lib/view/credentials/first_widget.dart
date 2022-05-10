import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mobitrack_dv_flutter/view/credentials/login.dart';

import '../../utils/constants.dart';

class  FirstWidget extends StatelessWidget{

  Widget individualTileWidget(BuildContext context, IconData icon, String title,
      VoidCallback onTap, Color backgroundColor) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      splashColor: backgroundColor,
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
            children :[
              Container(
                  decoration: BoxDecoration(
                    // border: Border.all(color: Colors.white10,width: 5),

                      color: Colors.orange,
                      shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(20)
                  ),
                  height: Get.size.height * 0.1,
                  width: Get.size.width /1.2,
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                          padding: EdgeInsets.all(20),
                          child: Text(title,style: TextStyle(fontSize: 20),)),
                      IconButton(onPressed: onTap, icon: Icon(Icons.arrow_forward ,size: 30,color: Colors.white,))
                    ],
                  )

                //Card(
                //   color: Colors.transparent,
                //   elevation: .0,
                //   shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(_borderRadius),
                //     side: BorderSide(color: backgroundColor, width: 2.0),
                //    ),
                //   child: Center(
                //     child: Column(
                //       mainAxisSize: MainAxisSize.min,
                //       children: [
                //         Icon(
                //           icon,
                //           size: 40.0,
                //           color: backgroundColor,
                //         ),
                //         const SizedBox(height: 10.0),
                //         Text(
                //           title,
                //           style: const TextStyle(fontSize: 18.0, color: Colors.black),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
              ),
            ]
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
        child: Scaffold(
          body: Column(

            mainAxisAlignment: MainAxisAlignment.center ,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [


              Padding(
                padding: EdgeInsets.all(30),
                child: CircleAvatar(
                    backgroundImage: AssetImage('assets/DV_logo.png'),
                    backgroundColor: Colors.black12,
                    radius: 80,
                  ),
              ),
              individualTileWidget(
                  context, Icons.confirmation_num, Constants.server_1, () {
                  Colors.amber[900];
                Constants.server = Constants.server_1;
                Get.to(() => LoginPage(),
                    transition: Transition.rightToLeftWithFade);
              }, Colors.amber[900]),
              individualTileWidget(
                  context, Icons.confirmation_num, Constants.server_2, () {
                Colors.amber[900];
                Constants.server = Constants.server_2;
                Get.to(() => LoginPage(),
                    transition: Transition.rightToLeftWithFade);
              }, Colors.amber[900]),
              // ElevatedButton(onPressed: (){
              //   Get.to(LoginPage());
              // },child: Text("DV_trading"),),
              // ElevatedButton(onPressed:  (){
              //   Get.to(LoginPage());
              // }, child: Text("DV_Group"),),
            ],
          ),
        ));
  }
}