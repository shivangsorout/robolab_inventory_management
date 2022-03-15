import 'package:flutter/material.dart';
import 'package:rim/size_config.dart';

TextStyle kTitleTextStyle = TextStyle(
  color: Colors.black,
  fontSize: SizeConfig.textMultiplier! * 4,
  fontWeight: FontWeight.w600,
);

EdgeInsetsGeometry kPaddingScreens = EdgeInsets.symmetric(
  horizontal: 4 * SizeConfig.widthMultiplier!,
  vertical: 2 * SizeConfig.heightMultiplier!,
);

final OutlineInputBorder kOutlineBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(10),
  borderSide: const BorderSide(
    color: Color(0xffe8e8e8),
    width: 2.0,
  ),
);

final OutlineInputBorder kRoundedBorder = kOutlineBorder.copyWith(
  borderRadius: BorderRadius.circular(30.0),
);

String getCurrentDate() {
  var date = DateTime.now().toString();
  var dateParse = DateTime.parse(date);
  var formattedDate = "${dateParse.day}/${dateParse.month}/${dateParse.year}";
  return formattedDate.toString();
}
