import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobitrack_dv_flutter/controller/auth_controller.dart';
import 'package:mobitrack_dv_flutter/utils/constants.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              children: [
                CircleAvatar(
                  child: Icon(Icons.person),
                  radius: 50,
                ),
                Text(
                  Get.find<AuthController>().user.name,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  Get.find<AuthController>().user.phone,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Divider(
                  thickness: 5.0,
                ),
                Row(
                  children: [
                    Text(
                      "Email:",
                      style: TextStyle(fontSize: 18),
                    ),
                    Spacer(),
                    Text(
                      Get.find<AuthController>().user.email,
                      overflow: TextOverflow.visible,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                SizedBox(height: Get.size.height * 0.01),
                Row(
                  children: [
                    Text(
                      "Distributor:",
                      style: TextStyle(fontSize: 18),
                    ),
                    Spacer(),
                    Text(
                      Constants.selectedDistributor.name,
                      overflow: TextOverflow.visible,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: Get.size.height * 0.01),
                Row(
                  children: [
                    Text(
                      "Address:",
                      style: TextStyle(fontSize: 18),
                    ),
                    Spacer(),
                    Text(
                      Constants.selectedDistributor.location,
                      overflow: TextOverflow.visible,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
