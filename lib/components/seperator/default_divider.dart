import 'package:flutter/material.dart';

Widget getDefaultDivider({required double width}) {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      border: Border(
        top: BorderSide(color: const Color(0xffF2F2F2), width: width),
      ),
    ),
  );
}
