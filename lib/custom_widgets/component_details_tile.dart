import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rim/constants.dart';
import 'package:rim/size_config.dart';

class ComponentDetailsTile extends StatelessWidget {
  final String tileName;
  final void Function(String) onChanged;
  final String? errorText;
  final TextEditingController? controller;
  final bool? textFieldEnabled;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  const ComponentDetailsTile({
    Key? key,
    required this.tileName,
    required this.onChanged,
    required this.errorText,
    this.controller,
    this.textFieldEnabled,
    this.keyboardType,
    this.inputFormatters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tileName,
            style: TextStyle(
              color: const Color(0xff666666),
              fontSize: 1.52 * SizeConfig.heightMultiplier!,
            ),
          ),
          SizedBox(
            height: 1.469 * SizeConfig.heightMultiplier!,
          ),
          TextField(
            style: TextStyle(
              fontSize: 1.33 * SizeConfig.heightMultiplier!,
            ),
            inputFormatters: inputFormatters ?? [],
            keyboardType: keyboardType,
            enabled: textFieldEnabled ?? true,
            controller: controller,
            onChanged: onChanged,
            decoration: InputDecoration(
              errorText: errorText,
              hintText: tileName,
              hintStyle: TextStyle(
                fontSize: 1.469 * SizeConfig.heightMultiplier!,
                color: const Color(0xffbdbdbd),
              ),
              filled: true,
              fillColor: const Color(0xfff6f6f6),
              border: kRoundedBorder,
              enabledBorder: kRoundedBorder,
              focusedBorder: kRoundedBorder,
            ),
          ),
        ],
      ),
    );
  }
}
