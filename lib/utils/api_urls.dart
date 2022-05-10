class ApiUrls {
  static final String _mainUrl = 'http://202.52.240.148:5063/dv_trading';
//  static final String _mainUrl_1 = 'http://202.52.240.148:5063/dv_trading/public/';
  static final String _oldMainUrl = 'http://202.52.240.148:8092/';
  static final String manufacture = '/202.52.240.148:5062/public';
  //static final String _mainUrl = 'http://192.168.0.134:8095/dv_trading';
  static final String _endPoint = _mainUrl + '/api/';
  static final String downloadUrl = _mainUrl;
  static final String checkForUpdate = _endPoint + 'app_versions';
  static final String login = _endPoint + 'login';
  static final String store = _mainUrl + '/public';
  static final String outlet_post = _endPoint + "outlets";
  static final String channel = _endPoint + "channel_list";
  static final String town = _endPoint + "town_list";
  static final String category = _endPoint + "category_list";
  static final String outlets = _endPoint + 'route_wise_outlet?route_id=';
  static final String getoutlet = _endPoint + 'getalloutlets';
  static final String route = _endPoint + 'routelog';
  //202.52.240.148:8095/dv_tradz≈çzzzzzzzΩing/api/outlets? distributor_id=1
  static final String products = _endPoint + 'products';
  static final String sales = _endPoint + 'sales';
  static final String routes = _endPoint + 'routelist';
  static final String appversion = _endPoint + 'app_versions';

  static final String banks = _endPoint + 'banks';
  static final String address = _endPoint + 'get-locations';
  static final String collections = _endPoint + 'collections';
  static final String distributors = _endPoint + 'distributors';
  static final String checkInOuts =
      _endPoint + 'check_in_outs'; //get to fetch data and post to check in
  static final String _mainUrl_1 = 'http://202.52.240.148:5063/dv_trading/public/';
  static final String checkOut = _endPoint + 'checkout';
  static final String dailyLocation = _endPoint + 'daily_locations';
  static final String monthlyTour = _endPoint + 'monthly_tours';
  static final String stockCounts = _endPoint + 'stock_counts';

  static final String storageURL = _mainUrl + 'image';

  /*
      CallServer URLs
  */
  static final String _callServerUrl = _oldMainUrl + 'callserver/api/';
  static final String getServerNum = _callServerUrl + 'get_server_number';

  ///call_record_verification?mobile_number=9841372105&server_number=9841345921
  static final String verifyCall = _callServerUrl + 'call_record_verification?';
}
