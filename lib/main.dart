import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/firebase_options.dart';
import 'package:movie_app/home_screens/home_screen.dart';
import 'package:movie_app/onboarding/introduction_screen.dart';
import 'package:movie_app/onboarding/preferencesHelper.dart';
import 'package:movie_app/screens/ForgetPasswordScreen.dart';
import 'package:movie_app/screens/Register%20Screen.dart';
import 'package:movie_app/screens/login_screen.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  bool seen = await PreferencesHelper.isOnboardingSeen();
  runApp( MyApp(
      initialOnboardingSeen: seen
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key,required this.initialOnboardingSeen});
  final bool initialOnboardingSeen;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute:initialOnboardingSeen
       ? loginscreen.routeName
       : IntroductionScreen.routeName,
        routes: {
        IntroductionScreen.routeName: (context) => IntroductionScreen(),
        loginscreen.routeName: (context) => loginscreen(),
        RegisterScreen.routeName: (context) => const RegisterScreen(),
        ForgetPasswordScreen.routeName: (context) =>  ForgetPasswordScreen(),
        //HomePage.routeName: (context) => const HomePage(),
      },
    );
  }
}
