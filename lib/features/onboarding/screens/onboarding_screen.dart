import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../constants/global_constants.dart';
import '../../../main.dart';
import '../../../router.dart';
import '../../../utils/themes/provider/theme_notifier.dart';
import '../../../utils/themes/themedata_provider.dart';
import '../widgets/onboard_items.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int firstPage = 0;
  final PageController _pageController = PageController(initialPage: 0);
  final int _numPages = 3;
  late SharedPreferences prefs;
  bool isFirstLaunch = true;

  @override
  void initState() {
    super.initState();
    _initPreferences();
  }

  Future<void> _initPreferences() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      isFirstLaunch = prefs.getBool('first_launch') ?? true;
      if (kDebugMode) {
        print('Is first launch? $isFirstLaunch');
      } // Debug print
      if (isFirstLaunch) {
        prefs.setBool('first_launch', false);
      }
    });
  }

  void _onPageChanged(int index) {
    setState(() {
      firstPage = index;
    });
  }

  void _skipOnboarding() {
    _pageController.animateToPage(
      _numPages - 1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  void _register() {
    Navigator.of(context).pushNamed(AppRoutes.firstAuthScreen);
  }

  void _login() {
    Navigator.of(context).pushNamed(AppRoutes.login);
  }
  var _darkTheme = true;

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);
    _darkTheme = (theme.getTheme() == darkTheme);
    final ThemeData currentTheme = theme.getTheme();
    return Scaffold(
      backgroundColor: theme.getTheme().scaffoldBackgroundColor,
      body: Column(
        children: [
          SizedBox(height: heightValue27),
          if (firstPage < _numPages - 1)
            Visibility(
              visible: firstPage < _numPages - 1,
              child: Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: _skipOnboarding,
                  child: Text(
                    'Skip',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: heightValue17,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
            ),

          SizedBox(
            height: MediaQuery
                .of(context)
                .size
                .height * 0.7,
            child: PageView(
              controller: _pageController,
              onPageChanged: _onPageChanged,
              children: const [
                OnboardItems(
                    image: "images/Illustration1.png",
                    title: "Welcome to NewsWave",
                    description:
                    "Discover the world of news and blogs in one place."
                        " NewsWave is your gateway to a world of information,"
                        " from politics to lifestyle and everything in between."),
                OnboardItems(
                    image: "images/Illustration2.png",
                    title: "Tailor Your Interests",
                    description: "Tell us what you love! Choose your favorite "
                        "categories, such as sports, technology, or fashion, "
                        "and we'll curate a personalized news and blog feed just"
                        " for you."),
                OnboardItems(
                    image: "images/Illustration3.png",
                    title: "Read Anytime, Anywhere",
                    description:
                    "Stay updated even on the go. With offline reading,"
                        " you can access your favorite articles and blogs wherever you"
                        " are, even without an internet connection.")
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: heightValue25,
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  if (firstPage < _numPages - 1)
                    Visibility(
                      visible: firstPage < _numPages - 1,
                      child: SmoothPageIndicator(
                        controller: _pageController,
                        count: _numPages,
                        effect: ExpandingDotsEffect(
                          dotWidth: widthValue8,
                          dotHeight: heightValue8,
                          dotColor: currentTheme.primaryColor,
                          activeDotColor: Colors.blue,
                        ),
                      ),
                    ),
                  if (firstPage == _numPages - 1)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: _register,
                            child: Container(
                              height: heightValue54,
                              width: widthValue170,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(11.5),
                              ),
                              child: Center(
                                child: Text(
                                  "Register",
                                  style: GoogleFonts.poppins(
                                    fontSize: heightValue17,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: _login,
                            child: Container(
                              height: heightValue54,
                              width: widthValue170,
                              decoration: BoxDecoration(
                                color: currentTheme.primaryColor,
                                borderRadius: BorderRadius.circular(11.5),
                              ),
                              child: Center(
                                child: Text(
                                  "Login",
                                  style: GoogleFonts.poppins(
                                    fontSize: heightValue17,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
