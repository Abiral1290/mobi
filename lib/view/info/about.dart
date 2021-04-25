import 'package:flutter/material.dart';
import 'package:mobitrack_dv_flutter/utils/constants.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
      ),
      body: Column(
        children: [
          Image.asset('assets/DV_banner.png'),
          Text('V ' + Constants.appVername)
        ],
      ),
    );
  }
}
