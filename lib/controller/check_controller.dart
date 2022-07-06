import 'package:get/get.dart';
import 'package:mobitrack_dv_flutter/model/check_in_out.dart';
import 'package:mobitrack_dv_flutter/utils/utilities.dart';

class CheckController extends GetxController{
  List<CheckInOut>? checkin =[];
  var dates ;
  List? datess;
  DateTime? datetime;

  CheckController(){
    fetchCheckidata();
  }

  fetchCheckidata() async {
    var conn = await Utilities.isInternetWorking();
    if(conn)  {
      await fetchcheckDataApi().then((value) {
        if(value.success!){
      //   dates = value.response;
          checkin = value.response;

          update();
        }else{
          Utilities.showInToast(value.message!, toastType: ToastType.ERROR);
          update();
        }
      });
    }
  }
  datetimecheckin(){
   // DateTime fits = checkin.first.checkinDeviceTime;
    datetime =checkin!.first.checkinDeviceTime!.add( Duration(hours: 6));
  }
  groupby (){
     datess = dates.groupListsBy((element) => element.date);
    // dates = checkin.groupListsBy((element) => element.date);
  }
}