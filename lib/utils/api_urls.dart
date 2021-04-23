class ApiUrls {
  static final String _mainUrl = 'http://202.52.240.148:5062/dv_group/public';
  static final String _oldMainUrl = 'http://202.52.240.148:8092/';
  static final String _endPoint = _mainUrl + '/api/';
  static final String downloadUrl = _mainUrl;
  static final String checkForUpdate = _endPoint + 'app_versions';
  static final String login = _endPoint + 'login';
  static final String outlets = _endPoint + 'outlets';
  static final String products = _endPoint + 'products';
  static final String sales = _endPoint + 'sales';
  static final String collections = _endPoint + 'collections';
  static final String distributors = _endPoint + 'distributors';
  static final String checkInOuts = _endPoint + 'check_in_outs';

  static final String storageURL = _mainUrl + 'dv_group/public';

  /*
      CallServer URLs
  */
  static final String _callServerUrl = _oldMainUrl + 'callserver/api/';
  static final String getServerNum = _callServerUrl + 'get_server_number';

  ///call_record_verification?mobile_number=9841372105&server_number=9841345921
  static final String verifyCall = _callServerUrl + 'call_record_verification?';
}
