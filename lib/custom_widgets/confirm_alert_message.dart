import 'package:flutter/material.dart';
import 'package:rim/custom_widgets/custom_button.dart';

class ConfirmAlertMessage extends StatelessWidget {
  final String confirmingMessage;
  final void Function()? confirmOnPressed;
  final void Function()? cancelOnPressed;

  const ConfirmAlertMessage({
    required this.confirmingMessage,
    required this.confirmOnPressed,
    required this.cancelOnPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Are you sure?',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 45.0,
          color: Colors.black,
          fontWeight: FontWeight.w500,
          backgroundColor: Colors.white,
        ),
      ),
      content: Text(
        confirmingMessage,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 22.0,
          color: Color(0xff666666),
          backgroundColor: Colors.white,
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(
            left: 15.0,
            right: 15.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 5.0,
                  bottom: 15.0,
                ),
                child: CustomButton(
                  backgroundColor: const Color(0xff5db075),
                  text: 'Confirm',
                  onPressed: confirmOnPressed,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 5.0,
                  bottom: 15.0,
                ),
                child: CustomButton(
                  backgroundColor: const Color(0xff5db075),
                  text: 'Cancel',
                  onPressed: cancelOnPressed,
                ),
              ),
            ],
          ),
        )
      ],
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 50.0,
        vertical: 20.0,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
    );
  }
}
