import 'package:flutter/material.dart';
import 'package:onboard/core/constants/AppColors.dart';

class TextFieldController extends StatelessWidget {
  final TextEditingController textEditingController;
  final labeltext;
  final TextInputType textInputType;
  final Icon? prefixIcon;
  final double borderRadius;
  final border = 1;
  final bool obscureText;
  final String hinttext;

  const TextFieldController({
    super.key,
    required this.textEditingController,
    this.labeltext,
    required this.textInputType,
    this.prefixIcon,
    this.borderRadius = 8.0,
    required this.obscureText,
    required this.hinttext,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Container(
        height: 44,
        child: TextFormField(
          obscureText: obscureText,
          controller: textEditingController,
          keyboardType: textInputType,
          decoration: InputDecoration(
              prefixIcon: prefixIcon != null ? prefixIcon : null,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              labelText: labeltext,
              hintText: hinttext,
              hintStyle: TextStyle(color: AppColors.black),
              focusColor: AppColors.black,
              enabledBorder: OutlineInputBorder(
                  // borderRadius: BorderRadius.all(Radius.circular(8)),
                  borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                  borderSide: BorderSide(color: AppColors.black)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.black))),
        ),
      ),
    );
  }
}
