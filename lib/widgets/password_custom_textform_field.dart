import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/global_constants.dart';
import '../constants/color_constants.dart';

class PasswordTextFormField extends StatefulWidget {
  final String hintText;
  final Color hintTextColor;
  final Color inputColor;
  final String labelText;
  final Color labelColor;
  final double hintTextFontSize;
  final double labelTextFontSize;
  final Function(String)? onChanged;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final TextEditingController controller;

  const PasswordTextFormField({
    Key? key,
    required this.hintText,
    this.onChanged,
    required this.keyboardType,
    this.validator,
    required this.controller,
    required this.hintTextColor,
    required this.inputColor,
    required this.labelText,
    required this.labelColor,
    required this.hintTextFontSize,
    required this.labelTextFontSize,
  }) : super(key: key);

  @override
  _PasswordTextFormFieldState createState() => _PasswordTextFormFieldState();
}

class _PasswordTextFormFieldState extends State<PasswordTextFormField> {
  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: GoogleFonts.poppins(
        fontSize: widget.hintTextFontSize,
        fontWeight: FontWeight.w500,
        color: widget.inputColor,
      ),
      decoration: InputDecoration(
          border: InputBorder.none,
          hintText: widget.hintText,
          labelText: widget.labelText,
          hintStyle: GoogleFonts.poppins(
            fontSize: widget.hintTextFontSize,
            fontWeight: FontWeight.w500,
            color: widget.hintTextColor,
          ),
          labelStyle: GoogleFonts.poppins(
            fontSize: widget.labelTextFontSize,
            fontWeight: FontWeight.w500,
            color: widget.labelColor,
          ),
          contentPadding: EdgeInsets.all(heightValue10),
          prefixIcon: const Icon(
            CupertinoIcons.padlock_solid,
            color: darkPurple,
          ),
          suffixIcon: GestureDetector(
            onTap: _togglePasswordVisibility,
            child: Image.asset(
              'assets/icons/${_obscureText ? 'close-eye.png' : 'visible-opened-eye-interface-option.png'}',
              color: darkPurple,
              scale: 0.8,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: widthValue2),
            borderRadius: BorderRadius.circular(10.0),
          ),
          floatingLabelStyle: GoogleFonts.aBeeZee(
            fontSize: widget.labelTextFontSize,
            fontWeight: FontWeight.w600,
            color: widget.labelColor,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black, width: 1.5),
            borderRadius: BorderRadius.circular(10.0),
          )),
      obscureText: _obscureText,
      onChanged: widget.onChanged,
      validator: widget.validator,
    );
  }
}
