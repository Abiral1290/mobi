class ApiUrls {
  static final String _callServerUrl =
      'http://202.52.240.148:8092/callserver/api/';
  static final String getServerNum = _callServerUrl + 'get_server_number';

  ///call_record_verification?mobile_number=9841372105&server_number=9841345921
  static final String verifyCall = _callServerUrl + 'call_record_verification?';

  // http://202.52.240.148:8092/callserver/api/record_call_log?mobile_number=9843441329&server_number=9801980384
}
