import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../constants/global_constants.dart';
import '../../../utils/themes/themedata_provider.dart';

class OnboardItems extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  const OnboardItems({super.key,
    required this.image,
    required this.title,
    required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SizedBox(height: heightValue80,),
          Image.asset(image,
            width: widthValue360,
          ),
          SizedBox(height: heightValue50,),
          Text(title,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color:Colors.black,
            fontSize: heightValue20
          ),),
          Text(description,
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade500,
                fontSize: heightValue16,
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
