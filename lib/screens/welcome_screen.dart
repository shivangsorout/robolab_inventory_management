import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rim/custom_widgets/custom_button.dart';
import 'package:rim/screens/home_screen.dart';
import 'package:rim/screens/manager_signin_screen.dart';
import 'package:rim/screens/verify_email_screen.dart';
import 'package:rim/services/shared_preferences_repository.dart';
import 'package:rim/size_config.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool isLoading = true;
  bool isLoggedIn = false;
  final SharedPreferencesRepository _sharedPreferencesRepository =
      SharedPreferencesRepository();

  void checkLogInStatus() {
    setState(() {
      isLoading = true;
    });
    _sharedPreferencesRepository
        .get(SharedPreferencesRepository.accessTokenKey)
        .then(
      (value) {
        String? token = value;
        if (token != '' && token != null) {
          setState(() {
            isLoggedIn = true;
          });
        } else {
          setState(() {
            isLoggedIn = false;
          });
        }
        if (isLoggedIn) {
          if (FirebaseAuth.instance.currentUser!.emailVerified) {
            Navigator.of(context).pushNamedAndRemoveUntil(
              HomeScreen.id,
              (route) => false,
            );
          } else {
            Navigator.of(context).pushNamedAndRemoveUntil(
              VerifyEmailScreen.id,
              (route) => false,
            );
          }
        }
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
      },
    );
  }

  @override
  void initState() {
    checkLogInStatus();
    super.initState();
  }

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
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 9.5 * SizeConfig.heightMultiplier!,
                ),
                Text(
                  'Inventory Management System',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: SizeConfig.textMultiplier! * 4,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 9.5 * SizeConfig.heightMultiplier!,
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
                        'Welcome to the Inventory Management App. A system for inventory managers to manage their inventory items.',
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
                SizedBox(
                  height: 9.5 * SizeConfig.heightMultiplier!,
                ),
                isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.black,
                          strokeWidth: 2,
                        ),
                      )
                    : Column(
                        children: [
                          SizedBox(
                            width: double.maxFinite,
                            child: CustomButton(
                              text: 'Manager LogIn',
                              backgroundColor: Colors.black,
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  ManagerSignInScreen.id,
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            height: 4 * SizeConfig.heightMultiplier!,
                          ),
                          SizedBox(
                            width: double.maxFinite,
                            child: CustomButton(
                              text: 'Manager SignUp',
                              backgroundColor: const Color(0xff5db075),
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  ManagerSignInScreen.id,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
