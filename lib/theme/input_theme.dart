import 'package:flutter/material.dart';
import 'package:pyc_app/constants/constants.dart';

InputDecorationTheme inputDecorationTheme = const InputDecorationTheme(
  labelStyle: TextStyle(
    fontSize: 18.0,
    color: kSecondaryColor,
    height: 0.5,
  ),
  hintStyle: TextStyle(
    fontSize: 12.0,
    color: kTextLightColor,
    height: 0.5,
  ),
  enabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(
      color: kTextLightColor,
      width: 0.7,
    ),
  ),
  border: UnderlineInputBorder(
    borderSide: BorderSide(
      color: kPrimaryColor,
    ),
  ),
  disabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(
      color: kTextLightColor,
      width: 0.7,
    ),
  ),
  focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(
      color: kPrimaryColor,
      width: 0.7,
    ),
  ),
  errorBorder: UnderlineInputBorder(
    borderSide: BorderSide(
      color: kErrorBorderColor,
      width: 1.2,
    ),
  ),
  focusedErrorBorder: UnderlineInputBorder(
    borderSide: BorderSide(
      color: kErrorBorderColor,
      width: 1.2,
    ),
  ),
);
