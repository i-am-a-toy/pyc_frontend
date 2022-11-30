import 'package:flutter/material.dart';

Widget getDefaultSeperator() {
  return Container(
    width: double.infinity,
    decoration: const BoxDecoration(
      border: Border(
        top: BorderSide(color: Color(0xffF2F2F2), width: 8.0),
      ),
    ),
  );
}
