import 'package:flutter/material.dart';

const TextStyle kTitleTextStyle = TextStyle(
  color: Colors.black,
  fontSize: 50.0,
  fontWeight: FontWeight.w600,
);

const EdgeInsetsGeometry kPaddingScreens = EdgeInsets.all(20.0);

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
