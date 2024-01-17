import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../router.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_textform_field.dart';
import '../../../widgets/error_message.dart';
import '../../../widgets/fade_in_right.dart';
import '../../../widgets/google_button.dart';
import '../../../widgets/password_custom_textform_field.dart';

class FirstAuthScreen extends StatefulWidget {
  const FirstAuthScreen({super.key});

  @override
  State<FirstAuthScreen> createState() => _FirstAuthScreenState();
}

class _FirstAuthScreenState extends State<FirstAuthScreen> {
  int activeIndex = 0;
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool isUsernameValid = false;
  bool isEmailValid = false;
  bool isPasswordValid = false;
  bool hasInteractedWithUsernameField = false;
  bool hasInteractedWithEmailField = false;
  bool hasInteractedWithPasswordField = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(8.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 87.h),
            Text(
              "Hello!",
              style: GoogleFonts.poppins(
                fontSize: 21.sp,
                color: Colors.blue,
                fontWeight: FontWeight.w500,
                letterSpacing: 1.5,
              ),
            ),
            Text(
              "Create Your Account",
              style: GoogleFonts.poppins(
                fontSize: 24.sp,
                color: Colors.blueAccent,
                fontWeight: FontWeight.w500,
                wordSpacing: 1.5,
              ),
            ),
            SizedBox(
              height: 3.h,
            ),
            Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 40.h),
                  // Username Input
                  FadeInRight(
                    child: CustomTextFormField(
                      hintText: "Name",
                      controller: usernameController,
                      hintTextFontSize: 17.sp,
                      labelText: "Name",
                      labelColor: Colors.black,
                      labelTextFontSize: 17.sp,
                      inputColor: Colors.black,
                      onChanged: (value) {
                        final usernameRegExp = RegExp(r'^[a-zA-Z0-9]{5,}$');
                        setState(() {
                          hasInteractedWithUsernameField = true;
                          if (value.isEmpty ||
                              !usernameRegExp.hasMatch(value)) {
                            isUsernameValid = false;
                          } else {
                            isUsernameValid = true;
                          }
                        });
                      },
                    ),
                  ),
                  // Username Validation Message
                  if (hasInteractedWithUsernameField)
                    ErrorMessage(
                      isValid: isUsernameValid == true,
                      message: 'Input at least 5 alphanumeric characters',
                    ),
                  SizedBox(height: 15.h),
                  // Email Input
                  FadeInRight(
                    child: CustomTextFormField(
                      hintText: "Email",
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      hintTextFontSize: 17.sp,
                      labelText: "Email",
                      labelColor: Colors.black,
                      labelTextFontSize: 17.sp,
                      inputColor: Colors.black,
                      onChanged: (value) {
                        final emailRegExp =
                        RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
                        setState(() {
                          hasInteractedWithEmailField = true;
                          if (value.isEmpty || !emailRegExp.hasMatch(value)) {
                            isEmailValid = false;
                          } else {
                            isEmailValid = true;
                          }
                        });
                      },
                    ),
                  ),
                  // Email Validation Message
                  if (hasInteractedWithEmailField)
                    ErrorMessage(
                      isValid: isEmailValid == true,
                      message: 'Invalid email format',
                    ),
                  SizedBox(height: 15.h),
                  FadeInRight(
                    child: PasswordTextFormField(
                      hintText: "Input your password",
                      keyboardType: TextInputType.text,
                      controller: passwordController,
                      hintTextColor: Colors.grey.shade500,
                      inputColor: Colors.black,
                      labelText: "Password",
                      labelColor: Colors.black,
                      hintTextFontSize: 17.sp,
                      labelTextFontSize: 17.sp,
                      onChanged: (value) {
                        final passwordRegExp =
                        RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d).{8,}$');
                        setState(() {
                          hasInteractedWithPasswordField = true;
                          if (!passwordRegExp.hasMatch(value)) {
                            isPasswordValid = false;
                          } else {
                            isPasswordValid = true;
                          }
                        });
                      },
                    ),
                  ),
                  // Password Validation Message
                  if (hasInteractedWithPasswordField)
                    ErrorMessage(
                      isValid: isPasswordValid == true,
                      message:
                      'Password must contain at least 1 capital letter, '
                          '1 small letter, 1 number, and be 8 or more'
                          ' characters long',
                    ),
                ],
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            FadeInRight(
              child: Center(
                child: CustomButton(
                  buttonText: "Sign up",
                  buttonColor: Colors.blue,
                  onTap: () {
                    Navigator.of(context).pushNamed(AppRoutes.emailVerifiy);
                  },
                  textFontWeight: FontWeight.w700,
                  buttonHeight: 46.h,
                  buttonWidth: 369.w,
                  textFontSize: 17.sp,
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Divider(
              thickness: 1,
              color: Colors.grey.shade600,
            ),
            SizedBox(
              height: 10.h,
            ),
            FadeInRight(
              child: GoogleButton(
                buttonText: "Sign up with google",
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.firstAuthScreen);
                },
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            FadeInRight(
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.login);
                },
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: GoogleFonts.aBeeZee(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    children: [
                      TextSpan(
                        text: "Already have an account? ",
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 16.sp,
                        ),
                      ),
                      TextSpan(
                        text: "Log in",
                        style: GoogleFonts.poppins(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                          fontSize: 16.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
