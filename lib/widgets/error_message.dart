import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/global_constants.dart';


class ErrorMessage extends StatelessWidget {
  final String? message;
  final bool isValid;

  const ErrorMessage({
    super.key,
    required this.isValid,
    this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        isValid ? 'Correct, you can continue \u{1F44D}' : message ?? '',
        style: GoogleFonts.aBeeZee(
          color: isValid ? Colors.green : Colors.red,
          fontSize: heightValue15,
          fontWeight: FontWeight.w500
        ),
      ),
    );
  }
}
