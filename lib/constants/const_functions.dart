import 'package:cov_meds/constants/values.dart';
import 'package:flutter/material.dart';

preventDoubleTap(context) {
  showDialog(context: context, builder:(context) => WillPopScope(onWillPop: () async => false, child: const Center(child: CircularProgressIndicator())));
}

showAlertDialougue(context, {required String title, required String content}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Text(title),
          ),
        ),
        contentPadding: const EdgeInsets.only(top: 40.0, bottom: 40.0, left: 20.0, right: 20.0),
        content: Wrap(
          alignment: WrapAlignment.center,
          children: [
            Text(content, style: formLabelText, textAlign: TextAlign.center,),
            const SizedBox(height: 35.0, width: double.infinity,),
            TextButton(child: const Text('Close'), onPressed: () => Navigator.pop(context)),
          ],
        ),
      );
    },
  );
}