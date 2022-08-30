import 'package:cov_meds/constants/values.dart';
import 'package:flutter/material.dart';

class FormInputTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final String? hintText;
  final String? Function(String?)? validator;
  final double? height;
  final IconData? icon;
  final Function(String)? onChanged;
  final bool? obscure;
  const FormInputTextField({Key? key, @required this.controller, @required this.label, this.hintText, this.validator, this.onChanged,
   this.height, this.icon, this.obscure}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.start,
      children: [
        Text(label ?? '', style: formLabelText,),
        Container(
          height: height ?? 40.0,
          decoration: BoxDecoration(
            border: Border.all(color: borderColor, width: 1.0, style: BorderStyle.solid,),
          ),
          child: Row(
            children: [
              ColoredBox(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(icon ?? Icons.label, color: primaryColor,),
                ),
                color: const Color(0xffe3e3e3),
              ),
              Expanded(
                child: TextFormField(
                  controller: controller,
                  validator: validator,
                  obscureText: obscure ?? false,
                  onChanged: onChanged,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding: const EdgeInsets.only(left: 10.0, bottom: 10.0),
                    hintText: hintText,
                    hintStyle: hintTextStyle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}