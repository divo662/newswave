import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/global_constants.dart';

class GoogleButton extends StatefulWidget {
  final String buttonText;
  final VoidCallback onTap;

  const GoogleButton({Key? key, required this.buttonText, required this.onTap})
      : super(key: key);

  @override
  State<GoogleButton> createState() => _GoogleButtonState();
}

class _GoogleButtonState extends State<GoogleButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        widget.onTap;
      },
      child: Center(
        child: Container(
          height: heightValue46,
          width: heightValue369,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey.shade400,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(10.0)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                "assets/icons/google.png",
                width: 100,
                height: 100,
              ),
              Text(
               widget.buttonText,
                style: GoogleFonts.aBeeZee(
                  fontSize: heightValue17,
                  color: Colors.grey.shade800,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
