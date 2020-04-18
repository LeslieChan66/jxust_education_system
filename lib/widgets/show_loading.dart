import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

showLoading(BuildContext context, String message) {
  showDialog(
    context: context,
    barrierDismissible: false, //点击遮罩不关闭对话框
    builder: (context) {
      return UnconstrainedBox(
        constrainedAxis: Axis.vertical,
        child: SizedBox(
          width: 250,
          height: 250,
          child: AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SpinKitCircle(color: Colors.blue, ),
                Padding(
                  padding: const EdgeInsets.only(top: 26.0),
                  child: Text(message, style: TextStyle(fontFamily: 'ArtFont'),),
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}