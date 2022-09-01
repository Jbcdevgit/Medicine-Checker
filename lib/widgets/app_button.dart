import 'package:cov_meds/constants/values.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String title;
  final Function onTap;
  final double horizontalPadding;
  final double verticalPadding;
  final Color buttonColor;
  final TextStyle textStyle;

  const AppButton({required this.title, required this.onTap, this.horizontalPadding=20.0, this.verticalPadding=7.0, 
  this.buttonColor=primaryColor, this.textStyle=buttonTextBold, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
          side: const BorderSide(color: Colors.transparent),
        ),
        padding: EdgeInsets.symmetric(vertical: verticalPadding, horizontal: horizontalPadding),
        primary: buttonColor,
      ),
      onPressed: () => onTap(),
      child: Text(title, style: textStyle),
    );
  }
}
