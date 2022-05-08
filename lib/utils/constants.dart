import 'package:image_picker/image_picker.dart';
import 'package:mobitrack_dv_flutter/model/distributor.dart';

import '../model/address.dart';
import '../model/category.dart';
import '../model/channel.dart';
import '../model/outlet.dart';
import '../model/routes.dart';
import '../model/town.dart';

class Constants {
  static final String callServerToken = 'abcdefghij';
  static final String looged = 'Logged In';
  static final int callWaitSec = 22;
  static Distributor selectedDistributor;
  static int value_increase = 0;
  static Routees selectedRoute;
  static String selectmyRoute;
  static String selectedbrand;
  static int increase_unsucessfulcall =0;
  static int storage;
  static Outlet selectedbrand_name;
  static String outletCount;
  static Town  selectedtown;
  static Channel selectedchannel;
  static int increase;
  static String item;
  static Route selectedroute;
  static Town selectedzone;
  static Categories selectedcategory;
  static Outlet selectid;
  static Outlet id;
  static Outlet  selectedOutlets;
  static List<Outlet> outletLlist;
  static String image;

  static int appVerId = 0;
  static String appVername = '';
  static final String tempApkName = 'temp_dv.apk';
  static String checkInOut;
  static double locationRadius = 10.0; // in meter
  static const googleAPIKey = "AIzaSyC_siAOGtkjHJ4i_1SzyjaSV8VC83vfYAw";
  static bool isProduction = true;

  static String server = " ";
  static const server_2 = "Server 2";
  static const server_1 = "Server 1";
}

class SellerType {
  static final mart = 'MART';
  static final wholeSeller = 'WHOLESELLER';
  static final retailer = 'RETAILER';
  static final hawcker = 'HAWCKER';
}

class Remarktype{
  static final closed_outlet = 'Outlet Closed ';
  static final stock_avai = "Stock Availabe  ";
  static final owner_shop = "Owner not in shop";
  static final margin_issue = "margin Issue";
  static final credit_limit = "Credit limit Issue";
}

class PaymentMode {
  static final cash = 'CASH';
  static final cheque = 'CHEQUE';
}

class AccountOf {
  static final gsi = 'GSI';
  static final gnp = 'GNP';
}

class Check {
  static final checkIn = 'IN';
  static final checkOut = 'OUT';
}
