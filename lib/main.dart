
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newswaves_app/router.dart';
import 'package:newswaves_app/utils/themes/provider/theme_notifier.dart';
import 'package:newswaves_app/utils/themes/themedata_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'features/auth/screens/first_auth_screen.dart';
import 'features/onboarding/screens/onboarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Wait for SharedPreferences to be initialized
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var darkModeOn = prefs.getBool("darkMode") ?? false;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ThemeNotifier(darkModeOn ? darkTheme : lightTheme),
        ),
      ],
      child: const MyApp(),
    ),
  );
}



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);
    if (kDebugMode) {
      print('Initiating SharedPreferences');
    }
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (BuildContext context, AsyncSnapshot<SharedPreferences> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final SharedPreferences prefs = snapshot.data!;
          final bool isFirstLaunch = prefs.getBool('first_launch') ?? true;
          if (kDebugMode) {
            print('Is first launch? $isFirstLaunch');
          }
          return ScreenUtilInit(
            designSize: const Size(375, 812),
            builder: (context, child) {
              return SafeArea(
                child: MaterialApp(
                  title: 'NewsWave',
                  debugShowCheckedModeBanner: false,
                  theme: theme.getTheme(),
                  onGenerateRoute: AppRoutes.generateRoute,
                  initialRoute: isFirstLaunch ? AppRoutes.onboardPage : AppRoutes.homePage,
                  home: isFirstLaunch ? const OnboardingScreen() : const FirstAuthScreen(),
                ),
              );
            },
          );
        } else {
          return const MaterialApp(
            title: 'NewsWave',
            debugShowCheckedModeBanner: false,
            home: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }
}

