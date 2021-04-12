import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobitrack_dv_flutter/model/outlet.dart';
import 'package:mobitrack_dv_flutter/model/resp.dart';

class ViewOutletsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Outlets'),
      ),
      body: Container(
        child: FutureBuilder<ApiResponse<List<Outlet>>>(
          future: fetchOutletsApi(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              ApiResponse<List<Outlet>> resp = snapshot.data;

              if (resp.success) {
                return GridView.count(
                  childAspectRatio: 9 / 10,
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  mainAxisSpacing: 3,
                  crossAxisSpacing: 1,
                  children: resp.response.map((item) {
                    return Card(
                      elevation: 7,
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                  child: Icon(Icons.shopping_bag_outlined)),
                            ),
                            Center(
                              child: Text(
                                item.name,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Divider(),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.person,
                                    size: 16,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(item.ownerName),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.phone,
                                    size: 16,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(item.contact),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    size: 16,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    child: Text(
                                      item.address,
                                      overflow: TextOverflow.visible,
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.category,
                                    size: 16,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(item.type),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),

                  // },
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(child: Text(resp.message)),
                );
              }
            }
            return Center(child: CupertinoActivityIndicator());
          },
        ),
      ),
    );
  }
}
