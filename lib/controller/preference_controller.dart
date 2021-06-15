import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceController extends GetxController {
  String checkIn = "checkIn";
  String logIn = "logIn";
  String user = "user";
  String distributors = "distributors";
  String address = "address";
  bool isCheckedIn = false;

  clear() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    await _preferences.clear();
  }

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

  saveUser(String userData) async {
    try {
      var pref = await SharedPreferences.getInstance();
      pref.setString(user, userData);
    } catch (e) {
      print("failed to store user");
      print(e);
    }
  }

  Future<String> getUser() async {
    try {
      var pref = await SharedPreferences.getInstance();
      return pref.getString(user);
    } catch (e) {
      print("failed to get user");
      print(e);
      return null;
    }
  }

  saveAddress(String addressData) async {
    try {
      var pref = await SharedPreferences.getInstance();
      pref.setString(address, addressData);
    } catch (e) {
      print("failed to store user");
      print(e);
    }
  }

  Future<String> getAddress() async {
    try {
      var pref = await SharedPreferences.getInstance();
      return pref.getString(address);
    } catch (e) {
      print("failed to get address");
      print(e);
      return null;
    }
  }

  setCheckInValue(bool checkInData) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    try {
      _preferences.setBool(checkIn, checkInData).then((value) {
        if (value) isCheckedIn = checkInData;
        update();
        print("Checked In: $isCheckedIn");
      });
    } catch (e) {
      print("error fetching data");
    }
  }

  setDistributor(String distributorData) async {
    try {
      var pref = await SharedPreferences.getInstance();
      pref.setString(distributors, distributorData);
    } catch (e) {
      print("failed to store distributor");
      print(e);
    }
  }

  Future<String> getDistributor() async {
    try {
      var pref = await SharedPreferences.getInstance();
      return pref.getString(distributors) ?? "";
    } catch (e) {
      print("failed to get distributors");
      print(e);
      return null;
    }
  }
}
