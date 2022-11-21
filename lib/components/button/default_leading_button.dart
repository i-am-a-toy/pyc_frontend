import 'package:flutter/material.dart';
import 'package:pyc/common/constants/constants.dart';

class DefaultLeadingButton extends StatelessWidget {
  final String text;
  final Widget leading;
  final VoidCallback onTap;
  final Color? colors;
  final double? fontSize;
  final FontWeight? fontWeight;

  const DefaultLeadingButton({
    Key? key,
    required this.text,
    required this.onTap,
    required this.leading,
    this.colors = kPrimaryColor,
    this.fontSize = 14.0,
    this.fontWeight = FontWeight.bold,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          leading,
          kQuarterWidthSizedBox,
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: colors,
              fontSize: fontSize,
              fontWeight: fontWeight,
            ),
          ),
        ],
      ),
    );
  }
}
