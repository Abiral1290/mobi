

import 'package:get/get.dart';

import 'package:mobitrack_dv_flutter/model/town.dart';

import '../utils/utilities.dart';

class TownController extends GetxController {
  List<Town> townlist = [];
  List<Town> list = [];
  List<String> name = [];
  int selectedtown ;
  String selectedZone = "";
  int selectedZones;
  int selectedTown;

  TownController() {
    getTownList();
  }
  setSelectionZone(String zone){
    selectedZone =zone;
  //  selectedZones = zone_id;
  }
  setSelectedTown(int town){
    selectedtown = town;
   // selectedTown = town_id;
   //  var newlist = list.where((element) => element.town == selectedTown);
   //  selectedTown = newlist.first.id;
    update();
     // var newlist = list.where((element) => element.town == selectedTown);
     // selectedTown = newlist.first.id;
     // update();
  }
  // getTownList(){
  //    var newtownlist = townlist.groupListBy()
  // }
  // getname(){
  //   var newlsit = townlist.where((element) => element.town ==selectedtown);
  //   selectedTown = newlsit.first.id;
  // }
  getTownList() async {
    var conn = await Utilities.isInternetWorking();
    if (conn) {
      await fetchTownApi().then((value) async{
        print(value.response);
        if (value.success){
          townlist = value.response;
          print(townlist.length);
          setSelectedTown(townlist.first.id
            //  townlist.first.id
          );
          setSelectionZone(townlist.first.toString());
          update();
           // var newlist = list.where((element) => element.town == selectedTown);
           // selectedTown = newlist.first.id;
         // setSelectionZone(townlist.first.id.toString()
           //   townlist.first.zoneid
          // Get.find<PreferenceController>()
          //     .saveAddress(jsonEncode(value.response));
        } else {
          Utilities.showInToast(value.message, toastType: ToastType.ERROR);
          townlist = [];
          update();
        }
      });
    }
    fetchTown() {
      fetchTownApi().then((value) {
        if (value.success) {
          townlist = value.response;
        }
      }
      );
    }
  }
  // List<Town> lists = [];
  // getProvinceList() {
  //   var newprovinceList =
  //   productList.groupListsBy((element) => element.brandname);
  //   for (var list in newprovinceList.keys) {
  //     brandList.add(list);
  //   }
  //   setSelectedBrand(brandList.first);
  //
  //   // getNameList(brandList.first);
  //
  //   update();
  // }
  // getBrandList() async {
  //   var conn = await Utilities.isInternetWorking();
  //   if (conn) {
  //     await fetchTownApi().then((value) async {
  //       print(value.response);
  //       if (value.success) {
  //         print(value.response);
  //         Get.find<PreferenceController>()
  //             .saveProduct(jsonEncode(value.response));
  //       }
  //     });
  //   }
  //   Get.find<PreferenceController>().getProduct().then((value) {
  //     if (value != null) {
  //       var data = jsonDecode(value);
  //       // addressList = jsonDecode(value);
  //       lists = data.map<Town>((json) {
  //         return Town.fromJson(json);
  //       }).toList();
  //       //getProvinceList();
  //       getProvinceList();
  //       update();
  //     } else {
  //       productList = [];
  //       update();
  //     }
  //   });
  //   print(productList);
  // }

}