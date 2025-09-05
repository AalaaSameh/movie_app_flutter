import 'package:flutter/material.dart';
import 'package:movie_app/onboarding/onBoarding_data.dart';
import 'package:movie_app/onboarding/onboardingpage.dart';
import 'package:movie_app/onboarding/preferencesHelper.dart';
import 'package:movie_app/screens/login_screen.dart';

class IntroductionScreen extends StatefulWidget {
  static const String routeName = "introductionscreen";
  IntroductionScreen({super.key});

  @override
  State<IntroductionScreen> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  PageController pageController = PageController();
  int currentIndex = 0;
  void goToNextPage() {
    if (currentIndex < OnBoarding_Data.OnBoardingList.length - 1) {
      pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      print("Last page reached");
    }
  }

  void onButtonPressed() async {
    if (currentIndex < OnBoarding_Data.OnBoardingList.length - 1) {
      goToNextPage();
    } else {
      await PreferencesHelper.setOnboardingSeen();
      Navigator.of(
        context,
        rootNavigator: true,
      ).pushReplacementNamed(loginscreen.routeName);
      // TO Do آخر صفحة → Finish
      print("Finish pressed!");
    }
  }

  void goToPreviousPage() {
    if (currentIndex > 0) {
      pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      print("Last page reached");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController.addListener(() {
      currentIndex = pageController.page?.toInt() ?? 0;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: pageController,
              itemCount: OnBoarding_Data.OnBoardingList.length,
              itemBuilder: (context, index) => Onboardingpage(
                onboardingdata: OnBoarding_Data.OnBoardingList[index],
                pageIndex: index,
                onButtonPressed: onButtonPressed,
                buttonText: index == 0
                    ? "Explore Now"
                    : index == OnBoarding_Data.OnBoardingList.length - 1
                    ? "Finish"
                    : "Next",
                onBackPressed: (currentIndex == 1 || currentIndex == 0)
                    ? null
                    : goToPreviousPage,
              ),
            ),
          ),
        ],
      ),
    );
  }
}