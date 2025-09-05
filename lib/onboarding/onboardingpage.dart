import 'package:flutter/material.dart';
import 'package:movie_app/onboarding/onBoarding_data.dart';


class Onboardingpage extends StatelessWidget {
  const Onboardingpage({
    super.key,
    required this.onboardingdata,
    this.onButtonPressed,
    this.onBackPressed,
    this.buttonText,
    this.pageIndex,
  });
  final OnBoarding_Data onboardingdata;
  final VoidCallback? onButtonPressed;
  final VoidCallback? onBackPressed;
  final String? buttonText;
  final int? pageIndex;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Positioned.fill(
          child: Image.asset(onboardingdata.imagepath, fit: BoxFit.cover),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            width: double.infinity,

            decoration: pageIndex == 0
                ? BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  Color(0xff121312).withOpacity(0.10),
                  Color(0xff121312),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
            )
                : BoxDecoration(
              color: Color(0xff121312),
              borderRadius: BorderRadius.circular(16),
            ),
            padding: EdgeInsets.all(screenWidth * 0.04),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  textAlign: TextAlign.center,
                  onboardingdata.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenHeight * 0.03,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                if (onboardingdata.sub_title != null)
                  Text(
                    textAlign: TextAlign.start,
                    onboardingdata.sub_title!,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                SizedBox(height: screenHeight * 0.05),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: onButtonPressed,
                    child: Text(
                      buttonText ?? "Next",
                      style: TextStyle(
                        fontSize: screenHeight * 0.03,
                        color: Colors.black,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffF6BD00),
                      minimumSize: Size(double.infinity, screenHeight * 0.07),
                    ),
                  ),
                ),

                onBackPressed != null
                    ? SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: onBackPressed,
                    child: Text(
                      "back",
                      style: TextStyle(
                        fontSize: screenHeight * 0.03,
                        color: Color(0xffF6BD00),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff121312),
                      side: BorderSide(color: Color(0xffF6BD00)),
                    ),
                  ),
                )
                    : SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}