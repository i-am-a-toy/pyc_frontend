import 'package:flutter/material.dart';
import 'package:pyc_app/constants/constants.dart';

class DefaultStatusButton extends StatelessWidget {
  final VoidCallback onPress;
  final String title;
  final double radius;
  final bool status;

  const DefaultStatusButton({
    Key? key,
    required this.onPress,
    required this.title,
    required this.status,
    this.radius = kDefaultValue / 2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: status ? onPress : null,
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
          fontSize: 16.0,
          fontWeight: FontWeight.w400,
        ),
      ),
      child: Text(title),
    );
  }
}
