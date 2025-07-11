import 'package:flutter/material.dart';
import 'package:weather_app_cellula/features/presentation/pages/log_in_view.dart';
import 'package:weather_app_cellula/features/presentation/pages/sign_up_view.dart';
import 'package:weather_app_cellula/features/presentation/widgets/curve_clipper.dart';
import 'package:weather_app_cellula/features/presentation/widgets/custom_button.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.45,
              width: double.infinity,
              child: Stack(
                children: [
                  ClipPath(
                    clipper: CurveClipper(),
                    child: Container(
                      height: screenHeight * 0.45,
                      width: double.infinity,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: screenHeight * 0.2),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.15),
              child: CustomButton(
                text: "Sign Up",
                backgroundcolor: 0xff014BB4,
                textcolor: 0xffFFFFFF,
                onPressed: () {
                  Navigator.pushNamed(context, SignUpView.routeName);
                },
              ),
            ),

            SizedBox(height: screenHeight * 0.025),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.15),
              child: CustomButton(
                text: "Log In",
                backgroundcolor: 0xffFFFFFF,
                textcolor: 0xff050415,
                onPressed: () {
                  Navigator.pushNamed(context, LogInView.routeName);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
