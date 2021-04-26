import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:dio/dio.dart';

Future downloadApk(String url, String downloadPath, context) async {
  var downloading = false;

  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (cnt1) {
      double progress = 0.0;
      var startTime = DateTime.now().millisecondsSinceEpoch;
      String remaining = 'unknown';

      return WillPopScope(
        onWillPop: () {},
        child: StatefulBuilder(
          builder: (cnt2, setState) {
            if (!downloading) {
              downloading = true;
              Dio().download(url, downloadPath,
                  onReceiveProgress: (received, total) async {
                setState(() {
                  progress = received / total;

                  var elapsedTime =
                      DateTime.now().millisecondsSinceEpoch - startTime;
                  var chunksPerTime = received / elapsedTime;
                  var estimatedTotalTime = total / chunksPerTime;
                  var timeLeftInSeconds =
                      (estimatedTotalTime - elapsedTime) / 1000;
                  remaining = timeLeftInSeconds.toStringAsFixed(0) +
                      ' seconds remaining';
                });
                if (progress == 1.0) {
                  remaining = 'Completed!';
                  const platform = const MethodChannel('technosales.mobi_dv');

                  await platform
                      .invokeMethod('install_app', {'path': downloadPath});
                }
              });
            }
            return AlertDialog(
              title: Text('Updating'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                      'Please wait and stay connected until the update is finished.'),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        ((progress * 100).toStringAsFixed(0)).toString() + '%'),
                  ),
                  Text(remaining),
                  LinearProgressIndicator(
                    value: progress,
                  )
                ],
              ),
              actions: <Widget>[],
            );
          },
        ),
      );
    },
  );
}
