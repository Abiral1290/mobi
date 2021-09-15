import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mobitrack_dv_flutter/controller/auth_controller.dart';
import 'package:mobitrack_dv_flutter/utils/call_server.dart';
import 'package:mobitrack_dv_flutter/utils/constants.dart';
import 'package:mobitrack_dv_flutter/utils/utilities.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _callServerNum = '';
  String _userNUmber = '';

  @override
  void initState() {
    super.initState();
    _initFunc();
  }

  _initFunc() async {
    int count = 0;
    do {
      var value = await getCallServerNumber();
      print('call server: ' + value);
      if (value.isNotEmpty) {
        setState(() => _callServerNum = value);
        break;
      } else {
        count++;
      }
    } while (count < 3);
    if (count == 3 && _callServerNum.isEmpty) {
      Utilities.showInToast(
          "Coundn't fetch call server number. Please try again",
          toastType: ToastType.ERROR);
    }
  }

  byPassCallServer() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => WillPopScope(
          child: CupertinoAlertDialog(
            title: new Text("Please Wait"),
            content: Column(
              children: [new Text("Logging in."), CupertinoActivityIndicator()],
            ),
            actions: <Widget>[],
          ),
          onWillPop: () async {
            return false;
          }),
    );

    var resp = await Get.find<AuthController>().signIn(_userNUmber);
    Get.back();
    Utilities.showInToast(
      resp.toString(),
    );
  }

  showLoadingandCheckAPI() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => WillPopScope(
          child: CupertinoAlertDialog(
            title: new Text("Please Wait"),
            content: Column(
              children: [
                new Text("Your call is being validated."),
                CupertinoActivityIndicator()
              ],
            ),
            actions: <Widget>[],
          ),
          onWillPop: () async {
            return false;
          }),
    );

    await Future.delayed(Duration(seconds: Constants.callWaitSec));

    var res = await callServerVerify(_userNUmber, _callServerNum);
    Get.back();

    if (res) {
      var resp = await Get.find<AuthController>().signIn(_userNUmber);
      Utilities.showInToast(
        resp,
      );
    } else {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => CupertinoAlertDialog(
                title: new Text("Error"),
                content: new Text("Session Expired. Please call again"),
                actions: <Widget>[
                  CupertinoDialogAction(
                    child: Text('Close'),
                    onPressed: () => Get.back(),
                  )
                ],
              ));
      Utilities.showInToast("Couldn't validate your number. Please try again",
          toastType: ToastType.ERROR);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton:
            // _callServerNum.isEmpty
            //     ? CircularProgressIndicator()
            //     :
            FloatingActionButton(
          backgroundColor: Colors.green,
          child: Icon(Icons.call),
          onPressed: () async {
            FocusScope.of(context).unfocus();
            if (_userNUmber.length < 10) {
              Utilities.showInToast('Please input 10 digit valid number.',
                  toastType: ToastType.ERROR);
            } else {
              var conn = await Utilities.isInternetWorking();
              if (conn) {
                // code to bypass call server
                // byPassCallServer();

                // code to verify call server
                launch('tel://$_callServerNum');
                showLoadingandCheckAPI();
              } else {
                Utilities.showInToast('No internet',
                    toastType: ToastType.ERROR);
              }
            }
          },
        ),
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(22.0),
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/DV_logo.png'),
                backgroundColor: Colors.black12,
                radius: 80,
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  onChanged: (s) => _userNUmber = s,
                  maxLength: 10,
                  style: TextStyle(fontSize: 25),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration: InputDecoration(
                      labelText: "Phone Number",
                      prefixText: '+977 ',
                      prefixIcon: Icon(
                        Icons.phone_android_rounded,
                        color: Colors.black,
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
