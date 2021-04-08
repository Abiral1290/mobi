import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mobitrack_dv_flutter/controller/auth_controller.dart';
import 'package:mobitrack_dv_flutter/utils/call_server.dart';
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

    getCallServerNumber().then((value) {
      if (value.isNotEmpty) if (this.mounted)
        setState(() => _callServerNum = value);
      else {}
    });
  }

  showLoading() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => CupertinoAlertDialog(
              title: new Text("Please Wait"),
              content: Column(
                children: [
                  new Text("Your call is being validated."),
                  CupertinoActivityIndicator()
                ],
              ),
              actions: <Widget>[],
            ));

    await Future.delayed(Duration(seconds: 7));

    var res = await callServerVerify(_userNUmber, _callServerNum);

    if (res) {
      await Get.find<AuthController>().signIn(_userNUmber);
    } else {
      Utilities.showInToast("Couldn't validate your number. Please try again",
          toastType: ToastType.ERROR);
    }

    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: _callServerNum.isEmpty
            ? CircularProgressIndicator()
            : FloatingActionButton(
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
                      launch('tel://$_callServerNum');

                      showLoading();
                    } else {
                      Utilities.showInToast('No internet',
                          toastType: ToastType.ERROR);
                    }
                  }
                },
              ),
        backgroundColor: Colors.white,
        body: Container(
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
      ),
    );
  }
}
