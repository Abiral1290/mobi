import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceController extends GetxController {
  String checkIn = "checkIn";
  String logIn = "logIn";
  String user = "user";
  String distributors = "distributors";
  String address = "address";
  String location = "location";
  bool isCheckedIn = false;

  clear() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    await _preferences.clear();
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

  setCheckInValue(bool checkInData, {String checkInId = ""}) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    try {
      _preferences
          .setString(checkIn,
              DateTime.now().toString() + "//$checkInId" + "//$checkInData")
          .then((value) {
        if (value) isCheckedIn = checkInData;
        update();
        print("Checked In: $isCheckedIn");
      });
    } catch (e) {
      print("error fetching data");
    }
  }

  Future<String> getCheckInValue() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    var now = DateTime.now();
    var today = now.year.toString() +
        "-" +
        now.month.toString() +
        "-" +
        now.day.toString();
    try {
      var value = _preferences.getString(checkIn);

      if (value != null) {
        var date = value.split("//").first;
        var parsedDdate = DateTime.parse(date);
        var addedDate = parsedDdate.year.toString() +
            "-" +
            parsedDdate.month.toString() +
            "-" +
            parsedDdate.day.toString();
        if (addedDate == today) {
          isCheckedIn = value.split("//").last == "true" ? true : false;
        } else {
          isCheckedIn = false;
        }
      }
      update();
      return value ?? "";
    } catch (e) {
      print("error fetching data");
      return "";
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

  setLocation(String latitude, String longitude) async {
    try {
      var pref = await SharedPreferences.getInstance();
      pref.setString(location, "$latitude,$longitude");
    } catch (e) {
      print("failed to store location");
      print(e);
    }
  }

  Future<String> getLocation() async {
    try {
      var pref = await SharedPreferences.getInstance();
      return pref.getString(location) ?? "";
    } catch (e) {
      print("failed to get location");
      print(e);
      return null;
    }
  }
}
