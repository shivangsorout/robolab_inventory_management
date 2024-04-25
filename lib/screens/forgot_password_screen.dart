import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:rim/constants.dart';
import 'package:rim/custom_widgets/alert_message.dart';
import 'package:rim/custom_widgets/custom_button.dart';
import 'package:rim/size_config.dart';
import 'package:rim/utility.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const String id = 'forgot_password_screen';
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  String _email = '';
  String _errorText = '';
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        dismissible: false,
        color: Colors.grey.shade700,
        progressIndicator: const CircularProgressIndicator(
          color: Colors.black,
        ),
        child: Form(
          key: _formKey,
          child: SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 4 * SizeConfig.widthMultiplier!,
                vertical: 2 * SizeConfig.heightMultiplier!,
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new_sharp),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    title: Text(
                      'Forgot Password',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: SizeConfig.textMultiplier! * 4,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    trailing: const Text(' '),
                  ),
                  SizedBox(
                    height: 6 * SizeConfig.heightMultiplier!,
                  ),
                  Text(
                    'If you forgot your password, simply enter your email and we will send you a password reset link.',
                    style: TextStyle(
                      fontSize: 2 * SizeConfig.textMultiplier!,
                    ),
                  ),
                  SizedBox(
                    height: 3 * SizeConfig.heightMultiplier!,
                  ),
                  TextFormField(
                    validator: (value) {
                      if ((value == null || value.isEmpty) ||
                          !value.isEmailValid) {
                        return 'Please enter valid email';
                      }
                      return null;
                    },
                    style: TextStyle(
                      fontSize: 1.4 * SizeConfig.textMultiplier!,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (val) {
                      _email = val;
                      if (_errorText.isNotEmpty) {
                        setState(() {
                          _errorText = '';
                        });
                      }
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
                  Visibility(
                    visible: _errorText.isNotEmpty,
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: SizeConfig.heightMultiplier! * 4),
                      child: Text(
                        _errorText,
                        style: const TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 4 * SizeConfig.heightMultiplier!,
                  ),
                  SizedBox(
                    width: double.maxFinite,
                    child: CustomButton(
                      backgroundColor: const Color(0xff5db075),
                      text: 'Password Reset',
                      onPressed: () async {
                        try {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              isLoading = true;
                            });
                            await FirebaseAuth.instance
                                .sendPasswordResetEmail(email: _email);
                            setState(() {
                              isLoading = false;
                            });
                            if (context.mounted) {
                              Navigator.of(context).pop();
                              showDialog(
                                context: context,
                                builder: (context) => const AlertMessage(
                                  message:
                                      'Your password reset link has been sent successfully!',
                                ),
                              );
                            }
                          }
                        } catch (e) {
                          setState(() {
                            _errorText = e.toString();
                            _errorText =
                                _errorText.replaceAll(RegExp('\\[.*?\\]'), '');
                            isLoading = false;
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
