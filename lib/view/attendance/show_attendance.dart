import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobitrack_dv_flutter/model/check_in_out.dart';
import 'package:mobitrack_dv_flutter/model/resp.dart';
import "package:collection/collection.dart";

class AttendancePage extends StatefulWidget {
  @override
  _AttendancePageState createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Attendance'),
      ),
      body: FutureBuilder<ApiResponse<List<CheckInOut>>>(
        future: fetchcheckDataApi(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            ApiResponse<List<CheckInOut>> data = snapshot.data;
            if (data.success!) {
              var newMap =
                  data.response!.groupListsBy((element) => element.date);
              print(newMap);
              return ListView.builder(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                itemCount: newMap.length,
                itemBuilder: (BuildContext context, int index) {
                  String key = newMap.keys.elementAt(index)!;
                  var item = newMap.values.elementAt(index);
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InputDecorator(
                      decoration: InputDecoration(
                        labelText: key,
                        labelStyle: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: Row(
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: item.map((e) {
                              return Card(
                                child: Container(
                                  width: Get.size.width * 0.4,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Text("IN"),
                                        e.checkinDeviceTime == null
                                            ? Text("null")
                                            : Text(e.checkinDeviceTime!.hour
                                                    .toString() +
                                                ":" +
                                                e.checkinDeviceTime!.minute
                                                    .toString() +
                                                ":" +
                                                e.checkinDeviceTime!.second
                                                    .toString()),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          Spacer(),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: item.map((e) {
                              return Card(
                                child: Container(
                                  width: Get.size.width * 0.4,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Text("OUT"),
                                        e.checkoutDeviceTime == null
                                            ? Text("Not Checkedout")
                                            : Text(e.checkoutDeviceTime!.hour
                                                    .toString() +
                                                ":" +
                                                e.checkoutDeviceTime!.minute
                                                    .toString() +
                                                ":" +
                                                e.checkoutDeviceTime!.second
                                                    .toString()),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              return Text(data.message!);
            }
          }
          return Center(child: CupertinoActivityIndicator());
        },
      ),
    );
  }
}
