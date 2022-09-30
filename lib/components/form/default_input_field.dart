import 'package:flutter/material.dart';
import 'package:pyc_app/constants/constants.dart';

class DefaultInputField extends StatelessWidget {
  final String label;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final TextInputType? keyboardType;
  final String? init;

  const DefaultInputField({
    Key? key,
    required this.label,
    required this.onSaved,
    required this.validator,
    this.keyboardType,
    this.init,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: TextAlign.start,
      keyboardType: keyboardType ?? TextInputType.text,
      style: const TextStyle(
        color: kTextBlackColor,
        fontSize: 20.0,
        fontWeight: FontWeight.w300,
      ),
      decoration: InputDecoration(
        labelText: label,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        isDense: true,
      ),
      onSaved: onSaved,
      validator: validator,
      initialValue: init,
    );
  }
}
