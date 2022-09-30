import 'package:flutter/material.dart';

bool formCurrentStateValidate(GlobalKey<FormState> formKey) {
  final form = formKey.currentState;
  if (form == null) {
    return false;
  }
  return form.validate();
}

String? requiredFormValidator(String? value) {
  if (value == null || value.isEmpty) {
    return '필수 입력입니다';
  }
  return null;
}
