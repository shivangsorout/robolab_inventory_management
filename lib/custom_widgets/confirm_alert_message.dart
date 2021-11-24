import 'package:flutter/material.dart';
import 'package:rim/custom_widgets/custom_button.dart';
import 'package:rim/size_config.dart';

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
      title: Text(
        'Are you sure?',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 4.21 * SizeConfig.textMultiplier!,
          color: Colors.black,
          fontWeight: FontWeight.w500,
          backgroundColor: Colors.white,
        ),
      ),
      content: Text(
        confirmingMessage,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 1.762 * SizeConfig.textMultiplier!,
          color: const Color(0xff666666),
          backgroundColor: Colors.white,
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(
            left: 3.05 * SizeConfig.widthMultiplier!,
            right: 3.05 * SizeConfig.widthMultiplier!,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: 0.489 * SizeConfig.heightMultiplier!,
                  bottom: 1.469 * SizeConfig.heightMultiplier!,
                ),
                child: CustomButton(
                  backgroundColor: const Color(0xff5db075),
                  text: 'Confirm',
                  onPressed: confirmOnPressed,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 0.489 * SizeConfig.heightMultiplier!,
                  bottom: 1.469 * SizeConfig.heightMultiplier!,
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
      contentPadding: EdgeInsets.symmetric(
        horizontal: 10.18 * SizeConfig.widthMultiplier!,
        vertical: 1.958 * SizeConfig.heightMultiplier!,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
    );
  }
}
