import 'package:flutter/material.dart';
import 'package:newswaves_app/features/home%20file/screens/home_screen.dart';
import 'package:newswaves_app/features/search_screen/screens/search_screen.dart';
import 'features/auth/screens/first_auth_screen.dart';
import 'features/auth/screens/login_Screen.dart';
import 'features/auth/screens/verifiy_email_Screen.dart';
import 'features/onboarding/screens/onboarding_screen.dart';

class AppRoutes {
  static const String onboardPage = '/';
  static const login = '/login_screen';
  static const firstAuthScreen = '/first_auth_screen';
  static const emailVerifiy = '/email_verification_screen';
  static const editProfile = '/edit_profile_screen';
  static const homePage = '/home_screen';
  static const searchPage = '/search_page';
  static const forgottenScreen = '/forgotten_password_1';
  static const otpPage = '/otp_page';
  static const changePassword = '/change_password_screen';



  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case onboardPage:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case firstAuthScreen:
        return MaterialPageRoute(builder: (_) => const FirstAuthScreen());
      case emailVerifiy:
        return MaterialPageRoute(builder: (_) => const EmailVerificationScreen());
      case homePage:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case searchPage:
        return MaterialPageRoute(builder: (_) => const SearchScreen());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('Page not found'),
        ),
      );
    });
  }
}
