import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mobitrack_dv_flutter/controller/dashboard_Controller.dart';
import 'package:mobitrack_dv_flutter/controller/routes_controller.dart';
import 'package:mobitrack_dv_flutter/utils/constants.dart';
import 'package:mobitrack_dv_flutter/view/view_distributor.dart';
import 'package:mobitrack_dv_flutter/view/widgets/scoreboard.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class DashBoardMain extends StatefulWidget{

  final String route;

  DashBoardMain({Key key, this.route}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DashBoardMain();
  }
}
class _DashBoardMain extends State<DashBoardMain>{

  var dash = Get.lazyPut(()=>DashBoard_Controller());
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body:
        ///  Get.find<Routecontroller>().routeList == null ?
      Constants.selectmyRoute == null?
      Container(
        child: Card(
          child: InkWell(
            onTap: (){},
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text('Please Select The Routes'),
                  ),
                  ElevatedButton(
                    style:  ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black),
                    ),
                      onPressed: (){
                      setState(() {
                        Get.to(()=> View_route());
                      });
                    },child: Text("Route")),

                ],
              ),
            ),
          ),
        )
        // Column(
        //   children: [
        //     Text("Select Route"),
        //     ElevatedButton(onPressed: (){
        //       setState(() {
        //         Get.to(()=> View_route());
        //       });
        //     }, child: Text("Route"))
        //   ],
        // ),
      ) : SingleChildScrollView(
        child: RefreshIndicator(
          onRefresh:() async {
            await Future.delayed(Duration(seconds: 2));
            Get.find<DashBoard_Controller>().fetchdashboard();
          },
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 10,
                  child: Container(
                      height: 330,
                      width: 400,
                      color: Colors.white,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              alignment: AlignmentDirectional.topStart,
                              child: const Text('TARGET & ACHEIVEMENT'),
                            ),
                          ),
                          Container(
                            height: 150,
                            width: 300,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircularPercentIndicator(
                                    radius: 130.0,
                                    lineWidth: 18.0,
                                    animation: true,
                                    animationDuration: 1200,
                                    percent: 0,
                                    circularStrokeCap: CircularStrokeCap.butt,
                                    center:  Text(
                                      Get.find<DashBoard_Controller>().dashboard.first.target.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0),
                                    ),
                                    backgroundColor: const Color.fromARGB(
                                        255, 217, 221, 227),
                                    progressColor:
                                    Color.fromARGB(255, 15, 104, 131),
                                  ),
                                ),
                                Expanded(
                                  child: ListView(
                                    children:  [
                                      ListTile(
                                        title: Text(
                                          Get.find<DashBoard_Controller>().dashboard.first.target.toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16.0),
                                        ),
                                        subtitle: Text(
                                          'Target',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12.0,
                                              color: Colors.grey),
                                        ),
                                      ),
                                      ListTile(
                                        title: Text(
                                          Get.find<DashBoard_Controller>().dashboard.first.achivement.toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16.0),
                                        ),
                                        subtitle: Text(
                                          'Acheivement',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12.0,
                                              color: Colors.grey),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            child: letters(),
                          )
                        ],
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    height: 80,
                    width: 400,
                    color: Colors.white,
                    child: const Card(
                      elevation: 10,
                      shadowColor: Colors.black,
                      child: ListTile(
                        title: Text(
                          'BRAND DISTRIBUTION TARGET',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                              color: Colors.grey),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 10,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          alignment: AlignmentDirectional.topStart,
                          child: const Text('ACTIVE OUTLET TARGET'),
                        ),
                      ),
                      SizedBox(
                        height: 200,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircularPercentIndicator(
                                radius: 130.0,
                                lineWidth: 18.0,
                                animation: true,
                                animationDuration: 1200,
                                percent: 0.1,
                                circularStrokeCap: CircularStrokeCap.butt,
                                center: const Text(
                                  " 0%",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                ),
                                backgroundColor:
                                const Color.fromARGB(255, 217, 221, 227),
                                progressColor:
                                Color.fromARGB(255, 15, 104, 131),
                              ),
                            ),
                            Expanded(
                              child: ListView(
                                children:   [
                                  ListTile(
                                    title: Text(
                                      Get.find<DashBoard_Controller>().dashboard.first.target.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16.0),
                                    ),
                                    subtitle: Text(
                                      'Target',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12.0,
                                          color: Colors.grey),
                                    ),
                                  ),
                                  ListTile(
                                    title: Text(
                                      Get.find<DashBoard_Controller>().dashboard.first.achivement.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16.0),
                                    ),
                                    subtitle: Text(
                                      'Acheivement',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12.0,
                                          color: Colors.grey),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ));



  }
  Widget mycard({String text}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(text),
        ),
      ],
    );
  }

  Widget letters() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      mycard(
                        text: "Total orders",
                      ),
                      mycard(text: Get.find<DashBoard_Controller>().dashboard.first.orderRecevied.toString()),
                    ],
                  ),
                  Column(
                    children: [
                      mycard(text: "Total invoiced"),
                      mycard(text: "0"),
                    ],
                  ),
                  Column(
                    children: [
                      mycard(text: "Total returns"),
                      mycard(text: "0"),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      mycard(
                        text: "VALUE",
                      ),
                      mycard(text: "0"),
                    ],
                  ),
                  Column(
                    children: [
                      mycard(text: "VALUE"),
                      mycard(text: "0"),
                    ],
                  ),
                  Column(
                    children: [
                      mycard(text: "VALUE"),
                      mycard(text: "0"),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}



