import 'package:flutter/material.dart';
import 'package:pyc/common/constants/constants.dart';

class DefaultBorderInputField extends StatelessWidget {
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final bool? isRounded;
  final bool? autoFocus;
  final int? maxLine;
  final String? init;
  final String? hint;
  final EdgeInsetsGeometry? contentPadding;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  const DefaultBorderInputField({
    super.key,
    required this.onSaved,
    required this.validator,
    this.autoFocus = false,
    this.contentPadding,
    this.isRounded = false,
    this.prefixIcon,
    this.suffixIcon,
    this.init,
    this.maxLine,
    this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: autoFocus ?? false,
      validator: validator,
      onSaved: onSaved,
      keyboardType: TextInputType.text,
      initialValue: init,
      maxLines: maxLine,
      decoration: InputDecoration(
        contentPadding: contentPadding,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintText: hint,
        hintStyle: const TextStyle(fontSize: 14.0, color: kHintTextColor),
        isDense: true,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: kPrimaryColor, width: 2.0),
          borderRadius: BorderRadius.circular(isRounded! ? 40 : 0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: kPrimaryColor, width: 2.0),
          borderRadius: BorderRadius.circular(isRounded! ? 40 : 0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 2.0),
          borderRadius: BorderRadius.circular(isRounded! ? 40 : 0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 2.0),
          borderRadius: BorderRadius.circular(isRounded! ? 40 : 0),
        ),
      ),
    );
  }
}
