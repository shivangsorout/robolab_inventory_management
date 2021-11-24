import 'package:flutter/material.dart';
import 'package:rim/constants.dart';
import 'package:rim/custom_widgets/custom_button.dart';
import 'package:rim/screens/manager_signin_screen.dart';
import 'package:rim/size_config.dart';

class WelcomeScreen extends StatelessWidget {
  static const String id = 'welcome_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 4 * SizeConfig.widthMultiplier!,
            vertical: 2 * SizeConfig.heightMultiplier!,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Robolab Management System',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: SizeConfig.textMultiplier! * 4,
                  fontWeight: FontWeight.w600,
                ),
              ),
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
                padding: EdgeInsets.symmetric(
                  horizontal: 4 * SizeConfig.widthMultiplier!,
                  vertical: 2 * SizeConfig.heightMultiplier!,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: 4 * SizeConfig.heightMultiplier!,
                        bottom: 3 * SizeConfig.heightMultiplier!,
                      ),
                      child: Image.asset(
                        'assets/images/robot.png',
                        scale: 0.10677 * SizeConfig.heightMultiplier!,
                      ),
                    ),
                    Text(
                      'Welcome to the Cluster Innovation Centre Robolab Management App. A system for students to easily access the robotic components from lab.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 1.9 * SizeConfig.heightMultiplier!,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff666666),
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
