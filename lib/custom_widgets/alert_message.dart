import 'package:flutter/material.dart';
import 'package:rim/size_config.dart';

class AlertMessage extends StatelessWidget {
  final String message;

  const AlertMessage({
    required this.message,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 3.72 * SizeConfig.textMultiplier!,
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: 8.146 * SizeConfig.widthMultiplier!,
        vertical: 4.89 * SizeConfig.heightMultiplier!,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
    );
  }
}
