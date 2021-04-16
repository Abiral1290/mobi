import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobitrack_dv_flutter/model/check_in_out.dart';
import 'package:mobitrack_dv_flutter/model/resp.dart';
import 'package:mobitrack_dv_flutter/utils/constants.dart';

class AttendancePage extends StatefulWidget {
  @override
  _AttendancePageState createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance'),
      ),
      body: Container(
        child: Center(
          child: FutureBuilder<ApiResponse<List<CheckInOut>>>(
            future: fetchcheckDataApi(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                ApiResponse<List<CheckInOut>> data = snapshot.data;
                if (data.success) {
                  return ListView.builder(
                    itemCount: data.response.length,
                    itemBuilder: (BuildContext context, int index) {
                      var item = data.response[index];
                      return Card(
                        child: ListTile(
                          leading: Icon(item.checkType == Check.checkIn
                              ? Icons.arrow_forward
                              : Icons.arrow_back),
                          title: Text(item.checkType),
                          subtitle: Text(DateFormat.yMEd()
                              .add_jms()
                              .format(DateTime.parse(item.createdAt))),
                        ),
                      );
                    },
                  );
                } else {
                  return Text(data.message);
                }
              }
              return CupertinoActivityIndicator();
            },
          ),
        ),
      ),
    );
  }
}
