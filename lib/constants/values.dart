import 'package:flutter/material.dart';

String lang = 'jp';
const locale = Locale('ja', '');
const borderColor = Colors.black87;
const primaryColor = Colors.teal;

const navBtnStyle =
    TextStyle(fontSize: 15.0, color: Colors.white, fontWeight: FontWeight.bold);

const formLabelText = TextStyle(
  fontSize: 15.0,
);

TextStyle medItemText = TextStyle(
  fontSize: 15.0,
  fontFamily: lang == 'jp' ? "Hiragino Sans" : null,
  locale: locale,
);

const selectedMedText = TextStyle(
  fontSize: 13.0,
  fontWeight: FontWeight.bold,
);

const medItemBlueText = TextStyle(fontSize: 15.0, color: Colors.blue);

const hintTextStyle = TextStyle(fontSize: 15.0, color: Colors.grey);

const buttonTextBold =
    TextStyle(fontSize: 15.0, color: Colors.white, fontWeight: FontWeight.bold);
