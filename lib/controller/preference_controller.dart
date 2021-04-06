import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceController extends GetxController {
  String checkIn = "checkIn";
  String logIn = "logIn";
  bool isCheckedIn = false;

  Future<bool> getCheckInValue() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    try {
      var value = _preferences.getBool(checkIn) ?? false;

      if (value != null) isCheckedIn = value;
      update();
      return value;
    } catch (e) {
      print("error fetching data");
      return false;
    }
  }

  setCheckInValue(bool checkInData) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    try {
      _preferences.setBool(checkIn, checkInData).then((value) {
        if (value) isCheckedIn = checkInData;
      });
    } catch (e) {
      print("error fetching data");
    }
    update();
  }

  Future<bool> getLogInValue() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    try {
      var value = _preferences.getBool(logIn);
      print(value.toString());
      return value;
    } catch (e) {
      print("error fetching data");
      return false;
    }
  }

  Future<bool> setLoggedIn(bool loggedIn) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    try {
      _preferences.setBool(logIn, loggedIn).then((value) {
        return value;
      });
      return true;
    } catch (e) {
      print("error fetching data");
      return false;
    }
  }
}
