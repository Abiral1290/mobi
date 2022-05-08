import 'package:get/get.dart';
import 'package:mobitrack_dv_flutter/model/distributor_route.dart';

class Distributor_Route_Controller extends GetxController{
  List <Distributor_route> distributor_route = [];


  String selectedutlet = '';

  addDistributorlet(Distributor_route distributor){
    distributor_route.add(distributor);
    update();
  }


}