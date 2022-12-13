import 'package:flutter/material.dart';
import 'package:pyc/common/constants/constants.dart';

class DefaultTextButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final Color? textColor;
  final double? fontSize;
  const DefaultTextButton({
    super.key,
    required this.onTap,
    required this.title,
    this.textColor = kPrimaryColor,
    this.fontSize = 16.0,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        title,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.bold,
          fontSize: fontSize,
        ),
      ),
    );
  }
}
