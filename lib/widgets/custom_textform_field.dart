import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/color_constants.dart';
import '../../constants/global_constants.dart';

class CustomTextFormField extends StatelessWidget {
  final Color inputColor;
  final String hintText;
  final Color hintTextColor;
  final bool obscureText;
  final String labelText;
  final Color labelColor;
  final TextEditingController controller;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final double hintTextFontSize;
  final double labelTextFontSize;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color fillColor;
  final bool willContainPrefix;

  const CustomTextFormField({
    Key? key,
    required this.hintText,
    this.hintTextColor = const Color(0xFFCDCDCD),
    this.obscureText = false,
    required this.controller,
    this.onChanged,
    this.validator,
    this.keyboardType = TextInputType.name,
    required this.hintTextFontSize,
    this.prefixIcon,
    this.suffixIcon,
    this.fillColor = whiteColor,
    this.willContainPrefix = true,
    required this.labelText,
    required this.labelColor,
    required this.labelTextFontSize,
    required this.inputColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      style: GoogleFonts.poppins(
        fontSize: hintTextFontSize,
        fontWeight: FontWeight.w500,
        color: inputColor,
      ),
      decoration: InputDecoration(
          prefixIcon: willContainPrefix
              ? Padding(
                  padding: EdgeInsets.only(
                    left: widthValue5,
                    right: widthValue10,
                  ),
                  child: prefixIcon,
                )
              : const SizedBox.shrink(),
          filled: true,
          fillColor: fillColor,
          prefixIconConstraints: willContainPrefix
              ? BoxConstraints(
                  maxHeight: heightValue40,
                  maxWidth: heightValue40,
                  minHeight: heightValue40,
                  minWidth: heightValue40,
                )
              : BoxConstraints.loose(const Size(0, 0)),
          hintText: hintText,
          labelText: labelText,
          suffixIcon: suffixIcon,
          hintStyle: GoogleFonts.poppins(
            fontSize: hintTextFontSize,
            fontWeight: FontWeight.w500,
            color: hintTextColor,
          ),
          labelStyle: GoogleFonts.poppins(
            fontSize: labelTextFontSize,
            fontWeight: FontWeight.w500,
            color: labelColor,
          ),
          contentPadding: EdgeInsets.all(heightValue10),
          border: InputBorder.none,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: widthValue2),
            borderRadius: BorderRadius.circular(10.0),
          ),
          floatingLabelStyle: GoogleFonts.aBeeZee(
            fontSize: labelTextFontSize,
            fontWeight: FontWeight.w600,
            color: labelColor,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black, width: 1.5),
            borderRadius: BorderRadius.circular(10.0),
          )),
      cursorColor: Colors.black,
      obscureText: obscureText,
      onChanged: onChanged,
      validator: validator,
    );
  }
}
