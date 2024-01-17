import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/color_constants.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final Color buttonColor;
  final Color buttonTextColor;
  final VoidCallback onTap;
  final double borderRadius;
  final double buttonHeight;
  final double textFontSize;
  final double buttonWidth;
  final FontWeight textFontWeight;
  const CustomButton({
    Key? key,
    required this.buttonText,
    required this.buttonColor,
    this.buttonTextColor = whiteColor,
    required this.onTap,
    this.borderRadius = 10,
    required this.buttonHeight,
    required this.textFontSize,
    this.buttonWidth = double.infinity,
    this.textFontWeight = FontWeight.w500,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ButtonStyle(
          splashFactory: InkSplash.splashFactory,
          overlayColor: MaterialStatePropertyAll(
            whiteColor.withOpacity(0.2),
          ),
          backgroundColor: MaterialStatePropertyAll(
            buttonColor,
          ),
          fixedSize: MaterialStatePropertyAll(
            Size(buttonWidth, buttonHeight),
          ),
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          )),
      child: Text(
        buttonText,
        style: GoogleFonts.aBeeZee(
          fontSize: textFontSize,
          color: buttonTextColor,
          fontWeight: textFontWeight,
        ),
      ),
    );
  }
}
