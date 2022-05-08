import 'constants.dart';

class ApiUrls_Group {

  // static String get _mainUrl => Constants.isProduction
  //     ? "http://202.52.240.148:8095/dv_trading/public" //DV_Trading
  //     : "http://202.52.240.148:8095/dv_group/public"; //DV_Group
  static final String _mainUrl = 'http://202.52.240.148:8095/dv_group/public';
  static final String _oldMainUrl = 'http://202.52.240.148:8092/';
  static final String _endPoint = _mainUrl + '/api/';
  static final String downloadUrl = _mainUrl;
  static final String checkForUpdate = _endPoint + 'app_versions';
  static final String login = _endPoint + 'login';
  static final String outlets = _endPoint + 'outlets?distributor_id=';
  static final String getoutlet = _endPoint + 'outlets?distributor_id=';
  static final String products = _endPoint + 'products';
  static final String sales = _endPoint + 'sales';
  static final String banks = _endPoint + 'banks';
  static final String address = _endPoint + 'get-locations';
  static final String collections = _endPoint + 'collections';
  static final String distributors = _endPoint + 'distributors';
  static final String checkInOuts =
      _endPoint + 'check_in_outs'; //get to fetch data and post to check in
  static final String checkOut = _endPoint + 'checkout';
  static final String dailyLocation = _endPoint + 'daily_locations';
  static final String monthlyTour = _endPoint + 'monthly_tours';
  static final String stockCounts = _endPoint + 'stock_counts';

  static final String storageURL = _mainUrl + 'dv_trading/public';

  /*
      CallServer URLs
  */
  static final String _callServerUrl = _oldMainUrl + 'callserver/api/';
  static final String getServerNum = _callServerUrl + 'get_server_number';

  ///call_record_verification?mobile_number=9841372105&server_number=9841345921
  static final String verifyCall = _callServerUrl + 'call_record_verification?';
}
