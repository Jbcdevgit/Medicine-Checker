import 'package:cov_meds/constants/values.dart';
import 'package:flutter/material.dart';

class TextInputField extends StatefulWidget {
  final TextEditingController controller;
  final String? label;
  final String? hintText;
  final Function? validator;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final bool? enabled;
  final int? maxLines;
  const TextInputField({Key? key, required this.controller, this.label, this.hintText, this.validator, this.keyboardType, this.obscureText, 
  this.enabled, this.maxLines}) : super(key: key);

  @override
  State<TextInputField> createState() => _TextInputFieldState();
}

class _TextInputFieldState extends State<TextInputField> {
  bool obscured = false;
  IconData suffixIcon = Icons.visibility_outlined;

  @override
  void initState() {
    super.initState();
    obscured = widget.obscureText ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: widget.enabled ?? true,
      maxLines: widget.maxLines ?? 1,
      keyboardType: widget.keyboardType,
      controller: widget.controller,
      obscureText: obscured,
      validator: (value) {
        if(widget.validator != null) {
          return widget.validator!(value);
        }
        return null;
      },
      cursorColor: primaryColor,
      decoration: InputDecoration(
        suffixIcon: Visibility(
          visible: widget.obscureText ?? false,
          child: IconButton(
            icon: Icon(suffixIcon),
            onPressed: () => setState(() {
              obscured = !obscured;
              suffixIcon == Icons.visibility_outlined ? 
              suffixIcon = Icons.visibility_off_outlined : suffixIcon = Icons.visibility_outlined;
            }),
          ),
        ),
        labelText: widget.label,
        labelStyle: formLabelText,
        hintText: widget.hintText,
        hintStyle: hintTextStyle,
        errorStyle: const TextStyle(fontSize: 13.0),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: primaryColor,),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: primaryColor,),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red,),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red,),
        ),
      ),
    );
  }
}