import 'package:flutter/material.dart';

class NavDropDownBtn extends StatelessWidget {
  final Widget title;
  final Function onChange;
  final List<Map<String, String>> items;
  const NavDropDownBtn(
      {required this.title,
      required this.onChange,
      required this.items,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 50.0, top: 4.0),
      child: DropdownButton<String>(
        icon: title,
        hint: const Text(''),
        style: const TextStyle(fontSize: 14.0),
        dropdownColor: Colors.white,
        underline: Container(
          height: 0,
        ),
        focusColor: Colors.transparent,
        onChanged: (String? newValue) => onChange(newValue),
        items: items.map<DropdownMenuItem<String>>((Map<String, String> value) {
          return DropdownMenuItem<String>(
            value: value['value'],
            child: Text(value['name'] ?? ''),
          );
        }).toList(),
      ),
    );
  }
}
