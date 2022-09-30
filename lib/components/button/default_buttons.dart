import 'package:flutter/material.dart';
import 'package:pyc_app/constants/constants.dart';

class DefaultButton extends StatelessWidget {
  final VoidCallback onPress;
  final String title;
  final double radius;

  const DefaultButton({
    Key? key,
    required this.onPress,
    required this.title,
    this.radius = kDefaultValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      style: ElevatedButton.styleFrom(
        backgroundColor: kPrimaryColor,
        minimumSize: const Size(double.infinity, kDefaultValue * 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: kDefaultValue,
          horizontal: kDefaultValue,
        ),
        textStyle: const TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      child: Text(title),
    );
  }
}
