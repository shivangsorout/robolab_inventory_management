import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rim/constants.dart';
import 'package:rim/custom_widgets/custom_button.dart';
import 'package:rim/screens/home_screen.dart';
import 'package:rim/services/shared_preferences_repository.dart';
import 'package:rim/size_config.dart';

class ManagerSignInScreen extends StatefulWidget {
  static const String id = 'manager_signin_screen';

  @override
  State<ManagerSignInScreen> createState() => _ManagerSignInScreenState();
}

class _ManagerSignInScreenState extends State<ManagerSignInScreen> {
  bool _obscureText = true;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _email = '';
  String _password = '';

  void _toggleObscure() {
    setState(() {
      _obscureText = !_obscureText;
    });
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Manager Sign In',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: SizeConfig.textMultiplier! * 4,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 12 * SizeConfig.heightMultiplier!,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    style: TextStyle(
                      fontSize: 1.4 * SizeConfig.textMultiplier!,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (val) {
                      _email = val;
                    },
                    decoration: InputDecoration(
                      hintText: 'Email',
                      hintStyle: TextStyle(
                        fontSize: 1.4 * SizeConfig.textMultiplier!,
                        color: const Color(0xffbdbdbd),
                      ),
                      filled: true,
                      fillColor: const Color(0xfff6f6f6),
                      border: kOutlineBorder,
                      enabledBorder: kOutlineBorder,
                      focusedBorder: kOutlineBorder,
                    ),
                  ),
                  SizedBox(
                    height: 1.6 * SizeConfig.heightMultiplier!,
                  ),
                  TextField(
                    style: TextStyle(
                      fontSize: 1.4 * SizeConfig.textMultiplier!,
                    ),
                    obscuringCharacter: '*',
                    obscureText: _obscureText,
                    onChanged: (val) {
                      _password = val;
                    },
                    decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: TextStyle(
                        fontSize: 1.4 * SizeConfig.textMultiplier!,
                        color: const Color(0xffbdbdbd),
                      ),
                      filled: true,
                      fillColor: const Color(0xfff6f6f6),
                      border: kOutlineBorder,
                      enabledBorder: kOutlineBorder,
                      focusedBorder: kOutlineBorder,
                      suffix: GestureDetector(
                        onTap: _toggleObscure,
                        child: Text(
                          _obscureText ? 'Show' : 'Hide',
                          style: TextStyle(
                            color: const Color(0xff5db075),
                            fontSize: 1.4 * SizeConfig.textMultiplier!,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: GestureDetector(
                      onTap: () {},
                      child: Text(
                        'Forgot your Password?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: const Color(0xff5db075),
                          fontSize: 1.5 * SizeConfig.textMultiplier!,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 1 * SizeConfig.heightMultiplier!,
                  ),
                  CustomButton(
                    backgroundColor: const Color(0xff5db075),
                    text: 'Sign In',
                    onPressed: () async {
                      try {
                        final signedInUser =
                            await _auth.signInWithEmailAndPassword(
                                email: _email, password: _password);
                        if (signedInUser != null) {
                          _auth.currentUser!.getIdToken().then((value) {
                            SharedPreferencesRepository().save(
                                SharedPreferencesRepository.accessTokenKey,
                                value);
                          });
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.pushNamed(context, HomeScreen.id);
                        }
                      } catch (e) {
                        print(e);
                      }
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
