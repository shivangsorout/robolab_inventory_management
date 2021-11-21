import 'package:flutter/material.dart';

class AlertMessage extends StatelessWidget {
  final String message;

  const AlertMessage({
    required this.message,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 40.0,
          color: Colors.black,
          fontWeight: FontWeight.w500,
          backgroundColor: Colors.white,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 40.0,
        vertical: 50.0,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
    );
  }
}
