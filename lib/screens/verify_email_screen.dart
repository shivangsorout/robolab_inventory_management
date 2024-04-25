import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rim/custom_widgets/alert_message.dart';
import 'package:rim/custom_widgets/custom_button.dart';
import 'package:rim/screens/welcome_screen.dart';
import 'package:rim/services/shared_preferences_repository.dart';
import 'package:rim/size_config.dart';

class VerifyEmailScreen extends StatelessWidget {
  static const String id = 'verify_email_screen';
  const VerifyEmailScreen({Key? key}) : super(key: key);

  Future<void> restartLogout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    await SharedPreferencesRepository().clearAll();
    if (context.mounted) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        WelcomeScreen.id,
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 4 * SizeConfig.widthMultiplier!,
            vertical: 2 * SizeConfig.heightMultiplier!,
          ),
          child: Column(
            children: [
              ListTile(
                title: Text(
                  'Verify Email',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: SizeConfig.textMultiplier! * 4,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(
                height: 6 * SizeConfig.heightMultiplier!,
              ),
              Text(
                "We've sent you an email verification. Please open it to verify your account. If you haven't received a verification email yet, press the button below!",
                style: TextStyle(
                  fontSize: 2 * SizeConfig.textMultiplier!,
                ),
              ),
              SizedBox(
                height: 3 * SizeConfig.heightMultiplier!,
              ),
              SizedBox(
                width: double.maxFinite,
                child: CustomButton(
                  backgroundColor: const Color(0xff5db075),
                  text: 'Send email verification',
                  onPressed: () async {
                    final user = FirebaseAuth.instance.currentUser;
                    if (user != null) {
                      await user.sendEmailVerification();
                    } else {
                      await restartLogout(context);
                      if (context.mounted) {
                        showDialog(
                          context: context,
                          builder: (context) => const AlertMessage(
                            message: "It seems that user is logged out!",
                          ),
                        );
                      }
                    }
                  },
                ),
              ),
              SizedBox(
                height: 3 * SizeConfig.heightMultiplier!,
              ),
              SizedBox(
                width: double.maxFinite,
                child: CustomButton(
                  backgroundColor: const Color(0xff5db075),
                  text: 'Restart',
                  onPressed: () async {
                    await restartLogout(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
