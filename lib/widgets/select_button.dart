import 'package:cov_meds/constants/values.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SelectButton extends StatefulWidget {
  final List<Map<String, String>>? options;
  final Function? onSelect;
  final double? height;
  final Color? borderColor;
  final double? borderRadius;
  final String? hintText;
  final Color? hintColor;
  final double? hintSize;
  final Color? fillColor;
  final Icon? icon;
  final double? iconSize;
  String? dropdownValue;
  SelectButton({Key? key, @required this.options, @required this.dropdownValue, @required this.onSelect, this.height, this.hintText,
    this.hintColor, this.borderColor, this.borderRadius, this.fillColor, this.icon, this.iconSize, this.hintSize}) : super(key: key);
  @override
  _SelectButtonState createState() => _SelectButtonState();
}

class _SelectButtonState extends State<SelectButton> {

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.fillColor ?? Colors.grey[100],
        borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius ?? 10.0)),
        border: Border.all(color: borderColor),
      ),
      height: widget.height ?? 30.0,
      padding: const EdgeInsets.only(left: 12.0, right: 20.0),
      child: DropdownButton<String>(
        isExpanded: true,
        iconSize: widget.iconSize ?? 0,
        icon: widget.icon,
        value: widget.dropdownValue,
        hint: Text(widget.hintText ?? '<Select>', style: TextStyle(color: widget.hintColor ?? Colors.grey, fontSize: widget.hintSize ?? 13.0,)),
        style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: widget.hintSize ?? 15.0),
        dropdownColor: Colors.white,
        focusColor: Colors.grey[100],
        underline: Container(
          height: 0,
        ),
        onChanged: (String? newValue) {
          widget.onSelect!(newValue);
        },
        items: widget.options!.map<DropdownMenuItem<String>>((Map<String, String> dropdownItem) {
          return DropdownMenuItem<String>(
            value: dropdownItem['value'],
            child: Text(dropdownItem['name'] ?? ''),
          );
        }).toList(),
      ),
    );
  }
}
