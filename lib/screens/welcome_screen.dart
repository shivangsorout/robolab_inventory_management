import 'package:flutter/material.dart';
import 'package:rim/constants.dart';
import 'package:rim/custom_widgets/custom_button.dart';
import 'package:rim/screens/manager_signin_screen.dart';

class WelcomeScreen extends StatelessWidget {
  static const String id = 'welcome_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: SafeArea(
        child: Padding(
          padding: kPaddingScreens,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text('Robolab Management System',
                  textAlign: TextAlign.center, style: kTitleTextStyle),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 15.0,
                      offset: Offset(0.0, 1.0),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 40.0, bottom: 30.0),
                      child: Image.asset(
                        'assets/images/robot.png',
                        scale: 0.8,
                      ),
                    ),
                    const Text(
                      'Welcome to the Cluster Innovation Centre Robolab Management App. A system for students to easily access the robotic components from lab.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff666666),
                      ),
                    ),
                  ],
                ),
              ),
              CustomButton(
                text: 'Manager Sign In',
                backgroundColor: Colors.black,
                onPressed: () {
                  Navigator.pushNamed(context, ManagerSignInScreen.id);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
