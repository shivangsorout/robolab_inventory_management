import 'package:flutter/material.dart';
import 'package:rim/size_config.dart';

class CustomButton extends StatelessWidget {
  final Color backgroundColor;
  final String text;
  final void Function()? onPressed;

  const CustomButton({
    Key? key,
    required this.backgroundColor,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.symmetric(
        horizontal: 4 * SizeConfig.widthMultiplier!,
        vertical: 2 * SizeConfig.heightMultiplier!,
      ),
      onPressed: onPressed,
      color: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 1.6 * SizeConfig.heightMultiplier!,
          color: Colors.white,
        ),
      ),
    );
  }
}
