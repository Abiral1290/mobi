import 'package:get/get.dart';
import 'package:mobitrack_dv_flutter/model/channel.dart';

import '../utils/constants.dart';
import '../utils/utilities.dart';

class ChannelController extends GetxController{
  List<Channel> channelList =[];
  List idss =[];
  List<Channel> list =[];

  int selectedchannel;
  String selectedid;

  ChannelController(){
    getChannelList();
  }

  setSelectedTown(int channel  ) {
    selectedchannel= channel;

    // var newlist = list.where((element) => element.channel== selectedchannel);
    // selectedid = newlist.first.id.toString();
    //var news =channelList.forEach((element) {element.channel == selectedchannel;});
    //idss.add(news);
    // selectedid = channel_id;
    /// selectedchannel =Constants.selectedchannel.channel;
    update();
    // var newlist = list.where((element) => element.channel== selectedchannel);
    // selectedid = newlist.first.id.toString();
    // update();
  }

  // getname(){
  //   var newlsit = channelList.where((element) => element.channel = selectedchannel);
  //   selectedTown = newlsit.first.id;
  // }
  setSelectedid(String id){
    selectedid = id;
    update();
  }

  getNameList(String selectedBrand) {
    // districtList = [];

      var newlsit = channelList.where((element) => element.channel == selectedchannel);
      selectedid = newlsit.first.id.toString();
    // var newList = channelList
    //     .where((element) => element.brandname == selectedBrand)
    //     .toList();
    // var newdistrictList = newList.groupListsBy((element) => element.name);
    // newdistrictList.keys.forEach((names) {
    //   name.add(names.toString()) ;
    //
    // });
    // var newlists = productList.where((element) => element.name == name.first);
    // selectedAreaId = newlists.first.id.toString();
    // var newList = channelList
    //     .where((element) => element.channel == selectedBrand)
    //     .toList();
    // newList.forEach((element) {idss.add(element.id);});
    // setSelectedid(idss.first);
   // var newdistrictList = newList.groupListsBy((element) => element.name);
    // newdistrictList.keys.forEaczh((names) {
    //   name.add(names);
    // });
    // setSelectedName(name.first);
    // setSelectedValue(value.first);

    // var newdistrictLists = newList.groupListsBy((element) => element.id);
    // newdistrictList.keys.forEach((names) {
    //   name.add(names);
    // });
    //getAreaList(name.first);

    update();
  }

  getChannelList() async {
    var conn = await Utilities.isInternetWorking();
    if (conn) {
      await fetchChannelApi().then((value) async {
        print(value.response);
        if (value.success) {
          channelList = value.response;
          print(channelList.length);
          setSelectedTown(channelList.first.id );
         // setSelectedid(channelList.first.channel );
          update();

          print(channelList.length);
          // var newlist = list.where((element) => element.channel== selectedchannel);
          // selectedid = newlist.first.id.toString();
          // Get.find<PreferenceController>()
          //     .saveAddress(jsonEncode(value.response));
        }else{
          Utilities.showInToast(value.message, toastType: ToastType.ERROR);
         channelList= [];
          update();
        }
      });
    }
}}