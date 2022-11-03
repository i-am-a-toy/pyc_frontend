import 'package:flutter/material.dart';
import 'package:pyc/common/constants/constants.dart';

class DefaultPasswordField extends StatefulWidget {
  final String label;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final String? hint;
  final ValueChanged<String>? onChage;

  const DefaultPasswordField({
    Key? key,
    required this.label,
    required this.onSaved,
    required this.validator,
    this.hint,
    this.onChage,
  }) : super(key: key);

  @override
  State<DefaultPasswordField> createState() => _DefaultPasswordFieldState();
}

class _DefaultPasswordFieldState extends State<DefaultPasswordField> {
  bool obscureText = true;
  Icon icon = const Icon(Icons.visibility_off);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      textAlign: TextAlign.start,
      keyboardType: TextInputType.visiblePassword,
      onChanged: widget.onChage,
      cursorColor: kPrimaryColor,
      style: const TextStyle(
        color: kTextBlackColor,
        fontSize: 16.0,
        fontWeight: FontWeight.w300,
      ),
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: widget.hint,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        isDense: true,
        suffixIcon: IconButton(
          icon: icon,
          color: kPrimaryColor,
          onPressed: () {
            setState(() {
              obscureText = !obscureText;
              icon = obscureText
                  ? const Icon(Icons.visibility_off)
                  : const Icon(Icons.visibility);
            });
          },
        ),
      ),
      onSaved: widget.onSaved,
      validator: widget.validator,
    );
  }
}
