import 'package:mobitrack_dv_flutter/model/distributor.dart';

class Constants {
  static final String callServerToken = 'abcdefghij';
  static final int callWaitSec = 22;
  static Distributor selectedDistributor;
  static int appVerId = 0;
  static String appVername = '';
  static final String tempApkName = 'temp_dv.apk';
  static String checkInOut;
  static double locationRadius = 20.0; // in meter
}

class SellerType {
  static final mart = 'MART';
  static final wholeSeller = 'WHOLESELLER';
  static final retailer = 'RETAILER';
  static final hawcker = 'HAWCKER';
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
