import 'package:flutter/material.dart';
import 'package:pyc_app/constants/constants.dart';

class DefaultSuffixInputField extends StatelessWidget {
  final String label;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onChange;
  final bool isValid;
  final String? hint;
  final String? init;
  final TextInputType? keyboardType;

  const DefaultSuffixInputField({
    Key? key,
    required this.label,
    required this.onSaved,
    required this.validator,
    required this.isValid,
    required this.onChange,
    this.hint,
    this.keyboardType,
    this.init,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Icon icon = const Icon(Icons.check_circle_rounded);
    return TextFormField(
      textAlign: TextAlign.start,
      keyboardType: keyboardType ?? TextInputType.text,
      onChanged: onChange,
      style: const TextStyle(
        color: kTextBlackColor,
        fontSize: 20.0,
        fontWeight: FontWeight.w300,
      ),
      decoration: InputDecoration(
        labelText: label,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        isDense: true,
        hintText: hint,
        suffixIcon: isValid
            ? IconButton(
                icon: icon,
                color: kPrimaryColor,
                onPressed: () {},
              )
            : null,
      ),
      onSaved: onSaved,
      validator: validator,
      initialValue: init,
    );
  }
}
