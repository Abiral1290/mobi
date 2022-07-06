import 'dart:async';

import 'package:get/get.dart';
import 'package:mobitrack_dv_flutter/utils/utilities.dart';

import '../model/distributer_outlet.dart';

class DistributedCOntroller extends  GetxController{
  List<Outletss> OutList = [];
  List<Outletss> searchedOutList = [];

  fetchDistributor(){
    fetchOutlerAp().then((value) {
      if(value.success!){
       OutList = value.response!;
       update();
      }else{
        Utilities.showInToast(value.message!, toastType: ToastType.ERROR);
        OutList = [];
        update();
      }
    });
  }

  searchDistributor(String text) {
    if (OutList.isNotEmpty) {
      searchedOutList = OutList
          .where((element) =>
          element.name!.toLowerCase().contains(text.toLowerCase()))
          .toList();
      update();
    }
  }
}
