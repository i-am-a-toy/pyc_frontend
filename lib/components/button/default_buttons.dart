import 'package:flutter/material.dart';
import 'package:pyc/common/constants/constants.dart';

class DefaultButton extends StatelessWidget {
  final VoidCallback onPress;
  final String title;
  final double radius;

  const DefaultButton({
    Key? key,
    required this.onPress,
    required this.title,
    this.radius = kDefaultValue / 2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      // null이면 자동으로 비활성화 된다. 상태 값에 따라 null과 onpress를 뿌려주자
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
          fontSize: 16.0,
          fontWeight: FontWeight.w400,
        ),
      ),
      child: Text(title),
    );
  }
}
