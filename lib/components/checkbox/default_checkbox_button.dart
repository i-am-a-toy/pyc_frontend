import 'package:flutter/material.dart';
import 'package:pyc/common/constants/constants.dart';

class DefaultCheckBox extends StatelessWidget {
  final bool initValue;
  final Function(bool?) onChanged;

  const DefaultCheckBox({
    required this.initValue,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: initValue,
      onChanged: onChanged,
      side: MaterialStateBorderSide.resolveWith(
        (states) => const BorderSide(
          width: 1.5,
          color: kHintTextColor,
        ),
      ),
      checkColor: kPrimaryColor,
      fillColor: MaterialStateProperty.resolveWith(
        (states) => Colors.white,
      ),
    );
  }
}
