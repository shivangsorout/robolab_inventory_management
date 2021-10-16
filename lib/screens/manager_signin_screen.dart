import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rim/constants.dart';
import 'package:rim/custom_widgets/custom_button.dart';
import 'package:rim/screens/home_screen.dart';

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
          padding: kPaddingScreens,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Manager Sign In',
                textAlign: TextAlign.center,
                style: kTitleTextStyle,
              ),
              const SizedBox(
                height: 130.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (val) {
                      _email = val;
                    },
                    decoration: InputDecoration(
                      hintText: 'Email',
                      hintStyle: const TextStyle(
                        fontSize: 17.0,
                        color: Color(0xffbdbdbd),
                      ),
                      filled: true,
                      fillColor: const Color(0xfff6f6f6),
                      border: kOutlineBorder,
                      enabledBorder: kOutlineBorder,
                      focusedBorder: kOutlineBorder,
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextField(
                    obscuringCharacter: '*',
                    obscureText: _obscureText,
                    onChanged: (val) {
                      _password = val;
                    },
                    decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: const TextStyle(
                        fontSize: 17.0,
                        color: Color(0xffbdbdbd),
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
                          style: const TextStyle(
                            color: Color(0xff5db075),
                            fontSize: 17,
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
                      child: const Text(
                        'Forgot your Password?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Color(0xff5db075),
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
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
