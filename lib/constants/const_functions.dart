import 'package:cov_meds/constants/values.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

preventDoubleTap(context) {
  showDialog(
      context: context,
      builder: (context) => WillPopScope(
          onWillPop: () async => false,
          child: const Center(child: CircularProgressIndicator())));
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
        contentPadding: const EdgeInsets.only(
            top: 40.0, bottom: 40.0, left: 20.0, right: 20.0),
        content: Wrap(
          alignment: WrapAlignment.center,
          children: [
            Text(
              content,
              style: formLabelText,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 35.0,
              width: double.infinity,
            ),
            TextButton(
                child: const Text('Close'),
                onPressed: () => Navigator.pop(context)),
          ],
        ),
      );
    },
  );
}

showMedicineResultDialouge(context,
    {required String title,
    required String medicineName,
    required String generic,
    required String effect}) {
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
        contentPadding: const EdgeInsets.only(
            top: 40.0, bottom: 40.0, left: 20.0, right: 20.0),
        content: Wrap(
          alignment: WrapAlignment.start,
          children: [
            Wrap(
              children: [
                const Text(
                  '商品名(一般名):  ',
                  style: formLabelBold,
                ),
                Text(
                  medicineName + ' ($generic)',
                  style: formLabelText,
                ),
              ],
            ),
            const SizedBox(
              height: 15.0,
              width: double.infinity,
            ),
            Wrap(
              children: [
                const Text(
                  '効能又は効果:  ',
                  style: formLabelBold,
                ),
                Text(
                  effect,
                  style: formLabelText,
                ),
              ],
            ),
            const SizedBox(
              height: 15.0,
              width: double.infinity,
            ),
            Wrap(
              children: [
                const Text(
                  'リンク:  ',
                  style: formLabelBold,
                ),
                TextButton(
                  onPressed: () async {
                    if (!await launchUrl(Uri.parse(
                        'https://www.mhlw.go.jp/content/000903772.pdf'))) {
                      showAlertDialougue(
                        context,
                        title: 'Invalid URL',
                        content: '',
                      );
                    }
                  },
                  child: const Text(
                    'https://www.mhlw.go.jp/content/000903772.pdf',
                    style: medItemBlueText,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 35.0,
              width: double.infinity,
            ),
            Align(
              alignment: Alignment.center,
              child: TextButton(
                child: const Text('Close'),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      );
    },
  );
}
