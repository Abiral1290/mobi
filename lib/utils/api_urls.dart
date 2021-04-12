class ApiUrls {
  static final String _mainUrl = 'http://202.52.240.148:5062/';
  static final String _endPoint = _mainUrl + 'dv_group/public/api/';
  static final String login = _endPoint + 'login';
  static final String outlets = _endPoint + 'outlets';
  static final String products = _endPoint + 'products';
  static final String sales = _endPoint + 'sales';

  /*
      CallServer URLs
  */
  static final String _callServerUrl = _mainUrl + 'callserver/api/';
  static final String getServerNum = _callServerUrl + 'get_server_number';

  ///call_record_verification?mobile_number=9841372105&server_number=9841345921
  static final String verifyCall = _callServerUrl + 'call_record_verification?';
}
