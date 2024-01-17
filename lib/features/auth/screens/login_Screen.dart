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

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  int activeIndex = 0;
  bool valued = false;
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
              "Welcome Back!",
              style: GoogleFonts.poppins(
                fontSize: 19.sp,
                color: Colors.grey.shade700,
                fontWeight: FontWeight.w500,
                letterSpacing: 1.5,
              ),
            ),
            Text(
              "Login",
              style: GoogleFonts.poppins(
                fontSize: 25.sp,
                color: Colors.black,
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
                      hintText: "Username or email",
                      controller: usernameController,
                      hintTextFontSize: 17.sp,
                      labelText: "Username",
                      labelColor: Colors.black,
                      labelTextFontSize: 17.sp,
                      inputColor: Colors.black,
                      onChanged: (value) {
                        final usernameRegExp = RegExp(r'^[a-zA-Z0-9]{5,}$');
                        final emailRegExp =
                        RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');

                        setState(() {
                          hasInteractedWithUsernameField = true;

                          if (value.isEmpty ||
                              (!usernameRegExp.hasMatch(value) &&
                                  !emailRegExp.hasMatch(value))) {
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
                      message: 'Input your username or email',
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
                      'please input your password. Password must contain at least 1 capital letter, 1 small letter, 1 number, and be 8 or more characters long',
                    ),
                ],
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            FadeInRight(
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.forgottenScreen);
                },
                child: Text(
                  'Forgot Password',
                  style: GoogleFonts.poppins(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
            FadeInRight(
              child: Center(
                child: CustomButton(
                  buttonText: "Login",
                  buttonColor: Colors.blue,
                  onTap: () {
                    Navigator.of(context).pushNamed(AppRoutes.homePage);
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
                  buttonText: "Login with google",
                  onTap: () {}),
            ),
            SizedBox(
              height: 10.h,
            ),
            FadeInRight(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(AppRoutes.firstAuthScreen);
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
                        text: "Don't have an account? ",
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 16.sp),
                      ),
                      TextSpan(
                        text: "Sign Up",
                        style: GoogleFonts.poppins(
                            color: Colors.blue,
                            fontWeight: FontWeight.w500,
                            fontSize: 16.sp),
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
