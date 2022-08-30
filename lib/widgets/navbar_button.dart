import 'package:cov_meds/constants/values.dart';
import 'package:flutter/material.dart';

class NavbarButton extends StatelessWidget {
  final String? label;
  final Function? onTap;
  final double? horizontalPadding;
  final double? verticalPadding;
  const NavbarButton({required this.label, required this.onTap, this.horizontalPadding, 
    this.verticalPadding, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding ?? 0.0, vertical: verticalPadding ?? 0.0),
      child: TextButton(
        onPressed: () => onTap!(),
        child: Text(label!, style: navBtnStyle)
      ),
    );
  }
}