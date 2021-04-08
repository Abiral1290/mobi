import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget rowContent(String title, String data) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(
            width: Get.size.width * 0.1,
          ),
          Text(
            data,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      );
    }

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
                  child: Icon(
                    Icons.person,
                    size: 50,
                  ),
                  radius: 50,
                ),
                SizedBox(
                  height: Get.size.height * 0.02,
                ),
                rowContent("Name:", "Name"),
                rowContent("Phone:", "Phone"),
                rowContent("Address:", "Address"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}