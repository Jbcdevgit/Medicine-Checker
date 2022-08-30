import 'package:cov_meds/constants/values.dart';
import 'package:flutter/material.dart';

class MedListItem extends StatelessWidget {
  final String name;
  final Function onTap;
  const MedListItem({required this.name, required this.onTap, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        margin: const EdgeInsets.all(10.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          border: Border.all(color: Colors.blueGrey, width: 1.0),
          borderRadius: BorderRadius.circular(5.0)
        ),
        child: Center(child: Text(name, style: medItemText,)),
      ),
    );
  }
}